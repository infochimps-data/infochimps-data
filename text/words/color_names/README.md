# Color Names 

These are mappings from evocative english phrases ("apple", "bluish green", "baby poop") to RGB values for colors they represent.

See Aubrey Jaffer's [Color Dictionaries](http://people.csail.mit.edu/jaffer/Color/Dictionaries) for highly-detailed description of the dictionaries, with descriptions of their tradeoffs.

Project idea: find the voronoi lattice of the color names (for each color name, the 3-d polygon within which all points are closer to that color name than any other) and make a color picker that grids those polygons onto the screen.

## Color Names: NBS/ISCC (Aubrey Jaffer)

A curated version of the NBS/ISCC "Dictionary of Color Names" -- A compendium of colors and their names from academic, government, textile, dye, paint, horticultural, and manufacturing sources.

These names are good for surface colors; note that among other things this implies white and black are #f2f3f4/#222222, (not #ffffff and #000000).

* **Kenneth L. Kelly and Deanne B. Judd** "Color: Universal Language and Dictionary of Names", National Bureau of Standards, Spec. Publ. 440, Dec. 1976, 189 pages.
* **David A. Mundie**: http://www.anthus.com/Colors/Cent.html converted the NBS Centroid colors from Munsell to CIE XYZ, then converted to Mac QuickDraw RGB.
* **John Foster**: John Foster of the Texas Precancel Club greatly improved the NBS centroids
* **Gretag-Macbeth**: Reconverted supplied Munsell values via Munsell software downloaded from www.gretagmacbeth.com <http://www.gretagmacbeth.com> directly to RGB.  
* **Aubrey Jaffer** curated it into the list seen here. 

Notes:

* Transcription errors from NBS Spec. Publ. 440 have been fixed.
* The duplicated colors have been separated.
* White is now white and the pink bias is eliminated.
* "Pink" and "brown" are used instead of the more logical "pale red" and "dark orange".
* Some of these don't even look right, because some of the bright colors are on the dark fringes with less chroma and are not centered and high up on the hue curves.  
* Many of the original Munsell values (noted) are outside the RGB gamut, and have been adjusted to the closest brightest RGB value by changing chroma until 0 or 255 is reached in one out of bounds RGB component.
* Guesses were made in a few cases (noted) where the color was still illogical compared to the name.

License:

> Copyright © 2003 Voluntocracy.  Permission is granted to copy and distribute modified or unmodified versions of this color dictionary provided the copyright notice and this permission notice are preserved on all copies and the entire such work is distributed under the terms of a permission notice identical to this one.

## Color Names: Name that Color (Chirag Mehta)

The "Name that Color" list,  Created by Chirag Mehta - http://chir.ag/projects/ntc

All the functions, code, lists etc. have been written specifically for the Name that Color JavaScript by Chirag Mehta unless otherwise specified.

This script is released under the: Creative Commons License: Attribution 2.5 http://creativecommons.org/licenses/by/2.5/

It is available in script form at http://chir.ag/projects/ntc/ntc.js

It synthesizes entries from 

