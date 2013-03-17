-- ===========================================================================
--
-- Batting WAR Table
--

DROP TABLE IF EXISTS `batting_war`;
CREATE TABLE batting_war (
  `lahmanID`            int(11)              DEFAULT NULL,
  `playerID`            varchar(10)          DEFAULT NULL,
  `bbrefID`             varchar(9)           DEFAULT NULL,
  `retroID`             varchar(9)           default NULL,
  --
  `nameCommon`         varchar(100),
  --
  `yearID`              smallint(4) NOT NULL default '0',
  `teamID`              char(3)     NOT NULL default '',
  `stintID`             smallint(2) unsigned NOT NULL default '0',
  `lgID`                char(2)     NOT NULL default '',
  `PA`                  int(5)      unsigned default NULL,
  `G`                   int(5)      unsigned default NULL,
  `Inn`                 float                default NULL,
  `runs_bat`            float                default NULL,
  `runs_br`             float                default NULL,
  `runs_dp`             float                default NULL,
  `runs_field`          float                default NULL,
  `runs_infield`        float                default NULL,
  `runs_outfield`       float                default NULL,
  `runs_catcher`        float                default NULL,
  `runs_good_plays`     float                default NULL,
  `runs_defense`        float                default NULL,
  `runs_position`       float                default NULL,
  `runs_position_p`     float                default NULL,
  `runs_replacement`    float                default NULL,
  `runs_above_rep`      float                default NULL,
  `runs_above_avg`      float                default NULL,
  `runs_above_avg_off`  float                default NULL,
  `runs_above_avg_def`  float                default NULL,
  `WAA`                 float                default NULL,
  `WAA_off`             float                default NULL,
  `WAA_def`             float                default NULL,
  `WAR`                 float                default NULL,
  `WAR_off`             float                default NULL,
  `WAR_def`             float                default NULL,
  `WAR_rep`             float                default NULL,
  `salary`              int(10)              default NULL,
  `isPitcher`           enum('Y','N')        default NULL,
  `teamRpG`             float                default NULL,
  `oppRpG`              float                default NULL,
  `oppRpPA_rep`         float                default NULL,
  `oppRpG_rep`          float                default NULL,
  `pyth_exponent`       float                default NULL,
  `pyth_exponent_rep`   float                default NULL,
  `waa_win_perc`        float                default NULL,
  `waa_win_perc_off`    float                default NULL,
  `waa_win_perc_def`    float                default NULL,
  `waa_win_perc_rep`    float                default NULL,
  --
  PRIMARY KEY      (`bbrefID`, `yearID`, `stintID`),
  KEY `bbrefID`    (`bbrefID`),
  KEY `lahmanID`   (`lahmanID`),
  KEY `playerID`   (`playerID`),
  KEY `retroID`    (`retroID`,`bbrefID`)

  ) ENGINE=InnoDB DEFAULT CHARSET=latin1
;

-- Note: WAR is in order def, off here; order off, def above
TRUNCATE TABLE `batting_war`;
LOAD DATA INFILE '/Users/flip/ics/core/wukong/data/sports/baseball/baseball_reference/batting_war-20130315.csv' REPLACE
  INTO TABLE `batting_war`
  FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY ''
  IGNORE 1 ROWS
  ( nameCommon,bbrefID,yearID,teamID,stintID,lgID,PA,G,Inn,
    runs_bat,runs_br,runs_dp,runs_field,runs_infield,runs_outfield,runs_catcher,runs_good_plays,
    runs_defense,runs_position,runs_position_p,
    runs_replacement,runs_above_rep,runs_above_avg,runs_above_avg_off,runs_above_avg_def,
    WAA,WAA_off,WAA_def,WAR,WAR_def,WAR_off,WAR_rep,
    salary, isPitcher,
    teamRpG,oppRpG,oppRpPA_rep,oppRpG_rep,pyth_exponent,pyth_exponent_rep,
    waa_win_perc,waa_win_perc_off,waa_win_perc_def,waa_win_perc_rep)
;

ALTER TABLE `batting_war` DISABLE KEYS;
UPDATE `batting_war`, `people`
   SET `batting_war`.`playerID` = `people`.`playerID`,
       `batting_war`.`retroID`  = `people`.`retroID`,
       `batting_war`.`lahmanID` = `people`.`lahmanID`
 WHERE `batting_war`.`bbrefID` = `people`.`bbrefID` ;
ALTER TABLE `batting_war` ENABLE KEYS;

-- ===========================================================================
--
-- Pitching WAR
--
--

