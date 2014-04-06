-- ===========================================================================
--
-- Season Batting Table
--

SELECT NOW() AS starting_datetime, "Find season batting stats", COUNT(*) AS n_bat from batting;

DROP TABLE IF EXISTS `bat_season`;
CREATE TABLE `bat_season` (
  `lahmanID`    INT(11)                NOT NULL,
  `playerID`    CHAR(9)                CHARACTER SET ASCII NOT NULL,
  `bbrefID`     CHAR(9)                CHARACTER SET ASCII NOT NULL,
  `retroID`     CHAR(8)                CHARACTER SET ASCII DEFAULT NULL,
  --
  `nameCommon`  varchar(100)           default NULL,
  `nameFirst`   varchar(50)            default NULL,
  `nameLast`    varchar(50) NOT NULL   default '',
  `age`         SMALLINT(2) UNSIGNED   DEFAULT NULL,
  --
  `yearID`      SMALLINT(3) UNSIGNED   DEFAULT NULL,
  `teamID`      CHAR(3)                DEFAULT NULL,
  `lgID`        CHAR(2)                DEFAULT NULL,
  `teamIDs`     VARCHAR(27)            NOT NULL,
  `lgIDs`       VARCHAR(18)            NOT NULL,
  `n_stints`    SMALLINT(3) UNSIGNED   DEFAULT NULL,
  --
  `G`           INT(5) UNSIGNED        DEFAULT NULL,
  `G_batting`   INT(5) UNSIGNED        DEFAULT NULL,
  `allstar`     BOOLEAN                DEFAULT NULL,
  --
  `PA`          INT(5) UNSIGNED        DEFAULT NULL,
  `AB`          INT(5) UNSIGNED        DEFAULT NULL,
  `R`           INT(5) UNSIGNED        DEFAULT NULL,
  `H`           INT(5) UNSIGNED        DEFAULT NULL,
  `2B`          INT(5) UNSIGNED        DEFAULT NULL,
  `3B`          INT(5) UNSIGNED        DEFAULT NULL,
  `HR`          INT(5) UNSIGNED        DEFAULT NULL,
  `RBI`         INT(5) UNSIGNED        DEFAULT NULL,
  `SB`          INT(5) UNSIGNED        DEFAULT NULL,
  `CS`          INT(5) UNSIGNED        DEFAULT NULL,
  `BB`          INT(5) UNSIGNED        DEFAULT NULL,
  `SO`          INT(5) UNSIGNED        DEFAULT NULL,
  `IBB`         INT(5) UNSIGNED        DEFAULT NULL,
  `HBP`         INT(5) UNSIGNED        DEFAULT NULL,
  `SH`          INT(5) UNSIGNED        DEFAULT NULL,
  `SF`          INT(5) UNSIGNED        DEFAULT NULL,
  `GIDP`        INT(5) UNSIGNED        DEFAULT NULL,
  -- defensive interference while batting.
  -- Discrepancies between Baseball Reference our component stats from Baseball Databank mean that you can't trust this number very much
  `CIB`         INT(5)                 DEFAULT NULL,
  --
  `BAVG`        FLOAT                  DEFAULT NULL,
  `TB`          FLOAT                  DEFAULT NULL,
  `SLG`         FLOAT                  DEFAULT NULL,
  `OBP`         FLOAT                  DEFAULT NULL,
  `OPS`         FLOAT                  DEFAULT NULL,
  `ISO`         FLOAT                  DEFAULT NULL,
  --
  `isPitcher`   BOOLEAN                DEFAULT NULL,
  `RAA`         FLOAT                  DEFAULT NULL,
  `RAA_off`     FLOAT                  DEFAULT NULL,
  `RAA_def`     FLOAT                  DEFAULT NULL,
  `RAR`         FLOAT                  DEFAULT NULL,
  `WAA`         FLOAT                  DEFAULT NULL,
  `WAA_off`     FLOAT                  DEFAULT NULL,
  `WAA_def`     FLOAT                  DEFAULT NULL,
  `WAR`         FLOAT                  DEFAULT NULL,
  `WAR_off`     FLOAT                  DEFAULT NULL,
  `WAR_def`     FLOAT                  DEFAULT NULL,
  --
  PRIMARY KEY             (`lahmanID`, `yearID`),
  UNIQUE KEY  `player`    (`playerID`, `yearID`),
  UNIQUE KEY  `bbref`     (`bbrefID`,  `yearID`),
  KEY         `retro`     (`retroID`,  `bbrefID`, `yearID`),
  KEY         `yearID`    (`yearID`)
  ) ENGINE=INNODB DEFAULT CHARSET=utf8
