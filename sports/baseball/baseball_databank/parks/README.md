Hello,

I needed a file that had geolocations for each park, and separately wanted to match the BDB team info against the gamelogs database.  I've taken the retrosheet park info from http://retrosheet.org/boxesetc/MISC/PKDIR.htm , the old parkcode.txt http://www.retrosheet.org/parkcode.txt info, these Google Earth files:
  http://bbs.keyhole.com/ubb/download.php?Number=721289 NL
  http://bbs.keyhole.com/ubb/download.php?Number=721294 AL
the MLB team info http://mlb.mlb.com/team/index.jsp and  David Vincent's Alternate Site Games at http://www.retrosheet.org/neutral.htm and http://www.retrosheet.org/neutral19.htm , smashed it together and made a unified file.

The result contains all teams, names and alternate site info from Retrosheet, geolocations, and address and URL info for active teams.

Please enjoy
  http://vizsage.com/apps/baseball/results/parkinfo/parkinfo-all.xml
  -- This is the best format: it lists all the info hierachically; using python's element tree (http://effbot.org/zone/element-index.htm) or perl's XML::Simple (http://search.cpan.org/~grantm/XML-Simple-2.18/lib/XML/Simple.pm) should give you a clean, simple data structur. 

  http://vizsage.com/apps/baseball/results/parkinfo/parkinfo-flatall.csv
  http://vizsage.com/apps/baseball/results/parkinfo/parkinfo-flatall.xml
  -- This is the same file, in .csv and in .xml formats, listing the parks in a flattened (but still parsable) format; it's not a drop-in replacement for parkcodes.txt but it has the same flavor.  If people are interested in a drop-in parkcodes.txt replacement I can spin that off pretty easily.

  Parks
    parkID -- Retrosheet parkID
      name
        -- The current name, or the last name this stadium was known by.
      beg, end, active, games
        -- Dates YYYY-MM-DD for the first and last recorded (according to retrosheet gamelogs) games at that stadium (blank for active or future sites); whether the site is currently the home stadium for an active MLB team; and the total number of gamelogs games at that stadium.
      lat, lng 
        -- Geolocation
      streetaddr, extaddr, city, state, country, zip, tel 
        -- Address
      url, spanishurl  
        -- The main URL for active teams, and the URL for its Spanish-language 
      logofile  
        -- The MLB logo file: prefix http://mlb.mlb.com/mlb/images/team_logos/ to retrieve.  I suppose this should be a full URL, if someone would like to ship me team logos for past teams I'll fix that.

  Teams
    teamID -- Retrosheet teamID, with 'ANA' used for the Los Angeles Angels of Anaheim in Orange County, California, USA, Sol 3, Milky Way, Local Cluster since 1997 to now.
      parkID -- Retrosheet parkID
      beg, end
        -- Dates YYYY-MM-DD the first and last games recorded by that team at that stadium (according to retrosheet gamelogs), blank for active or future sites.
      games
        -- total number of gamelogs games at that stadium by that team.
      altsite
        -- Given as "1" if the site is listed in David Vincent's Alternate Site Games

  OtherNames
    parkID -- Retrosheet parkID
      name
        -- A name this park was known by.  I used the Retrosheet park info from http://retrosheet.org/boxesetc/MISC/PKDIR.htm to list off the official names of each park (flagged with "auth").  If a park was labelled in some way in one of my other sources, it was also thrown on the heap.  This has the unfortunate but unavoidable consequence that, for example, NYC10 "Polo Grounds IV" (retrosheet) has an othername of "Polo Grounds III", while NYC09 "Polo Grounds III" (retrosheet) is aka "Polo Grounds II" (BDB).
      beg, end
        -- For "auth" names, the seasons that the park was marketed under that name
      auth
        -- Was this an official name for the park ('Bank One Ballpark' yes, 'The BOB' no)?
      curr
        -- Is this the current or last-used-while-MLB-active name for the park?

  Comments
    parkID -- Retrosheet parkID
    comment
      -- comments for each site.  There may be some parkcodes.txt cruft left in there.

The flat files give all of the above in the format
  "parkID","name","beg","end","active","games","lat","lng","allteams","allnames","streetaddr","extaddr","city","state","country","zip","tel","url","spanishurl","logofile","allcomments"
where 
  allteams lists each 'team (beg-end) [alt]', with end=>'now' for an active park, separated by '; ', and with '[alt]' appended to alternate-site games
  allnames lists each 'name (beg-end)', auth names first, with end=>'now' for an active park, separated by '; ', and no dates for a non-auth team.
  allcomments lists the comments separated by ' | ' in some arbitrary order.

I've left five 'proposed' stadiums in the set, including the future NYA stadium and a few others whose status I'm unsure of.  These are easy enough to remove if the idea offends.

Seamheads:

```
^\([^
	]+\)	\(.+?\)
\([0-9]+/[0-9]+/[0-9]+\)
\([0-9]+/[0-9]+/[0-9]+
\)? ?	
\([0-9]+\)
\([0-9]+\)
 	
\(-?[0-9]+\.[0-9]+\)
\(-?[0-9]+\.[0-9]+\)
\([0-9]+\)
 	
Map
Map
```

```
^[ 	]+<tr.*
.*onmouse.*
.*onmouse.*
.*bgcolo.*
.*td.*parkID=\(.....\)">\([^<]+\)</a>
.*td.*
.*<a href="city\.php\?City=[^"]+">\([^<]+\)</a>
.*td.*
[^0-9/]*\([0-9]+/[0-9]+/[0-9]+\).*
[^/0-9]+\([0-9]+/[0-9]+/[0-9]+\)?.*</div.*</td.*
.*nbsp.*
[^0-9]*[0-9]+.*div.*td.*
[^0-9]*\([0-9]+\).*div.*td.*
.*nbsp.*
[^0-9]*\(-?[0-9]+\.[0-9]+\).*div.*td.*
[^0-9\-]*\(-?[0-9]+\.[0-9]+\).*div.*td.*
[^0-9]*\([0-9]+\).*div.*td.*
.*nbsp.*
.*
.*left.*
.*
.*
.*</tr>.*
```

PS If you enjoyed playing with the Google Earth thing, I'd also like to point to these other Google Earth files:
  All Minor Lg http://bbs.keyhole.com/ubb/placemarks/997756-minorleague.kmz     
  AAA Stadiums http://bbs.keyhole.com/ubb/download.php?Number=47579		
  Football http://bbs.keyhole.com/ubb/download.php?Number=12353		
which give geolocations (and neat-o team logos) for minor league and football stadiums.


	-- Flatten the parks table into one flat jumble
	SELECT P.parkID, T.allteams, 
		P.name, N.allnames, 
		P.beg, P.end, P.active, P.games,
		P.lat, P.lng,
		P.streetaddr, P.extaddr, P.city, P.state, P.country, P.zip, P.tel,
		P.url, P.spanishurl, P.logofile,
		C.allcomments
	 -- ,	P.*, TP.*
	FROM    	Parks_parks      P
	LEFT JOIN 	(SELECT MIN(T.beg) AS beg_t, MAX(IFNULL(T.end,'9999-12-31')) AS end_t, SUM(T.games) AS games_t,
				GROUP_CONCAT(DISTINCT CONCAT(T.teamID,' (',YEAR(beg),'-',IFNULL(YEAR(end),'now'),')', IF(T.neutralsite,' [alt]','')) ORDER BY T.neutralsite ASC, T.teamID  DESC SEPARATOR '; ') AS allteams, T.*
				FROM	Parks_teams T GROUP BY parkID) T ON P.parkID=T.parkID
	LEFT JOIN 	(SELECT GROUP_CONCAT(DISTINCT CONCAT(N.name, IF(beg IS NOT NULL, CONCAT(' (',beg,'-',IFNULL(end,'now'),')'),'')) 
				    ORDER BY N.curr DESC, N.auth DESC, N.beg, N.name DESC SEPARATOR '; ') AS allnames, N.*
				FROM  Parks_othernames N GROUP BY parkID ) N ON P.parkID=N.parkID
	LEFT JOIN 	(SELECT GROUP_CONCAT(DISTINCT C.comment ORDER BY C.comment DESC SEPARATOR ' | ') AS allcomments, C.parkID
				FROM	Parks_comts C GROUP BY parkID) C  ON P.parkID=C.parkID
	LEFT JOIN	(SELECT TPY.teamID, TPY.parkID, MIN(TPY.beg) AS beg_tpy, MAX(TPY.end) AS end_tpy, SUM(TPY.games) as games_tpy 
				FROM TeamParkYears TPY GROUP BY parkID) TP ON P.parkID=TP.parkID
	GROUP BY	P.parkID
	ORDER BY 	P.active, P.parkID

	-- Check that new parks agrees with gamelogs and new teams
	SELECT P.parkID,
		DATEDIFF(P.beg, beg_tpy) AS tpybCk, (P.end=TP.end_tpy) OR (YEAR(end_tpy)=2006 AND P.end IS NULL)       AS tpyeCk, P.games - games_tpy AS tpyeCk,
		DATEDIFF(P.beg, beg_t)   AS tbCk,    (((T.end_t='9999-12-31') AND (P.end IS NULL)) OR (P.end=T.end_t)) AS teCk,   P.games - games_t   AS tgCk,
		T.allteams, N.allnames, C.allcomments, 
		TP.*, P.*
	FROM    	Parks_parks      P
	LEFT JOIN 	(SELECT MIN(T.beg) AS beg_t, MAX(IFNULL(T.end,'9999-12-31')) AS end_t, SUM(T.games) AS games_t,
				GROUP_CONCAT(DISTINCT CONCAT(T.teamID,' (',YEAR(beg),'-',IFNULL(YEAR(end),'now'),')') ORDER BY T.teamID  DESC SEPARATOR '; ') AS allteams, T.*
				FROM	Parks_teams T GROUP BY parkID) T ON P.parkID=T.parkID
	LEFT JOIN 	(SELECT GROUP_CONCAT(DISTINCT CONCAT(N.name, IF(beg IS NOT NULL, CONCAT(' (',beg,'-',IFNULL(end,'now'),')'),'')) 
				    ORDER BY N.auth, N.beg, N.name DESC SEPARATOR '; ') AS allnames, N.*
				FROM  Parks_othernames N GROUP BY parkID ) N ON P.parkID=N.parkID
	LEFT JOIN 	(SELECT GROUP_CONCAT(DISTINCT C.comment ORDER BY C.comment DESC SEPARATOR ' | ') AS allcomments, C.parkID
				FROM	Parks_comts C GROUP BY parkID) C  ON P.parkID=C.parkID
	LEFT JOIN	(SELECT TPY.teamID, TPY.parkID, MIN(TPY.beg) AS beg_tpy, MAX(TPY.end) AS end_tpy, SUM(TPY.games) as games_tpy 
				FROM TeamParkYears TPY GROUP BY parkID) TP ON P.parkID=TP.parkID
	GROUP BY	P.parkID
	ORDER BY tpybCk, tpyeCk, tpyeCk, tbCk, teCk, tgCk,  TP.parkID

	-- New Teams table agrees with Gamelogs
	SELECT (beg_tpy=beg) as bChk, (end_tpy=end OR (YEAR(end_tpy)=2006 AND end IS NULL)) as eChk, (games=games) as gChk, Q.*
	  FROM	(SELECT TPY.teamID, TPY.parkID, MIN(TPY.beg) AS beg_tpy, MAX(TPY.end) AS end_tpy, SUM(TPY.games) as games_tpy
	  ,		T.beg, T.end, T.games, T.parknameBDB
	  FROM		TeamParkYears TPY
	  LEFT JOIN	Parks_teams   T ON (T.teamID=TPY.teamID) AND (T.parkID=TPY.parkID)
	  GROUP BY	TPY.teamID, TPY.parkID) Q

	-- team-park-years from Gamelogs
	CREATE TABLE vizsagedb_foo.TeamParkYears
		SELECT G.h_team AS teamID, G.park_ID AS parkID, YEAR(G.date) AS yearID
		  , 	MIN(G.date) AS beg, MAX(G.date) AS end
		  ,		COUNT(*) AS games
		  ,		GROUP_CONCAT(DISTINCT G.h_league) as gLgs
		  FROM		vizsagedb_retrosheet.GamesFlat   G 
		  GROUP BY	G.h_team, YEAR(G.date), G.park_ID 

	-- New parks table agrees with rshtml and mostly with parkcodes.txt
	SELECT 
		DATEDIFF(P.beg_pc, P.beg)   AS pcbDiff, DATEDIFF(P.end_pc, P.end)   AS pceDiff,
		YEAR(P.beg_rsh)-YEAR(P.beg) AS rsbDiff, YEAR(P.end_rsh)-IFNULL(YEAR(P.end),2006) AS rseDiff
	  ,	P.beg_pc, P.beg, P.end_pc, P.end, P.* FROM Parks_parks P
	  ORDER BY ABS(rsbDiff) DESC, ABS(rseDiff) DESC, ABS(pcbDiff) DESC, ABS(pceDiff) DESC, parkID 


	-- examing neutral games
	SELECT CONCAT(Q.teamID, ' played ', Q.games, ' games here as an alternate (neutral) site from ', beg_neut, ' until ', end_neut, IF(Q.comment='', '', CONCAT(': ', Q.comment)) ) AS neutralsite_comment,  
		Q.*, T.neutralsite, T.*, P.*
	  FROM		Parks_teams T
	  LEFT JOIN	(SELECT N.parkID, COUNT(*) AS games,
	       IFNULL(G.h_team, CASE P.parkID WHEN 'BOS07' THEN 'BSN' WHEN 'BOS08' THEN 'BOS' WHEN 'CHI10' THEN 'CHN' WHEN 'LBV01' THEN 'TBA' WHEN 'MIL06' THEN 'CLE' ELSE '????' END) AS teamID,
	       MIN(N.gamedate) AS beg_neut, MAX(N.gamedate) AS end_neut, N.comment, N.h_lg
		FROM 		Parks_neutralgames N
		  LEFT JOIN	Parks_parks P ON (P.parkID = N.parkID) 
		  LEFT JOIN	vizsagedb_retrosheet.GamesFlat G
				ON	(G.date = N.gamedate) 
			AND (G.park_ID = N.parkID) 
			AND ((G.gameNumInDay = N.gnum_in_day) 	OR (gamedate='1899-09-24' AND h_team='CL4')) 
			AND ((G.h_league = N.h_lg) 				OR (gamedate='1877-09-22'))
		  LEFT JOIN	Parks_teams T ON (T.teamID = G.h_team) AND (T.parkID = P.parkID)
		GROUP BY N.parkID, T.teamID, N.comment
		ORDER BY N.parkID
		) Q ON T.parkID=Q.parkID AND T.teamID=Q.teamID
	  LEFT JOIN	Parks_parks P ON P.parkID=Q.parkID
	  GROUP BY T.parkID, T.teamID
	  ORDER BY T.neutralsite DESC, T.games, T.parkID, Q.parkID, T.parkID, T.teamID

