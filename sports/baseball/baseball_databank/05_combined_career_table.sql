-- ===========================================================================
--
-- Combined Career Table
--

DROP TABLE IF EXISTS `career_all`;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `career_all` (
  `lahmanID`    int(11)               DEFAULT NULL,
  `playerID`    varchar(10)           DEFAULT NULL,
  `bbrefID`     varchar(9)            DEFAULT NULL,
  `retroID`     varchar(9)            default NULL,
  --
  `nameCommon`  varchar(100)          default NULL,
  `nameFirst`   varchar(50)           default NULL,
  `nameLast`    varchar(50) NOT NULL  default '',
  `nameGiven`   varchar(255)          default NULL,
  `nameNick`    varchar(255)          default NULL,
  --
  `years`       smallint(3) unsigned  default NULL,
  `begYear`     int(4)                default NULL,
  `endYear`     int(4)                default NULL,
  `hofYear`     smallint(4)           default NULL,
  `votedBy`     varchar(64)           default NULL,
  --
  `G`           int(5) unsigned       default NULL,
  `G_batting`   int(5) unsigned       default NULL,
  `G_pitching`  int(5) unsigned       default NULL,
  `G_allstar`   int(5) unsigned       default NULL,
  `isPitcher`   enum('Y','N')         default NULL,
  --
  `PA`          int(5) unsigned       default NULL,
  `AB`          int(5) unsigned       default NULL,
  `R`           int(5) unsigned       default NULL,
  `H`           int(5) unsigned       default NULL,
  `2B`          int(5) unsigned       default NULL,
  `3B`          int(5) unsigned       default NULL,
  `HR`          int(5) unsigned       default NULL,
  `RBI`         int(5) unsigned       default NULL,
  `SB`          int(5) unsigned       default NULL,
  `CS`          int(5) unsigned       default NULL,
  `BB`          int(5) unsigned       default NULL,
  `SO`          int(5) unsigned       default NULL,
  `IBB`         int(5) unsigned       default NULL,
  `HBP`         int(5) unsigned       default NULL,
  `SH`          int(5) unsigned       default NULL,
  `SF`          int(5) unsigned       default NULL,
  `CIB`         int(5) unsigned       default NULL,
  `GIDP`        int(5) unsigned       default NULL,
  --
  `BAVG`        float                 default NULL,
  `TB`          float                 default NULL,
  `SLG`         float                 default NULL,
  `OBP`         float                 default NULL,
  `OPS`         float                 default NULL,
  `ISO`         float                 default NULL,
  --
  `W`           smallint(2)  unsigned default NULL,
  `L`           smallint(2)  unsigned default NULL,
  `GS`          smallint(3)  unsigned default NULL,
  `GF`          smallint(3)  unsigned default NULL,
  `CG`          smallint(3)  unsigned default NULL,
  `SHO`         smallint(3)  unsigned default NULL,
  `SV`          smallint(3)  unsigned default NULL,
  `IPouts`      int(5)       unsigned default NULL,
  `IP`          int(5)       unsigned default NULL,
  --
  `HA`          smallint(3)  unsigned default NULL,
  `RA`          smallint(3)  unsigned default NULL,
  `ER`          smallint(3)  unsigned default NULL,
  `HRA`         smallint(3)  unsigned default NULL,
  `BBA`         smallint(3)  unsigned default NULL,
  `SOA`         smallint(3)  unsigned default NULL,
  `IBBA`        smallint(3)  unsigned default NULL,
  `WP`          smallint(3)  unsigned default NULL,
  `HBPA`        smallint(3)  unsigned default NULL,
  `BK`          smallint(3)  unsigned default NULL,
  `BFP`         smallint(6)  unsigned default NULL,
  --
  `ERA`         float        unsigned default NULL,
  `WHIP`        float                 default NULL,
  `BAOpp`       float        unsigned default NULL,
  `H_9`         float                 default NULL,
  `HR_9`        float                 default NULL,
  `BB_9`        float                 default NULL,
  `SO_9`        float                 default NULL,
  `SO_BB`       float                 default NULL,
  --
  `RAA`         float                 default NULL,
  `RAA_off`     float                 default NULL,
  `RAA_def`     float                 default NULL,
  `RAA_pit`     float                 default NULL,
  `RAR`         float                 default NULL,
  `RAR_pit`     float                 default NULL,
  `WAA`         float                 default NULL,
  `WAA_off`     float                 default NULL,
  `WAA_def`     float                 default NULL,
  `WAA_pit`     float                 default NULL,
  `WAR`         float                 default NULL,
  `WAR_off`     float                 default NULL,
  `WAR_def`     float                 default NULL,
  `WAR_pit`     float                 default NULL,
  --
  `birthYear`   int(4)                default NULL,
  `birthMonth`  int(2)                default NULL,
  `birthDay`    int(2)                default NULL,
  `birthCountry` varchar(50)          default NULL,
  `birthState`  char(2)               default NULL,
  `birthCity`   varchar(50)           default NULL,
  `deathYear`   int(4)                default NULL,
  `deathMonth`  int(2)                default NULL,
  `deathDay`    int(2)                default NULL,
  `deathCountry` varchar(50)          default NULL,
  `deathState`  char(2)               default NULL,
  `deathCity`   varchar(50)           default NULL,
  `weight`      int(3)                default NULL,
  `height`      double(4,1)           default NULL,
  `bats`        enum('L','R','B')     default NULL,
  `throws`      enum('L','R','B')     default NULL,
  `college`     varchar(50)           default NULL,
  --
  `debut`       varchar(10)           DEFAULT NULL,
  `finalGame`   varchar(10)           DEFAULT NULL,
  --
  PRIMARY KEY      (`lahmanID`),
  UNIQUE KEY `playerID`   (`playerID`),
  UNIQUE KEY `bbrefID`    (`bbrefID`),
  UNIQUE KEY `retroID`    (`retroID`,`bbrefID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1
;

REPLACE INTO career_all
  (lahmanID, playerID, bbrefID, retroID,
    nameCommon, nameFirst, nameLast, nameGiven, nameNick,
    --
    years, begYear, endYear, hofYear, votedBy,
    G, G_batting, `G_pitching`, G_allstar, `isPitcher`,
    --
    PA, AB, R, H, 2B, 3B,
    HR, RBI, SB, CS, BB, SO,
    IBB, HBP, SH, SF, CIB, GIDP,
    `BAVG`, `TB`, `SLG`, OBP, OPS, ISO,
    --
    `W`, `L`, `GS`, `GF`,
    `CG`, `SHO`, `SV`, `IPouts`, `IP`,
    --
    `HA`, `RA`, `ER`, `HRA`, `BBA`, `SOA`,
    `IBBA`, `WP`, `HBPA`, `BK`, `BFP`,
    --
    `ERA`, `WHIP`, `H_9`, `HR_9`, `BB_9`, `SO_9`, `SO_BB`,
    --
    RAA, RAA_off, RAA_def, RAA_pit, RAR, RAR_pit,
    WAA, WAA_off, WAA_def, WAA_pit,
    WAR, WAR_off, WAR_def, WAR_pit,    
    --
    birthYear, birthMonth, birthDay, birthCountry, birthState, birthCity,
    deathYear, deathMonth, deathDay, deathCountry, deathState, deathCity,
    weight, height, bats, throws, college,
    debut, finalGame)

  SELECT
    peep.lahmanID,   peep.playerID,  peep.bbrefID,  peep.retroID,
    peep.nameCommon, peep.nameFirst, peep.nameLast, peep.nameGiven, peep.nameNick,
    --
    bat.years, bat.begYear, bat.endYear, bat.hofYear, bat.votedBy,
    bat.G, bat.G_batting, pit.`G` AS `G_pitching`, bat.G_allstar, bat.isPitcher,
    --
    bat.`PA`, bat.`AB`, bat.`R`, bat.`H`, bat.`2B`, bat.`3B`,
    bat.`HR`, bat.`RBI`, bat.`SB`, bat.`CS`, bat.`BB`, bat.`SO`,
    bat.`IBB`, bat.`HBP`, bat.`SH`, bat.`SF`, bat.`CIB`, bat.`GIDP`,
    bat.`BAVG` AS BAVG, bat.`TB`, bat.`SLG`, bat.`OBP`, bat.`OPS`, bat.`ISO`,
    --
    pit.`W`, pit.`L`, pit.`GS`, pit.`GF`,
    pit.`CG`, pit.`SHO`, pit.`SV`, pit.`IPouts`, pit.`IP`,
    --
    pit.`H`   AS `HA`, pit.`R` AS `RA`, pit.`ER`, pit.HR AS `HRA`, pit.BB AS `BBA`, pit.SO AS `SOA`,
    pit.`IBB` AS `IBBA`, pit.`WP`, pit.`HBP` AS HBPA, pit.`BK`, pit.`BFP`,
    --
    pit.`ERA`, pit.`WHIP`, pit.`H_9`, pit.`HR_9`, pit.`BB_9`, pit.`SO_9`, pit.`SO_BB`,
    --
    bat.RAA, bat.RAA_off, bat.RAA_def, pit.RAA AS RAA_pit, bat.RAR AS RAR, pit.RAR AS RAR_pit,
    bat.WAA, bat.WAA_off, bat.WAA_def, pit.WAA AS WAA_pit, 
    bat.WAR, bat.WAR_off, bat.WAR_def, pit.WAR AS WAR_pit,
    --
    birthYear, birthMonth, birthDay, birthCountry, birthState, birthCity,
    deathYear, deathMonth, deathDay, deathCountry, deathState, deathCity,
    weight, height, bats, throws, college,
    debut, finalGame

  --
  FROM      `people`     peep
  LEFT JOIN `career_bat` bat   ON peep.`lahmanID` = bat.`lahmanID`
  LEFT JOIN `career_pit` pit   ON peep.`lahmanID` = pit.`lahmanID`
;
