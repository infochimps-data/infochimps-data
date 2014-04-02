-- ===========================================================================
--
-- Career Batting Table
--

SELECT NOW() AS starting_datetime, "Find career batting stats";

DROP TABLE IF EXISTS `bat_career`;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bat_career` (
  `lahmanID`    int(11)                DEFAULT NULL,
  `playerID`    varchar(10)            CHARACTER SET ascii DEFAULT NULL,
  `bbrefID`     varchar(9)             CHARACTER SET ascii DEFAULT NULL,
  `retroID`     varchar(9)             CHARACTER SET ascii DEFAULT NULL,
  --
  `nameCommon`  varchar(100)           default NULL,
  `nameFirst`   varchar(50)            default NULL,
  `nameLast`    varchar(50) NOT NULL   default '',
  --
  `years`       smallint(3) unsigned   default NULL,
  `begYear`     int(4)                 default NULL,
  `endYear`     int(4)                 default NULL,
  `hofYear`     smallint(4)            default NULL,
  `votedBy`     varchar(64)            default NULL,
  --
  `G`           int(5) unsigned        default NULL,
  `G_batting`   int(5) unsigned        default NULL,
  `G_allstar`   int(5) unsigned        default NULL,
  --
  `PA`          int(5) unsigned        default NULL,
  `AB`          int(5) unsigned        default NULL,
  `R`           int(5) unsigned        default NULL,
  `H`           int(5) unsigned        default NULL,
  `2B`          int(5) unsigned        default NULL,
  `3B`          int(5) unsigned        default NULL,
  `HR`          int(5) unsigned        default NULL,
  `RBI`         int(5) unsigned        default NULL,
  `SB`          int(5) unsigned        default NULL,
  `CS`          int(5) unsigned        default NULL,
  `BB`          int(5) unsigned        default NULL,
  `SO`          int(5) unsigned        default NULL,
  `IBB`         int(5) unsigned        default NULL,
  `HBP`         int(5) unsigned        default NULL,
  `SH`          int(5) unsigned        default NULL,
  `SF`          int(5) unsigned        default NULL,
  `GIDP`        int(5) unsigned        default NULL,
  `CIB`         int(5)                 default NULL, -- catcher's interference while batting
  --
  `BAVG`        float                  default NULL,
  `TB`          float                  default NULL,
  `SLG`         float                  default NULL,
  `OBP`         float                  default NULL,
  `OPS`         float                  default NULL,
  `ISO`         float                  default NULL,
  --
  `isPitcher`   BOOLEAN                default NULL,
  `RAA`         float                  default NULL,
  `RAA_off`     float                  default NULL,
  `RAA_def`     float                  default NULL,
  `RAR`         float                  default NULL,
  `WAA`         float                  default NULL,
  `WAA_off`     float                  default NULL,
  `WAA_def`     float                  default NULL,
  `WAR`         float                  default NULL,
  `WAR_off`     float                  default NULL,
  `WAR_def`     float                  default NULL,
  --
  PRIMARY KEY             (`lahmanID`),
  UNIQUE KEY `playerID`   (`playerID`),
  UNIQUE KEY `bbrefID`    (`bbrefID`),
  UNIQUE KEY `retroID`    (`retroID`,`bbrefID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1
;

REPLACE INTO bat_career
  (lahmanID, playerID, bbrefID, retroID,
    nameCommon, nameFirst, nameLast,
    years, begYear, endYear,
    hofYear, votedBy,
    G, G_batting, G_allstar,
    AB, R, H, 2B, 3B, HR, RBI,
    SB, CS, BB, SO, IBB, HBP,
    SH, SF, GIDP)

  SELECT
    lahmanID, bat.playerID, bbrefID, retroID,
    peep.nameCommon, nameFirst, nameLast,
    COUNT(DISTINCT bat.yearID) AS years, MIN(bat.yearID) AS begYear,  MAX(bat.yearID) AS endYear,
    hof.yearID AS hofYear, votedBy,
    SUM(bat.G) AS G,  IFNULL(SUM(bat.G_batting),0) AS G_batting, IFNULL(ast.G_allstar,0) AS G_allstar,
    SUM(AB)    AS AB, SUM(R)  AS R,  SUM(H)  AS H,  SUM(2B) AS 2B, SUM(3B)  AS 3B,  SUM(HR)  AS HR,  SUM(RBI) AS RBI,
    SUM(SB)    AS SB, SUM(CS) AS CS, SUM(BB) AS BB, SUM(SO) AS SO, SUM(IBB) AS IBB, SUM(HBP) AS HBP,
    SUM(SH)    AS SH, SUM(SF) AS SF, SUM(GIDP) AS  GIDP
  --
  FROM batting bat
  JOIN `people` peep
    ON bat.`playerID` = peep.`playerID`
  LEFT JOIN (
    SELECT playerID, count(*) AS G_allstar FROM allstarfull ast
      GROUP BY playerID
      ORDER BY G_allstar DESC ) ast
    ON bat.`playerID` = ast.`playerID`
  LEFT JOIN `halloffame` hof
    ON (peep.`hofID` = hof.`hofID`) AND (inducted = 'Y') AND (hof.category = 'Player')
  GROUP BY playerID
