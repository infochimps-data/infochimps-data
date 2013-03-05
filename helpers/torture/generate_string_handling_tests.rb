#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

Encoding.default_external = Encoding.default_internal = Encoding::UTF_8
require 'digest/md5'
require 'gorillib/base'
require 'gorillib/pathname'
require 'gorillib/logger/log'

require_relative '../../../lib/wu/munging'
include Wu::Munging::Utils

PREAMBLE = <<-'EOS'

  This file holds string processing and unicode edge cases.  It displays the raw
  text along with encodings that use only keyboard characters (that is, ones
  with ASCII representation `0x20` to `0x7e`).

  Many strings are marked as not "safe" -- they are not valid UTF-8, or not valid Unicode, or contain nulls or tabs. Only the byte-level encodings are given.

  It is valid UTF-8 text with the following columns:

   1. description of the string (ex: `'Internationalization', psedolocalized`)
   2. string length in characters (ex: `20`)
   3. string size as UTF-8 in bytes (ex: `27`)
   4. If UTF-8 and unicode safe, a `1`; `0` otherwise
   5. the raw string, high-byte characters and all (`Iñtërnâtiônàlizætiøn`)
   6. readable bytes, "\x"-escaped: all bytes outside `0x20-0x7e` are replaced with `\xab`, where `ab` is the byte's 2-digit hexadecimal representation
   7. all bytes, as comma-separated list of decimals (ex: `73,195,177,116,195,171,114,110,,...`)

   8. The json-encoded string, with all non-keyboard characters in JSON-escaped  form (ex: `"I\u00f1t\u00ebrn\u00e2ti\u00f4n\u00e0liz\u00e6ti\u00f8n"` )
   9. readable characters, "\u"-escaped: all non-keyboard characters are replaced with `\uabcd`, where `abcd` is the 4-digit unicode code point.
  10. all characters, as decimals, comma-separated (ex: `73,241,116,235,114,110,...`)
  11. all characters, as hexadecimal unicode code points, comma-separated (ex: `0049,00f1,0074,00eb,0072,006e,00e2,0074,0069,...`)

  Items 5 and 8-11 are left blank if the string is not safe; 5 (the raw string) is also omitted if it contains control characters (newline, tab)
EOS

def variants(desc, str, safe)
  arr = [
    "%-40s" % desc,                                   #  0 description
    str.length,                                       #  1 number of characters
    str.bytesize,                                     #  2 number of bytes
    (safe ?   1 : 0),                                 #  3 a `1` if string is safe
    (safe ? str : ''),                                #  4 naked string
    x_escape(str),                                    #  5 readable binary-escaped
    str.bytes.to_a.join(','),                         #  6 all bytes (decimal)
  ]
  if safe
    arr += [
      '['+safe_json_encode(str)+']',                  #  7 json-encoded, all non-ascii escaped
      u_escape(str),                                  #  8 readable unicode-escaped
      str.chars.map{|ch| "%04x" % ch.ord }.join(','), #  9 ordinal of each char (hex)
      str.chars.map{|ch| ch.ord          }.join(','), # 10 ordinal of each char (decimal)
    ]
  else
    arr += [nil, nil, nil, nil]
  end
  arr[4] = '' if desc =~ /^whitespace/
  arr
end

# ***************************************************************************

