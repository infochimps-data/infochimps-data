

-- tail -n+2 parkinfo.tsv | ruby -ne 'parkid,parkname,begDate,endDate,active,n_games,lat,lng,allteams,allnames,streetaddr,extaddr,city,state,country,zip,tel,url,url_spanish,logofile,comments = $_.split("\t"); teams = allteams.split(/; /); teams.each{|team| m = /^(...) \((\d+)-(\d+|now)\)( \[alt\])?/.match(team) ; unless m then p team ; next ; end ; teamID, t_begYear, t_endYear, alt = m.captures.to_a; puts [parkid, teamID, t_begYear, t_endYear, alt.nil? ? 0 : 1, n_games].join("\t") }' | sort > park-team-seasons-b.tsv
-- cat parkinfo-all.xml |  ruby -e 'parkID, begYear, endYear = ["","",""]; $stdin.readlines[1..-2].each{|line| case when (line =~ %r{<park parkID="(.....)".*beg="([^"\-]+).*end="([^"\-]+)}) then parkID, begParkYear, endParkYear = [$1, $2, $3] ; when line =~ %r{<team></team>} then next ; when line =~ %r{<team} then line =~ %r{teamID="(...)" beg="([^"]+)" end="([^"]+)" games="(\d+)"(?: neutralsite="(.)")?} or (p line; next) ; by, ey = [$2, $3] ; next if (by == "NULL" && ey == "NULL") ; begUseYear = by[0..3].to_i; endUseYear = (ey =="NULL" ? 2013: ey[0..3].to_i); (begUseYear .. endUseYear).each{|yearID| puts [parkID, $1, yearID, $2, $3, $4, $5||"0"].join("\t") } ; end }'
-- SELECT GROUP_CONCAT(DISTINCT home_teamID), parkID, SUBSTR(gameID, 4,4) AS yearID, COUNT(*) AS n_games, COUNT(DISTINCT home_teamID) AS n_teams
--   FROM games
--   WHERE parkID != ""
--   GROUP BY parkID, yearID
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

LOAD DATA INFILE '/Users/flip/ics/book/big_data_for_chimps/data/sports/baseball/baseball_databank/parks/parkinfo.tsv' REPLACE
  INTO TABLE `parks`
  FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\'
  IGNORE 1 ROWS
  ( `parkid`, `parkname`, `begDate`, `endDate`, `active`, `n_games`, `lat`, `lng`,
  `allteams`, `allnames`, `streetaddr`, `extaddr`, `city`, `state`, `country`,
  `zip`, `tel`, `url`, `url_spanish`, `logofile`, `comments` )
  ;

DROP TABLE IF EXISTS `park_team_years`;
CREATE TABLE `park_team_years` (
  `parkID`    VARCHAR(6) NOT NULL,
  `teamID`    VARCHAR(255) NOT NULL DEFAULT '',
  `yearID`    INT(4) NOT NULL DEFAULT '0',
  `begDate`   DATE DEFAULT NULL,
  `endDate`   DATE DEFAULT NULL,
  `n_games`   INT(4) DEFAULT NULL,
  PRIMARY KEY        (`parkID`,`teamID`,`yearID`),
  UNIQUE KEY  `team` (`teamID`,`yearID`,`parkID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `park_team_years` (parkID, teamID, yearID, begDate, endDate, n_games)
  SELECT
      parkID, home_teamID AS teamID, yearID,
      MIN(game_date) AS begDate, MAX(game_date) AS endDate,
      COUNT(*) AS n_games
    FROM     retrosheet.games
    WHERE    parkID != ""
    GROUP BY parkID, teamID, yearID
    ORDER BY parkID, teamID, yearID
    ;