;

INSERT INTO `bat_season`
  (
    lahmanID, playerID, bbrefID, retroID, nameFirst, nameLast, nameCommon,
    yearID, teamIDs, lgIDs, n_stints,
    G, G_batting,
    allstar,
    AB, R, H, 2B, 3B, HR, RBI,
    SB, CS, BB, SO, IBB, HBP,
    SH, SF, GIDP)

  SELECT
    lahmanID, peep.playerID, peep.bbrefID, peep.retroID, peep.nameFirst, peep.nameLast, peep.nameCommon,
    bat.yearID, GROUP_CONCAT(bat.teamID) AS teamIDs, GROUP_CONCAT(bat.lgID) AS lgIDs, COUNT(*) AS n_stints,
    SUM(bat.G) AS G, IFNULL(SUM(bat.G_batting),0) AS G_batting,
    IF(ast.playerID IS NOT NULL, TRUE, FALSE) AS allstar,
    SUM(AB) AS AB, SUM(R)  AS R,  SUM(H)  AS H,  SUM(2B) AS 2B, SUM(3B)  AS 3B,  SUM(HR)  AS HR,  SUM(RBI) AS RBI,
    SUM(SB) AS SB, SUM(CS) AS CS, SUM(BB) AS BB, SUM(SO) AS SO, SUM(IBB) AS IBB, SUM(HBP) AS HBP,
    SUM(SH) AS SH, SUM(SF) AS SF, SUM(GIDP) AS GIDP
  --
  FROM batting bat
  JOIN `people` peep
    ON bat.`playerID` = peep.`playerID`
  LEFT JOIN (SELECT DISTINCT playerID, yearID FROM allstarfull) ast
    ON (bat.`playerID` = ast.`playerID` AND bat.`yearID` = ast.`yearID`)
  GROUP BY playerID, yearID
  ;

--
-- Copy over WAR settings from baseball_reference tables
--
UPDATE `bat_season`,
  (SELECT bbrefID, yearID, age, COUNT(*) as n_stints,
    MAX(isPitcher) AS isPitcher,
    SUM(PA) AS PA,
    SUM(runs_above_avg) AS RAA, SUM(runs_above_avg_off) AS RAA_off, SUM(runs_above_avg_def) AS RAA_def,
    SUM(runs_above_rep) AS RAR,
    SUM(WAA) AS WAA, SUM(WAA_off) AS WAA_off, SUM(WAA_def) AS WAA_def,
    SUM(WAR) AS WAR, SUM(WAR_off) AS WAR_off, SUM(WAR_def) AS WAR_def
    FROM `bat_war` GROUP BY bbrefID, yearID) wart
  SET
       `bat_season`.`age`        = wart.`age`,
       `bat_season`.`n_stints`   = wart.`n_stints`,
       `bat_season`.`PA`        = wart.`PA`,
       `bat_season`.`RAA`       = wart.`RAA`,
       `bat_season`.`RAA_off`   = wart.`RAA_off`,
       `bat_season`.`RAA_def`   = wart.`RAA_def`,
       `bat_season`.`RAR`       = wart.`RAR`,
       `bat_season`.`WAA`       = wart.`WAA`,
       `bat_season`.`WAA_off`   = wart.`WAA_off`,
       `bat_season`.`WAA_def`   = wart.`WAA_def`,
       `bat_season`.`WAR`       = wart.`WAR`,
       `bat_season`.`WAR_off`   = wart.`WAR_off`,
       `bat_season`.`WAR_def`   = wart.`WAR_def`,
       `bat_season`.`isPitcher` = wart.`isPitcher`
 WHERE (`bat_season`.`bbrefID`  = wart.`bbrefID`)
   AND (`bat_season`.`yearID`   = wart.`yearID`)
 ;

--
-- Calculate derived statistics -- batting average and so forth
--
UPDATE bat_season SET
  BAVG  = IF(AB>0,  (H / AB), 0),
  TB    = IF(PA>0,  (H + 2B + 2 * 3B + 3 * HR), 0),
  SLG   = IF(AB>0, ((H + 2B + 2 * 3B + 3 * HR) / AB), 0),
  OBP   = IF(PA>0, ((H + BB + IFNULL(HBP,0))   / PA), 0),
  CIB   = IF(PA>0,  (PA - (AB + BB + IFNULL(HBP,0) + IFNULL(SH,0) + IFNULL(SF,0))), 0)
  ;
UPDATE bat_season SET
  OPS   =          (SLG + OBP),
  ISO   = IF(AB>0, ((TB - H) / AB), 0)
  ;
