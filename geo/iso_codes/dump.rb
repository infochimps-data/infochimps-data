#!/usr/bin/env ruby

require 'crack'
require 'active_support/inflector/transliterate'
I18n.locale = :en


OUTPUT_PATH = File.dirname(__FILE__)

def assert_keys(name, hsh, keys)
  unless (hsh.keys - keys).empty? then warn "Extra keys in #{name}: #{keys.inspect} vs #{hsh.keys.inspect}" ; end
end

def collection_of(hsh, key)
  arr = hsh[key] or return []
  arr.is_a?(Hash) ? [arr] : arr
end

def walk_tree(name, src_name, part_key)
  tree = Crack::XML.parse( File.open("#{src_name}.xml"))
  key  = "#{src_name}_entries" ; assert_keys(name, tree, [key])
  tree = tree[key]         ; raise "Unexpected keys for #{name}" unless (1..2).include?(tree.keys.length)
  recs = tree[part_key.to_s]
  #
  dump_filename = File.join(OUTPUT_PATH, "#{name}.tsv")
  $stderr.puts "Writing to #{dump_filename}"
  File.open(dump_filename, "w") do |dump_file|
    yield(dump_file, recs)
  end
end


def dump_tree(name, src_name, part_key, fields)
  walk_tree(name, src_name, part_key) do |dump_file, recs|
    recs.each do |rec|
      assert_keys(name, rec, fields)
      rec["numeric_code"] = rec["numeric_code"].to_i if rec.include?("numeric_code")
      vals = rec.values_at(*fields)
      dump_file << vals.join("\t") << "\n"
    end
  end
end

DUMP_INFO = {
  :iso_3166          => [:iso_3166,  'iso_3166_entry',          ["alpha_2_code", "alpha_3_code",                 "numeric_code", "name",  "official_name", "common_name", ] ],
  :iso_3166_3        => [:iso_3166,  'iso_3166_3_entry',        [                "alpha_3_code", "alpha_4_code", "numeric_code", "names", "comment", "date_withdrawn"] ],

  :iso_639           => [:iso_639,   'iso_639_entry',           ["iso_639_1_code", "iso_639_2B_code", "iso_639_2T_code",         "name", ] ],
  :iso_639_3         => [:iso_639_3, 'iso_639_3_entry',         ["id", "part1_code", "part2_code", "scope", "status", "type", "name", "inverted_name", "reference_name"] ],

  :iso_15924         => [:iso_15924, 'iso_15924_entry',         ["alpha_4_code", "numeric_code", "name"] ],
  :iso_4217          => [:iso_4217,  'iso_4217_entry',          ["letter_code",  "numeric_code",  "currency_name", ] ],
  :historic_iso_4217 => [:iso_4217,  'historic_iso_4217_entry', ["letter_code",  "numeric_code",  "currency_name", "date_withdrawn"] ],
}
DUMP_INFO.each do |name, info|
  dump_tree(name, *info)
end

name = :iso_3166_2
walk_tree(name, :iso_3166_2, 'iso_3166_country',) do |dump_file, recs|
  recs.each do |country|
    assert_keys(name, country, ['code', 'iso_3166_subset'])
    country_code = country['code']
    #
    collection_of(country, 'iso_3166_subset').each do |state_info|
      assert_keys(name, state_info, ['type', 'iso_3166_2_entry'])
      state_type = state_info['type']
      #
      collection_of(state_info, 'iso_3166_2_entry').each do |state|
        assert_keys(name, state, ['code', 'name', 'parent'])
        dump_file << [state['code'], country_code, state['parent'], state_type, state['name']].join("\t") << "\n"
      end
    end
  end
end
