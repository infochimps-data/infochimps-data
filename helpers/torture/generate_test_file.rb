#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

Encoding.default_external = Encoding.default_internal = Encoding::UTF_8
require 'digest/md5'
require 'gorillib/base'
require 'gorillib/pathname'
require 'gorillib/logger/log'

require_relative '../../../examples/munging/wikipedia/utils/munging_utils'
include MungingUtils

# ***************************************************************************

TEST_STRINGS = [
  ["blank string",                                  ""],
  ["Normal string",                                 "hello, world"],
  ["Unicode snowman",                               "hello, world. hello, snowman: \u2603",],
  ["'Test', psedolocalized",                        "\u0164\u0117\u015f\u0167"],
  ["'Internationalization', psedolocalized",        "I\u00f1t\u00ebrn\u00e2ti\u00f4n\u00e0liz\u00e6ti\u00f8n"],
  ["'Internationalization', psedolocalized",        "I\xc3\xb1t\xc3\xabrn\xc3\xa2ti\xc3\xb4n\xc3\xa0liz\xc3\xa6ti\xc3\xb8n"],
  ["Greek 'kosme'",                                 "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5"],
  ["Hello, chimp (right to left)",                  "\u202e\u05e9\u05dc\u05d5\u05dd, \u0627\u0644\u0628\u0639\u0627\u0645 \u0634\u064a\u0645\u0628\u0627\u0646\u0632\u064a.\u202c"],
  ["Left-to-right override",                        "\u202d\u05e9\u05dc\u05d5\u05dd.\u202c"],
  ["Right-to-left override",                        "\u202eSDRAWKCAB FORWARDS.\u202c"],
  ["Right-to-left embed",                           "\u202bSDRAWKCAB FORWARDS.\u202c"],
  ["displays TM on right, dot on left",             "\u202e\u05e9\u05dc\u05d5\u05dd \u202bBrawndo\u2122 has elecrolytes\u202c.\u202c"],
  ["dot at end shows on left",                      "\u202b\u05e9\u05dc\u05d5\u05dd means peace.\u202c",],
  ["characters have correct order",                 "The vowels \u03b1, \u03b5, \u03b7, \u03b9, \u03bf derive from \u05d0\u200e, \u05d4\u200e, \u05d7\u200e, \u05d9\u200e, \u05e2, resp."],
  ["characters and commas reversed on right",       "The vowels \u03b1, \u03b5, \u03b7, \u03b9, \u03bf derive from \u05d0\u200e, \u05d4, \u05d7, \u05d9, \u05e2, resp."],
  ["null character",                                "null\x00char"],
  ["control chars 0x01 .. 0x0f and 0x7f",           [(1..15).to_a, 127].flatten.map{|ii| ii.chr }.join, false],
  ["diacritic marks: precomposed",                  "\u010f\u0131\u0310\u00e0\ufb4d\u1e5b\u1e2d\u0163\u0623\u045c \u0a33a\u0306\ufb3a\u1e35\u015f"],
  ["diacritic marks: combining",                    "d\u030ci\u0310a\u0300\u05db\u05bfr\u0323i\u0330t\u0327\u0627\u0654\u043a\u0301 \u0a32\u0a3c\u0103\u05da\u05bck\u0331s\u0327"],
  ["zero-width joiners",                            "\u0915\u094d \u0915\u094d\u200d \u0915\u094d\u0937 \u0915\u094d\u200d\u0937"],
  ["zero-width non joiners",                        "Devanagari \u0915\u094d and \u0937 typically form \u0915\u094d\u0937, but with a ZWNJ they show \u0915\u094d\u200c\u0937."],

  ["whitespace: ascii yes",                         "\u0009\u000a\u000b\u000c\u000d\u0020", false],
  ["whitespace: posix yes",                         "\u0009\u000a\u000b\u000c\u000d\u0020\u0085\u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u2028\u2029\u202f\u205f\u3000", false],
  ["quotation marks",                               "\" \' \u00ab \u00bb \u2018 \u2019 \u201a \u201b \u201c \u201d \u201e \u201f \u2039 \u203a\u300c\u300d\u300e\u300f\u301d\u301e\u301f\ufe41 \ufe42 \ufe43 \ufe44\uff02\uff07\uff62\uff63 ",],
  ["punctuation",                                   "\u2019\'[](){}\u27e8\u27e9:,\u060c\u3001\u2014\u2015\u2026,...,...!.\u00ab\u00bb\u2010-?\u2018\u2019,\u201c\u201d,'',"";/\u2044\u00b7&*@\u2022^\u2020,\u2021\u00b0\u3003\u00a1\u00bf#\u2116\u00f7\u00ba,\u00aa%,\u2030\u2031\u00b6\u2032,\u2033,\u2034\u00a7~_\u00a6|\u00a9\u00ae\u2120\u2117\u2122\u00a4\u2042\u261e\u203d\u061f\u25ca\u203b\u2040",],
]


def u_escape(str) str.gsub(/\\/, '\\\\').gsub(NON_PLAIN_ASCII_RE){|ch| "\\u%04x" % ch.ord } ; end

def x_escape(str)
  str.gsub(NON_PLAIN_ASCII_RE){|ch| ch.unpack('C*').map{|ii| "\\x%02x" % ii }.join }
end

def variants(desc, str, show_raw)
  [ "%-40s" % desc,         # description
    str.length,
    str.bytesize,
    show_raw ? 1 : 0,      # 1 if string is showable
    (show_raw ? str : ''), # naked string
    safe_json_encode(str),  # encoded as JSON
    u_escape(str),
    x_escape(str),
    str.chars.map{|ch| ch.ord          }.join(','),  # ordinal of each character (decimal)
    str.chars.map{|ch| "%04x" % ch.ord }.join(','),  # ordinal of each character (hex)
  ]
end

def test_variants(str, desc, len, bytes, show_raw, _, safe_json, ustr, xstr, *args)
  u1 = '"' + ustr.gsub(/\"/, '\\\"') + '"'
  x1 = '"' + ustr.gsub(/\"/, '\\\"') + '"'
  # puts [u1, x1, str, eval(u1), eval(x1)]

  tests = [
    len   == str.length,
    bytes == str.bytesize,
    MultiJson.decode('['+safe_json+']').first == str,
    eval(u1) == str,
    eval(x1) == str,
  ]
  puts [tests, desc].flatten.join("\t") unless tests.all?
rescue StandardError, SyntaxError => err
  puts err
end

TEST_STRINGS.each do |desc, str, show_raw=true|
  vv = variants(desc, str, show_raw)
  puts vv.join("\t")
  test_variants(str, *vv).inspect

  # puts str
end