TEST_STRINGS = [
  ["blank string",                                  ""],
  ["Normal string",                                 "Hello, world"],
  ["Unicode snowman",                               "Hello, snowman: \u2603",],
  ["'Test', psedolocalized",                        "\u0164\u0117\u015f\u0167"],
  ["'Internationalization', psedolocalized",        "I\u00f1t\u00ebrn\u00e2ti\u00f4n\u00e0liz\u00e6ti\u00f8n"],
  ["'Internationalization', psedolocalized",        "I\xc3\xb1t\xc3\xabrn\xc3\xa2ti\xc3\xb4n\xc3\xa0liz\xc3\xa6ti\xc3\xb8n"],
  ["Greek 'kosme'",                                 "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5"],
  ["right to left: Shalom, chimpanzee",             "\u202e\u05e9\u05dc\u05d5\u05dd\u060c \u0634\u0645\u0628\u0627\u0646\u0632\u064a!\u202c",],
  ["'shalom' with Left-to-right override",          "\u202d\u05e9\u05dc\u05d5\u05dd.\u202c"],
  ["'SDRAWKCAB MA I.' w/ right-to-left override",   "\u202eSDRAWKCAB MA I.\u202c"],
  ["'SDRAWKCAB MA I.' w/ right-to-left embed",      "\u202bSDRAWKCAB MA I.\u202c"],
  ["r-t-l: should have TM on right, dot on left",   "\u202e\u05e9\u05dc\u05d5\u05dd \u202bBrawndo\u2122 has elecrolytes\u202c.\u202c"],
  ["r-t-l: 'shalom.'; dot should show on left",     "\u202b\u05e9\u05dc\u05d5\u05dd means peace.\u202c",],
  ["characters have correct order",                 "The vowels \u03b1, \u03b5, \u03b7, \u03b9, \u03bf derive from \u05d0\u200e, \u05d4\u200e, \u05d7\u200e, \u05d9\u200e, \u05e2, resp."],
  ["characters and commas reversed on right",       "The vowels \u03b1, \u03b5, \u03b7, \u03b9, \u03bf derive from \u05d0\u200e, \u05d4, \u05d7, \u05d9, \u05e2, resp."],
  ["null character between 'l' and 'c'",            "null\x00char"],
  ["control chars 0x01..0x0f and 0x7f",             [(1..15).to_a, 127].flatten.map{|ii| ii.chr }.join, false],
  ["diacritic marks: precomposed",                  "\u010f\u0131\u0310\u00e0\ufb4d\u1e5b\u1e2d\u0163\u0623\u045c \u0a33a\u0306\ufb3a\u1e35\u015f"],
  ["diacritic marks: combining",                    "d\u030ci\u0310a\u0300\u05db\u05bfr\u0323i\u0330t\u0327\u0627\u0654\u043a\u0301 \u0a32\u0a3c\u0103\u05da\u05bck\u0331s\u0327"],
  ["zero-width joiners",                            "\u0915\u094d \u0915\u094d\u200d \u0915\u094d\u0937 \u0915\u094d\u200d\u0937"],
  ["zero-width non joiners",                        "Devanagari \u0915\u094d and \u0937 typically form \u0915\u094d\u0937, but with a ZWNJ they show \u0915\u094d\u200c\u0937."],
  #
  ["whitespace (\\s) in ascii",                     "\u0009\u000a\u000b\u000c\u000d\u0020"],
  ["whitespace (\\s) in posix unicode regex",       "\u0009\u000a\u000b\u000c\u000d\u0020\u0085\u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u2028\u2029\u202f\u205f\u3000"],
  ["quotation marks",                               "\"\'\u00ab\u00bb\u2018\u2019\u201a\u201b\u201c\u201d\u201e\u201f\u2039\u203a\u300c\u300d\u300e\u300f\u301d\u301e\u301f\ufe41\ufe42\ufe43\ufe44\uff02\uff07\uff62\uff63",],
  ["punctuation",                                   "\u2019\'[](){}\u27e8\u27e9:,\u060c\u3001\u2014\u2015\u2026,...,...!.\u00ab\u00bb\u2010-?\u2018\u2019,\u201c\u201d,'',"";/\u2044\u00b7&*@\u2022^\u2020,\u2021\u00b0\u3003\u00a1\u00bf#\u2116\u00f7\u00ba,\u00aa%,\u2030\u2031\u00b6\u2032,\u2033,\u2034\u00a7~_\u00a6|\u00a9\u00ae\u2120\u2117\u2122\u00a4\u2042\u261e\u203d\u061f\u25ca\u203b\u2040",],
  # # From PHP Manual (CC-BY)
  ['Valid 2 Octet Sequence',                        "\xc3\xb1", false, ],
  ['Invalid 2 Octet Sequence',                      "\xc3\x28", false, ],
  ['Invalid Sequence Identifier',                   "\xa0\xa1", false, ],
  ['Valid 3 Octet Sequence',                        "\xe2\x82\xa1", false, ],
  ['Invalid 3 Octet Sequence (in 2nd Octet)',       "\xe2\x28\xa1", false, ],
  ['Invalid 3 Octet Sequence (in 3rd Octet)',       "\xe2\x82\x28", false, ],
  ['Valid 4 Octet Sequence',                        "\xf0\x90\x8c\xbc", false, ],
  ['Invalid 4 Octet Sequence (in 2nd Octet)',       "\xf0\x28\x8c\xbc", false, ],
  ['Invalid 4 Octet Sequence (in 3rd Octet)',       "\xf0\x90\x28\xbc", false, ],
  ['Invalid 4 Octet Sequence (in 4th Octet)',       "\xf0\x28\x8c\x28", false, ],
  ['Valid 5 Octet Sequence (but not Unicode!)',     "\xf8\xa1\xa1\xa1\xa1", false, ],
  ['Valid 6 Octet Sequence (but not Unicode!)',     "\xfc\xa1\xa1\xa1\xa1\xa1", false, ],
]

def u_escape(str)
  str.gsub(/\\/, '\\\\').gsub(NON_PLAIN_ASCII_RE){|ch| "\\u%04x" % ch.ord }
end

def x_escape(str)
  str.bytes.map{|byte| (32..126).include?(byte) ? byte.chr : "\\x%02x" % byte }.join
end

def test_variants(str, desc, len, bytesize, utf8p, _, xstr, bytes_dec, safe_json, ustr, chars_hex, chars_dec)
  safe = (utf8p == 1)
  u1 = '"' + ustr.gsub(/\"/, '\\\"') + '"' if safe
  x1 = '"' + ustr.gsub(/\"/, '\\\"') + '"' if safe
  # puts [u1, x1, eval(u1), eval(x1), str, ]

  tests = []
  tests << (len      == str.length)
  tests << (bytesize == str.bytesize)
  tests << (MultiJson.decode(safe_json).first == str) if safe_json.present?
  tests << (eval(u1) == str) if safe
  tests << (eval(x1) == str) if safe
  #
  tests[2] = true if (desc =~ /null character/)
  warn [desc, tests, str, MultiJson.decode('['+safe_json+']').first, safe_json, u1, x1].flatten.join("\t") unless tests.all?
rescue StandardError, SyntaxError => err
  puts err, err.backtrace.first, xstr
end

File.open('string_handling_test.tsv', 'w', encoding: 'UTF-8') do |file|
  TEST_STRINGS.each do |desc, str, safe=true|
    vv = variants(desc, str, safe)
    test_variants(str, *vv).inspect
    # file.puts "%-40s\t%-60s\t%-60s" % vv.values_at(0,4,5)
    file.puts vv.join("\t")
  end
end
