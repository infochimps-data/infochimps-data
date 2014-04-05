

-- tail -n+2 parkinfo.tsv | ruby -ne 'parkid,parkname,begDate,endDate,active,n_games,lat,lng,allteams,allnames,streetaddr,extaddr,city,state,country,zip,tel,url,url_spanish,logofile,comments = $_.split("\t"); teams = allteams.split(/; /); teams.each{|team| m = /^(...) \((\d+)-(\d+|now)\)( \[alt\])?/.match(team) ; unless m then p team ; next ; end ; teamID, t_begYear, t_endYear, alt = m.captures.to_a; puts [parkid, teamID, t_begYear, t_endYear, alt.nil? ? 0 : 1, n_games].join("\t") }' | sort > park-team-seasons-b.tsv
-- cat parkinfo-all.xml |  ruby -e 'parkID, begYear, endYear = ["","",""]; $stdin.readlines[1..-2].each{|line| case when (line =~ %r{<park parkID="(.....)".*beg="([^"\-]+).*end="([^"\-]+)}) then parkID, begParkYear, endParkYear = [$1, $2, $3] ; when line =~ %r{<team></team>} then next ; when line =~ %r{<team} then line =~ %r{teamID="(...)" beg="([^"]+)" end="([^"]+)" games="(\d+)"(?: neutralsite="(.)")?} or (p line; next) ; by, ey = [$2, $3] ; next if (by == "NULL" && ey == "NULL") ; begUseYear = by[0..3].to_i; endUseYear = (ey =="NULL" ? 2013: ey[0..3].to_i); (begUseYear .. endUseYear).each{|yearID| puts [parkID, $1, yearID, $2, $3, $4, $5||"0"].join("\t") } ; end }' 
-- SELECT GROUP_CONCAT(DISTINCT home_team_id), park_id, SUBSTR(game_id, 4,4) AS yearID, COUNT(*) AS n_games, COUNT(DISTINCT home_team_id) AS n_teams
--   FROM games
--   WHERE park_id != ""
--   GROUP BY park_id, yearID
--   HAVING n_teams > 1
--   ORDER BY yearID

DROP TABLE IF EXISTS `parks`;
CREATE TABLE `parks` (
  `parkID`      VARCHAR(6) NOT NULL,
  `parkname`    VARCHAR(255) DEFAULT NULL,
  `begDate`     DATE DEFAULT NULL,
  `endDate`     DATE DEFAULT NULL,
  `active`      BOOLEAN,
  `n_games`     INT(4),
  `lat`         FLOAT,
  `lng`         FLOAT,
  `allteams`    VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `allnames`    VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `streetaddr`  VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `extaddr`     VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `city`        VARCHAR(100) DEFAULT NULL,
  `state`       VARCHAR(3) DEFAULT NULL,
  `country`     VARCHAR(100) DEFAULT NULL,
  `zip`         VARCHAR(20) DEFAULT NULL,
  `tel`         VARCHAR(20) DEFAULT NULL,
  `url`         VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `url_spanish` VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `logofile`    VARCHAR(255) CHARSET ascii DEFAULT NULL,
  `comments`    VARCHAR(1024) CHARSET ascii DEFAULT NULL,
  PRIMARY KEY (`parkid`),
  KEY         (`begDate`),
  KEY         (`parkname`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/Users/flip/ics/book/big_data_for_chimps/data/sports/baseball/baseball_databank/parkinfo.tsv' REPLACE
  INTO TABLE `parks`
  FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\'
  IGNORE 1 ROWS
  ( `parkid`, `parkname`, `begDate`, `endDate`, `active`, `n_games`, `lat`, `lng`,
  `allteams`, `allnames`, `streetaddr`, `extaddr`, `city`, `state`, `country`,
  `zip`, `tel`, `url`, `url_spanish`, `logofile`, `comments` )
  ;


  
DROP TABLE IF EXISTS `park_team_years`;
CREATE TABLE `park_team_years` (
  `parkID`      VARCHAR(6) NOT NULL,
  `teamID`      VARCHAR(255) DEFAULT NULL,
  `yearID`      INT(4) DEFAULT NULL,
  `begDate`     DATE DEFAULT NULL,
  `endDate`     DATE DEFAULT NULL,
  `n_games`     INT(4),
  `active`      BOOLEAN,
  `alt_site`    BOOLEAN,
  PRIMARY KEY   (`parkID`, `teamID`, `yearID`),
  UNIQUE KEY    team (`teamID`, `yearID`, `parkID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/Users/flip/ics/book/big_data_for_chimps/data/sports/baseball/baseball_databank/park-team-years.tsv' REPLACE
  INTO TABLE `park_team_years`
  FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\'
  ( `parkid`, `teamID`, `yearID`, `begDate`, `endDate`, `n_games`, `alt_site` )
  SET
    active = IF(endDate IS NULL, 1, 0)
  ;

-- --
-- -- Check against Retrosheet
-- --
-- SELECT rs.parkID, rs.teamID, rs.yearID, rs.n_games, pty.n_games, pty.begDate, pty.endDate, rs.begDate, rs.endDate
--   , rs.n_games - pty.n_games AS g_diff, rs.begDate - pty.begDate AS bd_diff, rs.endDate - pty.endDate AS ed_diff
--   FROM
--   (SELECT 
--       park_id AS parkID, home_team_id AS teamID, SUBSTR(game_id, 4,4) AS yearID, 
--       DATE(MIN(SUBSTR(game_id, 4,8))) AS begDate, 
--       DATE(MAX(SUBSTR(game_id, 4,8))) AS endDate, 
--       COUNT(*) AS n_games, COUNT(DISTINCT home_team_id) AS n_teams
--     FROM     retrosheet.games
--     WHERE    park_id != ""
--     GROUP BY park_id, home_team_id, yearID
--     ORDER BY park_id, home_team_id, yearID ) rs
-- 
--   LEFT JOIN (
--     SELECT * FROM park_team_years
--   ) pty
--   ON pty.parkID = rs.parkID AND pty.yearID = rs.yearID AND pty.teamID = rs.teamID
--   
--   WHERE pty.yearID > 1952 AND rs.parkID = "NYC16"
--   -- GROUP BY park_id, yearID
--   -- WHERE pty.parkID IS NULL
--   -- rs.park_ID IS NULL AND 
--   ORDER BY 
--     -- ABS(bd_diff) DESC, ABS(ed_diff) DESC, g_diff DESC, 
--     rs.parkID, rs.yearID, pty.parkID, pty.yearid
--   ;

