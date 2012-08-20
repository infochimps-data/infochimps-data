#!/usr/bin/env ruby

require 'crack'

OUTPUT_PATH = File.dirname(__FILE__)

def assert_keys(name, hsh, keys)
  unless (hsh.keys - keys).empty? then warn "Extra keys in #{name}: #{keys.inspect} vs #{hsh.keys.inspect}" ; end
end

def collection_of(hsh, key)
  arr = hsh[key] or return []
  arr.is_a?(Hash) ? [arr] : arr
end

def walk_tree(name, filename, part_name, part_key)
  tree = Crack::XML.parse( File.open(filename))
  key  = "#{name}_entries" ; assert_keys(name, tree, [key])
  tree = tree[key]        # ; assert_keys(name, tree, info[:parts].keys)
  recs = tree[part_key.to_s]
  #
  dump_filename = File.join(OUTPUT_PATH, "#{part_name}.tsv")
  $stderr.puts "Writing to #{dump_filename}"
  File.open(dump_filename, "w") do |dump_file|
    yield(dump_file, recs)
  end
end


def dump_tree(name, filename, part_name, part_key, fields)
  walk_tree(name, filename, part_name, part_key) do |dump_file, recs|
    recs.each do |rec|
      assert_keys(part_name, rec, fields)
      vals = rec.values_at(*fields)
      dump_file << vals.join("\t") << "\n"
    end
  end
end

dump_tree(:iso_639,   'iso_639.xml',   :iso_639,           'iso_639_entry',           ["iso_639_1_code", "iso_639_2B_code", "iso_639_2T_code",         "name", ])
dump_tree(:iso_3166,  'iso_3166.xml',  :iso_3166,          'iso_3166_entry',          ["alpha_2_code", "alpha_3_code",                 "numeric_code", "name", "common_name", "official_name"])
dump_tree(:iso_3166,  'iso_3166.xml',  :iso_3166_3,        'iso_3166_3_entry',        [                "alpha_3_code", "alpha_4_code", "numeric_code", "names", "comment", "date_withdrawn"])
dump_tree(:iso_4217,  'iso_4217.xml',  :iso_4217,          'iso_4217_entry',          ["letter_code",  "numeric_code",  "currency_name", ])
dump_tree(:iso_4217,  'iso_4217.xml',  :historic_iso_4217, 'historic_iso_4217_entry', ["letter_code",  "numeric_code",  "currency_name", "date_withdrawn"])
dump_tree(:iso_639_3, 'iso_639_3.xml', :iso_639_3,         'iso_639_3_entry',         ["id", "part1_code", "part2_code", "scope", "status", "type", "name", "inverted_name", "reference_name"])
dump_tree(:iso_15924, 'iso_15924.xml', :iso_15924,         'iso_15924_entry',         ["alpha_4_code", "numeric_code", "name"])


name = :iso_3166_2
walk_tree(:iso_3166_2, 'iso_3166_2.xml', :iso_3166_2, 'iso_3166_country') do |dump_file, recs|
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
        dump_file << [country_code, state['code'], state['parent'], state_type, state['name']].join("\t") << "\n"
      end
    end
  end
end
