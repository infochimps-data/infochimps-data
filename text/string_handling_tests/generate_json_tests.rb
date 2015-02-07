#!/usr/bin/env ruby
# encoding:ASCII-8BIT
Encoding.default_external = Encoding.default_internal = Encoding::ASCII_8BIT

require 'digest/md5'
require 'gorillib/base'
require 'gorillib/pathname'
require 'gorillib/logger/log'

require 'oj'

# curl http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt | md5sum
# da78ef981214e384d5913160ccabbeec

#
# Verify we're encoding-free
#
puts( {
    :LC_LANG => ENV['LC_LANG'], :LC_ALL => ENV['LC_ALL'], :LANG => ENV['LANG'],
    :default_external => Encoding.default_external,
    :default_internal => Encoding.default_internal,
  }.inspect )
raise "Re-run in a shell with 'unset LC_LANG LC_ALL LANG' environment variables" unless ENV['LC_LANG'].nil? && ENV['LC_ALL'].nil? && ENV['LANG'].nil?
raise "Unexpected encodings" unless (Encoding.default_external == Encoding::ASCII_8BIT) && (Encoding.default_internal = Encoding::ASCII_8BIT)


FILES = {
  utf8_original:    { filename: 'UTF-8-test.txt',       desc: 'all as one record in a TSV', md5: 'da78ef981214e384d5913160ccabbeec' },
  tsv_lines:        { filename: 'UTF-8-lines.tsv',      desc: '', md5: '9fdf5dcf25b27b8f4e1e4162de5a82a8' },
  tsv_oneline:      { filename: 'UTF-8-oneline.tsv',    desc: '', md5: 'fa45d7ad65ea96f6fbfdd1ffcac7c250' },
  json_lines:       { filename: 'UTF-8-lines.json',     desc: '', md5: '6a131412d6a15137d1d459688f1e6bb9' },
  json_oneline:     { filename: 'UTF-8-oneline.json',   desc: '', md5: 'cff8b2a184b877cb6712e685cddf1db8' },
  text_valid:       { filename: 'UTF-8-test-valid.txt', desc: '', md5: 'c29f686e250009a37f5f483fd9de3efa' },
}


def check_contents(handle, contents)
  target_md5 = FILES[handle][:md5]
  actual_md5 = Digest::MD5.hexdigest(contents)
  # Log.info([handle, :want, target_md5, :have, actual_md5].join("\t"))
  Log.warn "Failed checksum for #{handle}: want #{target_md5}, got #{actual_md5}" if target_md5 != actual_md5
end

def read_file(handle)
  str = File.read(FILES[handle][:filename], :encoding => "BINARY")
  check_contents(handle, str)
  str
end

def write_file(handle, str)
  check_contents(handle, str)
  File.open(FILES[handle][:filename], 'w', :encoding => "BINARY") do |file|
    file << str << "\n"
  end
end

original      = read_file(:utf8_original).freeze
orig_lines    = original.split("\n").freeze
encoded       = original.gsub(/\\/,"\\\\").gsub(/"/,'\"').gsub(/\x00/, 'NUL')
encoded_lines = encoded.split("\n") + [""]

tsv_lines    = (0 .. encoded_lines.length-1).zip(encoded_lines).map{|num, line| "#{num}\t\"#{line}\"" }.join("\n")
tsv_oneline  = "0\t\"#{encoded_lines.join("\\n")}\""
json_lines   = encoded_lines.map{|line| ['["',line,'"]'].join }.join("\n")
json_oneline = ['["', encoded_lines.join("\\n"), '"]'].join

puts "\n*****************\n  writing files\n*****************\n\n"

write_file(:tsv_lines,    tsv_lines)
write_file(:tsv_oneline,  tsv_oneline)
write_file(:json_lines,   json_lines)
write_file(:json_oneline, json_oneline)
write_file(:text_valid,   [orig_lines[0..69], orig_lines[71..73], orig_lines[76..81] , orig_lines[85..91] ].join("\n"))

#
# JSON lines
#

def check_lines(lines)
  lines[70] = [ lines[70][0..36], "\x00", lines[70][40..-1]].join.force_encoding("ASCII-8BIT")
  contents = lines.join("\n")
  check_contents(:utf8_original, contents)
end

puts "\n*****************\n  checking files\n*****************\n\n"

Log.info "all as one record in a TSV"
lidx, raw_line = File.read('UTF-8-oneline.tsv').chomp.split("\t", 2)
contents = Oj.load("[#{raw_line}]").first.force_encoding("ASCII-8BIT")
contents = [contents[0..4113], "\x00", contents[4117..-1] ].join
check_contents(:utf8_original, contents)

Log.info "all as one record in a JSON array"
contents = Oj.load(File.open('UTF-8-oneline.json')).first.force_encoding("ASCII-8BIT")
contents = [contents[0..4113], "\x00", contents[4117..-1] ].join
check_contents(:utf8_original, contents)

Log.info "each line as a record in a JSON array"
lines = []
File.open('UTF-8-lines.json', :encoding => "BINARY").each do |raw_line|
  lines << Oj.load(raw_line).first.force_encoding("ASCII-8BIT")
end
check_lines(lines)

Log.info "json records in TSV"
lines = []
File.open('UTF-8-lines.tsv', :encoding => "BINARY").each_with_index do |tsv_line, idx|
  next if tsv_line == ""
  lidx, raw_line = tsv_line.chomp.split("\t", 2)
  lines << Oj.load("[#{raw_line}]").first.force_encoding("ASCII-8BIT")
end
check_lines(lines)
contents = lines.join("\n")

# orig_lines.zip(contents.split("\n")).each{|orig,actl|
#   next if orig == actl
#   puts orig.encoding
#   puts actl.encoding
#   puts( [orig, actl, '', (orig.chars.to_a - actl.chars.to_a).join, (actl.chars.to_a - orig.chars.to_a).join] )
# }
#
# original.chars.zip(contents.chars).each{|orig,actl|
#   next if orig == actl
#   print orig.inspect
#   print actl.inspect
# }