;

--
-- Copy over WAR settings from baseball_reference tables
--
UPDATE `bat_career`,
  (SELECT bbrefID, IF(MAX(isPitcher) = "Y", TRUE, FALSE) AS isPitcher,
    SUM(PA) AS PA,
    SUM(runs_above_avg) AS RAA, SUM(runs_above_avg_off) AS RAA_off, SUM(runs_above_avg_def) AS RAA_def,
    SUM(runs_above_rep) AS RAR,
    SUM(WAA) AS WAA, SUM(WAA_off) AS WAA_off, SUM(WAA_def) AS WAA_def,
    SUM(WAR) AS WAR, SUM(WAR_off) AS WAR_off, SUM(WAR_def) AS WAR_def
    FROM `bat_war` GROUP BY bbrefID) wart
  SET
       `bat_career`.`PA`        = wart.`PA`,
       `bat_career`.`RAA`       = wart.`RAA`,
       `bat_career`.`RAA_off`   = wart.`RAA_off`,
       `bat_career`.`RAA_def`   = wart.`RAA_def`,
       `bat_career`.`RAR`       = wart.`RAR`,
       `bat_career`.`WAA`       = wart.`WAA`,
       `bat_career`.`WAA_off`   = wart.`WAA_off`,
       `bat_career`.`WAA_def`   = wart.`WAA_def`,
       `bat_career`.`WAR`       = wart.`WAR`,
       `bat_career`.`WAR_off`   = wart.`WAR_off`,
       `bat_career`.`WAR_def`   = wart.`WAR_def`,
       `bat_career`.`isPitcher` = wart.`isPitcher`
 WHERE `bat_career`.`bbrefID`   = wart.`bbrefID`
 ;

--
-- Calculate derived statistics -- batting average and so forth
--
UPDATE bat_career SET
  BAVG   = (H / AB),
  TB    = (H + 2B + 2 * 3B + 3 * HR),
  SLG   = ((H + 2B + 2 * 3B + 3 * HR) / AB),
  OBP   = ( H + BB + IFNULL(HBP,0) ) / PA,
  CIB   = PA - (AB + BB + IFNULL(HBP,0) + IFNULL(SH,0) + IFNULL(SF,0))
  ;
UPDATE bat_career SET
  OPS   = (SLG + OBP),
  ISO   = ((TB - H) / AB)
  ;


-- ===========================================================================
--
-- Career Pitching Table
--

SELECT NOW() AS starting_datetime, "Find career pitching stats";

DROP TABLE IF EXISTS `pit_career`;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_career` (
  `lahmanID`    int(11)                DEFAULT NULL,
  `playerID`    varchar(10)            CHARACTER SET ascii DEFAULT NULL,
  `bbrefID`     varchar(9)             CHARACTER SET ascii DEFAULT NULL,
  `retroID`     varchar(9)             CHARACTER SET ascii DEFAULT NULL,
  --
  `nameCommon`  varchar(100)           default NULL,
  `nameFirst`   varchar(50)            default NULL,
  `nameLast`    varchar(50) NOT NULL   default '',
  --
  `years`       smallint(3)  unsigned  default NULL,
  `begYear`     int(4)                 default NULL,
  `endYear`     int(4)                 default NULL,
  `hofYear`     smallint(4)            default NULL,
  `votedBy`     varchar(64)            default NULL,
  --
  `W`           smallint(2)  unsigned  default NULL,
  `L`           smallint(2)  unsigned  default NULL,
  `G`           smallint(3)  unsigned  default NULL,
  `GS`          smallint(3)  unsigned  default NULL,
  `GF`          smallint(3)  unsigned  default NULL,
  `CG`          smallint(3)  unsigned  default NULL,
  `SHO`         smallint(3)  unsigned  default NULL,
  `SV`          smallint(3)  unsigned  default NULL,
  `IPouts`      int(5)       unsigned  default NULL,
  `IP`          int(5)       unsigned  default NULL,
  `G_allstar`   int(5)       unsigned  default NULL,
  --
  `H`           smallint(3)  unsigned  default NULL,
  `R`           smallint(3)  unsigned  default NULL,
  `ER`          smallint(3)  unsigned  default NULL,
  `HR`          smallint(3)  unsigned  default NULL,
  `BB`          smallint(3)  unsigned  default NULL,
  `SO`          smallint(3)  unsigned  default NULL,
  `IBB`         smallint(3)  unsigned  default NULL,
  `WP`          smallint(3)  unsigned  default NULL,
  `HBP`         smallint(3)  unsigned  default NULL,
  `BK`          smallint(3)  unsigned  default NULL,
  `BFP`         smallint(6)  unsigned  default NULL,
  --
  `ERA`         float        unsigned  default NULL,
  `WHIP`        float                  default NULL,
  `BAOpp`       float        unsigned  default NULL,
  `H_9`         float                  default NULL,
  `HR_9`        float                  default NULL,
  `BB_9`        float                  default NULL,
  `SO_9`        float                  default NULL,
  `SO_BB`       float                  default NULL,
  --
  `RAA`         float                  default NULL,
  `RAR`         float                  default NULL,
  `WAA`         float                  default NULL,
  `WAR`         float                  default NULL,
  --
  PRIMARY KEY             (`lahmanID`),
  UNIQUE KEY `playerID`   (`playerID`),
  UNIQUE KEY `bbrefID`    (`bbrefID`),
  UNIQUE KEY `retroID`    (`retroID`,`bbrefID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1