* Some code from [Farbtastic](http://www.acko.net/dev/farbtastic) by [Steven Wittens](http://www.acko.net/) was incorporated into this library.
* The [Resene RGB Values List](http://www-swiss.ai.mit.edu/~jaffer/Color/resenecolours.txt) is copyrighted to [Resene Paints Ltd](http://www.resene.co.nz/), 2001.
* The color names in this list were found via [Wikipedia](http://en.wikipedia.org/wiki/List_of_colors), [Crayola](http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors), and [Color-Name Dictionaries](http://people.csail.mit.edu/jaffer/Color/Dictionaries.html).

### Resene colors

For further information refer to http://www.resene.co.nz -- Copyright Resene Paints Ltd 2001

Permission to copy this dictionary, to modify it, to redistribute it, to distribute modified versions, and to use it for any purpose is granted, subject to the following restrictions and understandings.

1. Any text copy made of this dictionary must include this copyright notice in full.

2. Any redistribution in binary form must reproduce this copyright notice in the documentation or other materials provided with the distribution.

3. Resene Paints Ltd makes no warranty or representation that this dictionary is error-free, and is under no obligation to provide any services, by way of maintenance, update, or otherwise.

4. There shall be no use of the name of Resene or Resene Paints Ltd in any advertising, promotional, or sales literature without prior written consent in each case.

5. These RGB colour formulations may not be used to the detriment of Resene Paints Ltd.


## Color Names: XKCD Color Survey

[CC-BY-NC](http://creativecommons.org/licenses/by-nc/2.5/)

Some boring notes on data handling:

For the sake of anyone who might use this, I also snapped three of the 954 colors to corners of the color space when they were hovering almost on the corners and the data was fuzzy; e.g. I moved black from #000102 to #000000. But mostly I left it alone.

There were about 40,000 women and 100,000 men in the main data set used for this, which could in principle skew things (if men are overrepresented and disagree with women over what a particular color is) but when I reran the analysis with the genders separated the results were roughly the same. 

There are a couple of 'again's and 'darker's which are survey artifacts (e.g. 'green again' or 'darker blue') that I missed while cleaning up the table. I can't regen it now, but I've deleted them from rgb.txt.

The algorithm used the hillclimbing setup when there were enough data points available, but for the lowest ones on this list, it used a simple geometric mean of the color values. 

I've normalized the 'gray' spelling to 'grey' since that was more popular among my users, and when colors varied by punctuation (blue-green vs blue green) I used the most popular version. I left "darkgreen" separate from "dark green", because it wasn't always obvious to me that it was a different color word. I also pulled most of the spam and a few other non-color entries. Following Crayola's lead, I also decided to leave out 'skin' and its derivatives from the final list, since that seems to be a whole can of worms; judging from the RGB values, though, my readership skews white and nerdy.

The following names were close enough to others (eg. green blue `06b48b` vs green/blue `01c08d` vs greenblue `23c48b`) that they were culled as duplicates:

	~ light blue                	95d0fc
	~ light green               	96f97b
	~ cloudy blue               	acc2d9
	~ green yellow              	c9ff27
	~ greenblue                 	23c48b
	~ blue purple               	5729ce
	~ blue grey                 	607c8e
	~ dark blue                 	00035b
	~ bluegreen                 	017a79
	~ dark green                	033500
	~ aquamarine                	04d8b2
	~ green blue                	06b48b
	~ blue green                	137e6d
	~ purple blue               	632de9
	~ eggshell                  	ffffd4
	~ bubblegum pink            	fe83cc
	~ orange red                	fd411e
	~ goldenrod                 	fac205
	~ purple pink               	e03fd8
	~ pink purple               	db4bda
	~ terracotta                	ca6641
	~ yellow/green              	c8fd3d
	~ greyblue                  	77a1b5
	~ yellow green              	c0fb2d
	~ grey green                	789b73
	~ blue/grey                 	758da3
	~ grey blue                 	6b8ba4

Source lines, in case that's ever useful:

	cat origin/color_names-x11_rgb.txt | tail -n +2 | ruby -ne 'r, g, b, n = $_.chomp.strip.split(/\s+/, 4); h = "%2s%2s%2s" % [r.to_i.to_s(16), g.to_i.to_s(16), b.to_i.to_s(16)]        ;  puts "%-27s\t%s\t%3d %3d %3d" % [n, h.gsub(/ /, "0"), r, g, b]'  | sort -k2 -t '	' > color_names-x11_rgb.tsv	
	cat origin/color_names-xkcd_rgb-jaff.txt        | ruby -ne 'n, r, g, b = $_.chomp.strip.split(/\s+/, 4); h = "%2s%2s%2s" % [r.to_i.to_s(16), g.to_i.to_s(16), b.to_i.to_s(16)]        ;  puts "%-27s\t%s\t%3d %3d %3d" % [n, h.gsub(/ /, "0"), r, g, b]' > color_names-xkcd_rgb-jaff.tsv
	cat origin/color_names-xkcd_rgb-orig.txt        | ruby -ne 'n, h = $_.chomp.split("\t"); n.strip!; r = h[0..1].to_i(16) ; g = h[2..3].to_i(16) ; b = h[4..5].to_i(16) ;  puts "%-27s\t%s\t%3d %3d %3d" % [n, h.gsub(/ /, "0"), r, g, b]' | sort -k2 -t '	' | grep -v '~' >  color_names-xkcd_rgb.tsv 
	cat origin/color_names-jaffer_nbs_iscc-rgb.txt  | ruby -ne 'h, n = $_.chomp.split("\t"); n.strip!; r = h[0..1].to_i(16) ; g = h[2..3].to_i(16) ; b = h[4..5].to_i(16) ;  puts "%-27s\t%s\t%3d %3d %3d" % [n.gsub(/_/," "), h.gsub(/ /, "0").downcase, r, g, b]' | sort -k2 -t '	' > color_names-jaffer_nbs_iscc-rgb.tsv
	cat origin/color_names-name_that_color.tsv      | ruby -ne 'h, n = $_.chomp.split("\t"); n.strip!; r = h[0..1].to_i(16) ; g = h[2..3].to_i(16) ; b = h[4..5].to_i(16) ;  puts "%-27s\t%s\t%3d %3d %3d" % [n.gsub(/_/," "), h.gsub(/ /, "0").downcase, r, g, b]'     | sort -k2 -t '	' > color_names-name_that_color.tsv
