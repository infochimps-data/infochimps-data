DROP TABLE IF EXISTS `batting_war`;
DROP TABLE IF EXISTS `pitching_war`;

-- ===========================================================================
--
-- People Table
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `lahmanID`            int(11)      DEFAULT NULL,
  `playerID`            varchar(10)  DEFAULT NULL,
  `bbrefID`             varchar(9)   DEFAULT NULL,
  `retroID`             varchar(9)           default NULL,
  --
  `nameCommon`    varchar(100) DEFAULT NULL,
  --
  `birthYear`     int(11)      DEFAULT NULL,
  `birthMonth`    int(11)      DEFAULT NULL,
  `birthDay`      int(11)      DEFAULT NULL,
  `birthCountry`  varchar(50)  DEFAULT NULL,
  `birthState`    varchar(2)   DEFAULT NULL,
  `birthCity`     varchar(50)  DEFAULT NULL,
  `deathYear`     int(11)      DEFAULT NULL,
  `deathMonth`    int(11)      DEFAULT NULL,
  `deathDay`      int(11)      DEFAULT NULL,
  `deathCountry`  varchar(50)  DEFAULT NULL,
  `deathState`    varchar(2)   DEFAULT NULL,
  `deathCity`     varchar(50)  DEFAULT NULL,
  `nameFirst`     varchar(50)  DEFAULT NULL,
  `nameLast`      varchar(50)  DEFAULT NULL,
  `nameNote`      varchar(255) DEFAULT NULL,
  `nameGiven`     varchar(255) DEFAULT NULL,
  `nameNick`      varchar(255) DEFAULT NULL,
  --
  `weight`        int(11)      DEFAULT NULL,
  `height`        double       DEFAULT NULL,
  `bats`          varchar(1)   DEFAULT NULL,
  `throws`        varchar(1)   DEFAULT NULL,
  `debut`         varchar(10)  DEFAULT NULL,
  `finalGame`     varchar(10)  DEFAULT NULL,
  `college`       varchar(50)  DEFAULT NULL,
  --
  `managerID`     varchar(10)  DEFAULT NULL,
  `hofID`         varchar(10)  DEFAULT NULL,

  PRIMARY KEY (`lahmanID`),
  KEY `bbrefID` (`bbrefID`),
  KEY `playerID` (`playerID`),
  KEY `retroID` (`retroID`,`bbrefID`),
  KEY `managerID` (`managerID`),
  KEY `hofID` (`hofID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

REPLACE INTO `people`
        (`playerID`, `retroID`, `lahmanID`, `bbrefID`, `birthYear`, `birthMonth`, `birthDay`, `birthCountry`, `birthState`, `birthCity`, `deathYear`, `deathMonth`, `deathDay`, `deathCountry`, `deathState`, `deathCity`, `nameFirst`, `nameLast`, `nameNote`, `nameGiven`, `nameNick`, `weight`, `height`, `bats`, `throws`, `debut`, `finalGame`, `college`, `managerID`, `hofID`)
  SELECT `playerID`, `retroID`, `lahmanID`, `bbrefID`, `birthYear`, `birthMonth`, `birthDay`, `birthCountry`, `birthState`, `birthCity`, `deathYear`, `deathMonth`, `deathDay`, `deathCountry`, `deathState`, `deathCity`, `nameFirst`, `nameLast`, `nameNote`, `nameGiven`, `nameNick`, `weight`, `height`, `bats`, `throws`, `debut`, `finalGame`, `college`, `managerID`, `hofID`
  FROM `master`
  ;

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
  `Inn`                 double               default NULL,
  `runs_bat`            double               default NULL,
  `runs_br`             double               default NULL,
  `runs_dp`             double               default NULL,
  `runs_field`          double               default NULL,
  `runs_infield`        double               default NULL,
  `runs_outfield`       double               default NULL,
  `runs_catcher`        double               default NULL,
  `runs_good_plays`     double               default NULL,
  `runs_defense`        double               default NULL,
  `runs_position`       double               default NULL,
  `runs_position_p`     double               default NULL,
  `runs_replacement`    double               default NULL,
  `runs_above_rep`      double               default NULL,
  `runs_above_avg`      double               default NULL,
  `runs_above_avg_off`  double               default NULL,
  `runs_above_avg_def`  double               default NULL,
  `WAA`                 double               default NULL,
  `WAA_off`             double               default NULL,
  `WAA_def`             double               default NULL,
  `WAR`                 double               default NULL,
  `WAR_def`             double               default NULL,
  `WAR_off`             double               default NULL,
  `WAR_rep`             double               default NULL,
  `salary`              int(10)              default NULL,
  `pitcher`             enum('Y','N')        default NULL,
  `teamRpG`             double               default NULL,
  `oppRpG`              double               default NULL,
  `oppRpPA_rep`         double               default NULL,
  `oppRpG_rep`          double               default NULL,
  `pyth_exponent`       double               default NULL,
  `pyth_exponent_rep`   double               default NULL,
  `waa_win_perc`        double               default NULL,
  `waa_win_perc_off`    double               default NULL,
  `waa_win_perc_def`    double               default NULL,
  `waa_win_perc_rep`    double               default NULL,
  --
  PRIMARY KEY      (`bbrefID`, `yearID`, `stintID`),
  KEY `bbrefID`    (`bbrefID`),
  KEY `lahmanID`   (`lahmanID`),
  KEY `playerID`   (`playerID`),
  KEY `retroID`    (`retroID`,`bbrefID`)

  ) ENGINE=MyISAM DEFAULT CHARSET=latin1
;

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
    salary,pitcher,
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
  `IPouts`              double               default NULL,
  `IPouts_start`        double               default NULL,
  `IPouts_relief`       double               default NULL,
  `RA`                  double               default NULL,
  `xRA`                 double               default NULL,
  `xRA_sprp_adj`        double               default NULL,
  `xRA_def_pitcher`     double               default NULL,
  `PPF`                 double               default NULL,
  `PPF_custom`          double               default NULL,
  `xRA_final`           double               default NULL,
  `BIP`                 double               default NULL,
  `BIP_perc`            double               default NULL,
  `RS_def_total`        double               default NULL,
  `runs_above_avg`      double               default NULL,
  `runs_above_avg_adj`  double               default NULL,
  `runs_above_rep`      double               default NULL,
  `RpO_replacement`     double               default NULL,
  `GR_leverage_index_avg` double               default NULL,
  `WAR`                 double               default NULL,
  `salary`              double               default NULL,
  `teamRpG`             double               default NULL,
  `oppRpG`              double               default NULL,
  `pyth_exponent`       double               default NULL,
  `waa_win_perc`        double               default NULL,
  `WAA`                 double               default NULL,
  `WAA_adj`             double               default NULL,
  `oppRpG_rep`          double               default NULL,
  `pyth_exponent_rep`   double               default NULL,
  `waa_win_perc_rep`    double               default NULL,
  `WAR_rep`             double               default NULL,
  --
  PRIMARY KEY      (`bbrefID`, `yearID`, `stintID`),
  KEY `bbrefID`    (`bbrefID`),
  KEY `lahmanID`   (`lahmanID`),
  KEY `playerID`   (`playerID`),
  KEY `retroID`    (`retroID`,`bbrefID`)

  ) ENGINE=MyISAM DEFAULT CHARSET=latin1
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