DROP TABLE IF EXISTS `pitching_war`;
CREATE TABLE pitching_war (
  `lahmanID`            int(11)      DEFAULT NULL,
  `playerID`            varchar(10)  DEFAULT NULL,
  `bbrefID`             varchar(9)   DEFAULT NULL,
  `retroID`             varchar(9)           default NULL,
  --
  `nameCommon`         varchar(100),
  --
  `yearID`              smallint(4) NOT NULL default '0',
  `teamID`              char(3)     NOT NULL default '',
  `stintID`             smallint(2) unsigned NOT NULL default '0',
  `lgID`                char(2)     NOT NULL default '',
  --
  `G`                   int(5)      unsigned default NULL,
  `GS`                  int(5)      unsigned default NULL,
  `IPouts`              float                default NULL,
  `IPouts_start`        float                default NULL,
  `IPouts_relief`       float                default NULL,
  `RA`                  float                default NULL,
  `xRA`                 float                default NULL,
  `xRA_sprp_adj`        float                default NULL,
  `xRA_def_pitcher`     float                default NULL,
  `PPF`                 float                default NULL,
  `PPF_custom`          float                default NULL,
  `xRA_final`           float                default NULL,
  `BIP`                 float                default NULL,
  `BIP_perc`            float                default NULL,
  `RS_def_total`        float                default NULL,
  `runs_above_avg`      float                default NULL,
  `runs_above_avg_adj`  float                default NULL,
  `runs_above_rep`      float                default NULL,
  `RpO_replacement`     float                default NULL,
  `GR_leverage_index_avg` float              default NULL,
  `WAR`                 float                default NULL,
  `salary`              float                default NULL,
  `teamRpG`             float                default NULL,
  `oppRpG`              float                default NULL,
  `pyth_exponent`       float                default NULL,
  `waa_win_perc`        float                default NULL,
  `WAA`                 float                default NULL,
  `WAA_adj`             float                default NULL,
  `oppRpG_rep`          float                default NULL,
  `pyth_exponent_rep`   float                default NULL,
  `waa_win_perc_rep`    float                default NULL,
  `WAR_rep`             float                default NULL,
  --
  PRIMARY KEY      (`bbrefID`, `yearID`, `stintID`),
  KEY `bbrefID`    (`bbrefID`),
  KEY `lahmanID`   (`lahmanID`),
  KEY `playerID`   (`playerID`),
  KEY `retroID`    (`retroID`,`bbrefID`)

  ) ENGINE=InnoDB DEFAULT CHARSET=latin1
;

TRUNCATE TABLE `pitching_war`;
LOAD DATA INFILE '/Users/flip/ics/core/wukong/data/sports/baseball/baseball_reference/pitching_war-20130315.csv' REPLACE
  INTO TABLE `pitching_war`
  FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY ''
  IGNORE 1 ROWS
  ( nameCommon,bbrefID,yearID,teamID,stintID,lgID,
    G,GS,IPouts,IPouts_start,IPouts_relief,
    RA,xRA,xRA_sprp_adj,xRA_def_pitcher,PPF,PPF_custom,xRA_final,
    BIP,BIP_perc,RS_def_total,
    runs_above_avg,runs_above_avg_adj,runs_above_rep,RpO_replacement,GR_leverage_index_avg,
    WAR,salary,
    teamRpG,oppRpG,pyth_exponent,waa_win_perc,WAA,WAA_adj,oppRpG_rep,
    pyth_exponent_rep,waa_win_perc_rep,WAR_rep )
;
--
ALTER TABLE `pitching_war` DISABLE KEYS;
UPDATE `pitching_war`, `people`
   SET `pitching_war`.`playerID` = `people`.`playerID`,
       `pitching_war`.`retroID`  = `people`.`retroID`,
       `pitching_war`.`lahmanID` = `people`.`lahmanID`
 WHERE `pitching_war`.`bbrefID` = `people`.`bbrefID`
 ;
ALTER TABLE `pitching_war` ENABLE KEYS;

-- ===========================================================================
--
-- Pull the common name field from the war tables into the people table
--

UPDATE `pitching_war`, `people`
   SET `people`.`nameCommon` = `pitching_war`.`nameCommon`
 WHERE `pitching_war`.`bbrefID` = `people`.`bbrefID`
 ;
UPDATE `batting_war`, `people`
   SET `people`.`nameCommon` = `batting_war`.`nameCommon`
 WHERE `batting_war`.`bbrefID`    = `people`.`bbrefID`
 ;
