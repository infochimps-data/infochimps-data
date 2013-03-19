SELECT bw.`lahmanID`, bw.`nameCommon`, bw.`playerID`, bw.`yearID`, bw.lgID, bat.`lgID`, bw.PA, bw.G, bat.G, (100 + bat.G - bw.G) AS diffG, bw.`isPitcher`
  FROM `batting_war` bw
  LEFT JOIN Batting bat ON (bw.`playerID` = bat.`playerID`) AND (bw.`yearID` = bat.`yearID`) AND (bw.`stintID` = bat.`stint`)
  WHERE (bw.PA > 0) AND (bat.G != bw.G)
  ORDER BY yearID DESC
  ;

  