;

REPLACE INTO pit_career
  (lahmanID, playerID, bbrefID, retroID,
    nameCommon, nameFirst, nameLast,
    years, begYear, endYear,
    hofYear, votedBy,
    `W`, `L`, `G`, `GS`, `GF`,
    `CG`, `SHO`, `SV`, `IPouts`, `IP`,
    `G_allstar`,
    `H`, `R`, `ER`, `HR`, `BB`, `SO`,
    `IBB`, `WP`, `HBP`, `BK`, `BFP`
    )

  SELECT
    lahmanID, pit.playerID, bbrefID, retroID,
    peep.nameCommon, nameFirst, nameLast,
    COUNT(DISTINCT pit.yearID) AS years, MIN(pit.yearID) AS begYear,  MAX(pit.yearID) AS endYear,
    hof.yearID AS hofYear, votedBy,
    -- pit.stint, pit.teamID, pit.lgID,
    SUM(pit.`W`)      AS `W`, SUM(pit.`L`) AS `L`, SUM(pit.`G`) AS `G`,
    SUM(pit.`GS`)     AS `GS`, SUM(pit.`GF`) AS `GF`, SUM(pit.`CG`) AS `CG`,
    SUM(pit.`SHO`)    AS `SHO`, SUM(pit.`SV`) AS `SV`,
    SUM(pit.`IPouts`) AS `IPouts`, SUM(pit.`IPouts`) / 3.0 AS `IP`,
    IFNULL(ast.G_allstar,0) AS G_allstar,
    SUM(pit.`H`)      AS `H`, SUM(pit.`R`) AS `R`, SUM(pit.`ER`) AS `ER`, SUM(pit.`HR`) AS `HR`,
    SUM(pit.`BB`)     AS `BB`, SUM(pit.`SO`) AS `SO`,
    SUM(pit.`IBB`)    AS `IBB`, SUM(pit.`WP`) AS `WP`, SUM(pit.`HBP`) AS `HBP`,
    SUM(pit.`BK`)     AS `BK`, SUM(pit.`BFP`) AS `BFP`
  --
  FROM pitching pit
  JOIN `people` peep
    ON pit.`playerID` = peep.`playerID`
  LEFT JOIN (
    SELECT playerID, count(*) AS G_allstar FROM allstarfull ast
      GROUP BY playerID
      ORDER BY G_allstar DESC ) ast
    ON pit.`playerID` = ast.`playerID`
  LEFT JOIN `halloffame` hof
    ON (peep.`hofID` = hof.`hofID`) AND (inducted = 'Y') AND (hof.category = 'Player')
  GROUP BY playerID
;

--
-- Calculate derived statistics -- ERA and so forth
--
UPDATE pit_career SET
  WHIP  = ( (BB + H) / (IPouts / 3) ),
  ERA   = ( ER / IP ),
  H_9   = ( H  / (IPouts / 27) ),
  HR_9  = ( HR / (IPouts / 27) ),
  BB_9  = ( BB / (IPouts / 27) ),
  SO_9  = ( SO / (IPouts / 27) ),
  SO_BB = ( SO / BB )
  ;

--
-- Copy over WAR settings from baseball_reference tables
--
UPDATE `pit_career`,
  (SELECT bbrefID,
    SUM(WAA) AS WAA,
    SUM(WAR) AS WAR
    FROM `pit_war` GROUP BY bbrefID) wart
  SET  `pit_career`.`WAA`      = wart.`WAA`,
       `pit_career`.`WAR`      = wart.`WAR`
 WHERE `pit_career`.`bbrefID`  = wart.`bbrefID`
 ;
