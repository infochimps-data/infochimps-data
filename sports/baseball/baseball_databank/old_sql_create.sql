-- MySQL dump 10.11
--
-- Host: dbserver    Database: brdev
-- ------------------------------------------------------
-- Server version	5.0.87-percona-highperf-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Master`
--

DROP TABLE IF EXISTS `Master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Master` (
  `lahmanID` int(9) NOT NULL auto_increment,
  `playerID` varchar(10) NOT NULL default '',
  `managerID` varchar(10) NOT NULL default '',
  `hofID` varchar(10) NOT NULL default '',
  `birthYear` int(4) default NULL,
  `birthMonth` int(2) default NULL,
  `birthDay` int(2) default NULL,
  `birthCountry` varchar(50) default NULL,
  `birthState` char(2) default NULL,
  `birthCity` varchar(50) default NULL,
  `deathYear` int(4) default NULL,
  `deathMonth` int(2) default NULL,
  `deathDay` int(2) default NULL,
  `deathCountry` varchar(50) default NULL,
  `deathState` char(2) default NULL,
  `deathCity` varchar(50) default NULL,
  `nameFirst` varchar(50) default NULL,
  `nameLast` varchar(50) NOT NULL default '',
  `nameNote` varchar(255) default NULL,
  `nameGiven` varchar(255) default NULL,
  `nameNick` varchar(255) default NULL,
  `weight` int(3) default NULL,
  `height` double(4,1) default NULL,
  `bats` enum('L','R','B') default NULL,
  `throws` enum('L','R','B') default NULL,
  `debut` date default NULL,
  `finalGame` date default NULL,
  `college` varchar(50) default NULL,
  `lahman40ID` varchar(9) default NULL,
  `lahman45ID` varchar(9) default NULL,
  `retroID` varchar(9) default NULL,
  `holtzID` varchar(9) default NULL,
  `bbrefID` varchar(9) default NULL,
  PRIMARY KEY  (`lahmanID`),
  KEY `playerID` (`playerID`),
  KEY `managerID` (`managerID`),
  KEY `hofID` (`hofID`),
  KEY `lahman40ID` (`lahman40ID`),
  KEY `lahman45ID` (`lahman45ID`),
  KEY `bbrefID` (`bbrefID`),
  KEY `bbrefID_2` (`bbrefID`),
  KEY `retroID` (`retroID`,`bbrefID`),
  KEY `holtzID` (`holtzID`),
  KEY `bbrefID_3` (`bbrefID`)
) ENGINE=MyISAM AUTO_INCREMENT=18968 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teams` (
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `teamID` char(3) NOT NULL default '',
  `franchID` char(3) NOT NULL default 'UNK',
  `divID` char(1) default NULL,
  `Rank` smallint(3) unsigned NOT NULL default '0',
  `G` smallint(3) unsigned default NULL,
  `Ghome` int(3) default NULL,
  `W` smallint(3) unsigned default NULL,
  `L` smallint(3) unsigned default NULL,
  `DivWin` enum('Y','N') default NULL,
  `WCWin` enum('Y','N') default NULL,
  `LgWin` enum('Y','N') default NULL,
  `WSWin` enum('Y','N') default NULL,
  `R` smallint(4) unsigned default NULL,
  `AB` smallint(4) unsigned default NULL,
  `H` smallint(4) unsigned default NULL,
  `2B` smallint(4) unsigned default NULL,
  `3B` smallint(3) unsigned default NULL,
  `HR` smallint(3) unsigned default NULL,
  `BB` smallint(4) unsigned default NULL,
  `SO` smallint(4) unsigned default NULL,
  `SB` smallint(3) unsigned default NULL,
  `CS` smallint(3) unsigned default NULL,
  `HBP` smallint(3) default NULL,
  `SF` smallint(3) default NULL,
  `RA` smallint(4) unsigned default NULL,
  `ER` smallint(4) default NULL,
  `ERA` decimal(4,2) default NULL,
  `CG` smallint(3) unsigned default NULL,
  `SHO` smallint(3) unsigned default NULL,
  `SV` smallint(3) unsigned default NULL,
  `IPouts` int(5) default NULL,
  `HA` smallint(4) unsigned default NULL,
  `HRA` smallint(4) unsigned default NULL,
  `BBA` smallint(4) unsigned default NULL,
  `SOA` smallint(4) unsigned default NULL,
  `E` int(5) default NULL,
  `DP` int(4) default NULL,
  `FP` decimal(5,3) default NULL,
  `name` varchar(50) NOT NULL default '',
  `park` varchar(255) default NULL,
  `attendance` int(7) default NULL,
  `BPF` int(3) default NULL,
  `PPF` int(3) default NULL,
  `teamIDBR` char(3) default NULL,
  `teamIDlahman45` char(3) default NULL,
  `teamIDretro` char(3) default NULL,
  PRIMARY KEY  (`yearID`,`lgID`,`teamID`),
  KEY `team` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TeamsFranchises`
--

DROP TABLE IF EXISTS `TeamsFranchises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TeamsFranchises` (
  `franchID` char(3) NOT NULL default '',
  `franchName` varchar(50) NOT NULL default '',
  `active` enum('Y','N','NA') NOT NULL default 'Y',
  `NAassoc` char(3) default NULL,
  PRIMARY KEY  (`franchID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TeamsHalf`
--

DROP TABLE IF EXISTS `TeamsHalf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TeamsHalf` (
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `teamID` char(3) NOT NULL default '',
  `Half` enum('1','2','') NOT NULL default '',
  `divID` char(1) default NULL,
  `DivWin` enum('Y','N') NOT NULL default 'N',
  `Rank` smallint(3) unsigned NOT NULL default '0',
  `G` smallint(3) unsigned default NULL,
  `W` smallint(3) unsigned default NULL,
  `L` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`yearID`,`teamID`,`lgID`,`Half`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Batting`
--

DROP TABLE IF EXISTS `Batting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Batting` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `stint` smallint(2) unsigned NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `G` smallint(3) unsigned default NULL,
  `G_batting` smallint(3) unsigned default NULL,
  `AB` smallint(3) unsigned default NULL,
  `R` smallint(3) unsigned default NULL,
  `H` smallint(3) unsigned default NULL,
  `2B` smallint(3) unsigned default NULL,
  `3B` smallint(3) unsigned default NULL,
  `HR` smallint(3) unsigned default NULL,
  `RBI` smallint(3) unsigned default NULL,
  `SB` smallint(3) unsigned default NULL,
  `CS` smallint(3) unsigned default NULL,
  `BB` smallint(3) unsigned default NULL,
  `SO` smallint(3) unsigned default NULL,
  `IBB` smallint(3) unsigned default NULL,
  `HBP` smallint(3) unsigned default NULL,
  `SH` smallint(3) unsigned default NULL,
  `SF` smallint(3) unsigned default NULL,
  `GIDP` smallint(3) unsigned default NULL,
  `G_old` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`stint`),
  KEY `playerID` (`playerID`),
  KEY `team` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pitching`
--

DROP TABLE IF EXISTS `Pitching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pitching` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `stint` smallint(2) unsigned NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `W` smallint(2) unsigned default NULL,
  `L` smallint(2) unsigned default NULL,
  `G` smallint(3) unsigned default NULL,
  `GS` smallint(3) unsigned default NULL,
  `CG` smallint(3) unsigned default NULL,
  `SHO` smallint(3) unsigned default NULL,
  `SV` smallint(3) unsigned default NULL,
  `IPouts` int(5) unsigned default NULL,
  `H` smallint(3) unsigned default NULL,
  `ER` smallint(3) unsigned default NULL,
  `HR` smallint(3) unsigned default NULL,
  `BB` smallint(3) unsigned default NULL,
  `SO` smallint(3) unsigned default NULL,
  `BAOpp` decimal(5,3) unsigned default NULL,
  `ERA` decimal(5,2) unsigned default NULL,
  `IBB` smallint(3) unsigned default NULL,
  `WP` smallint(3) unsigned default NULL,
  `HBP` smallint(3) unsigned default NULL,
  `BK` smallint(3) unsigned default NULL,
  `BFP` smallint(6) unsigned default NULL,
  `GF` smallint(3) unsigned default NULL,
  `R` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`stint`),
  KEY `playerID` (`playerID`),
  KEY `team` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Fielding`
--

DROP TABLE IF EXISTS `Fielding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Fielding` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `stint` smallint(2) unsigned NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `POS` char(2) NOT NULL default '',
  `G` smallint(3) unsigned default NULL,
  `GS` smallint(3) unsigned default NULL,
  `InnOuts` int(5) unsigned default NULL,
  `PO` smallint(3) unsigned default NULL,
  `A` smallint(3) unsigned default NULL,
  `E` smallint(2) unsigned default NULL,
  `DP` smallint(3) unsigned default NULL,
  `PB` smallint(3) unsigned default NULL,
  `WP` smallint(3) unsigned default NULL,
  `SB` smallint(3) unsigned default NULL,
  `CS` smallint(3) unsigned default NULL,
  `pickoffs` smallint(3) unsigned default NULL,
  `ZR` double(5,3) default NULL,
  `missing_g_c` smallint(3) unsigned default NULL,
  `missing_g` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`stint`,`POS`),
  KEY `playerID` (`playerID`),
  KEY `team` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FieldingOF`
--

DROP TABLE IF EXISTS `FieldingOF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FieldingOF` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `stint` int(2) NOT NULL default '0',
  `Glf` int(3) default NULL,
  `Gcf` int(3) default NULL,
  `Grf` int(3) default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`stint`),
  KEY `playerID` (`playerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Salaries`
--

DROP TABLE IF EXISTS `Salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Salaries` (
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `playerID` varchar(9) NOT NULL default '',
  `salary` double(10,2) NOT NULL default '0.00',
  PRIMARY KEY  (`yearID`,`teamID`,`lgID`,`playerID`),
  KEY `playerID` (`playerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Managers`
--

DROP TABLE IF EXISTS `Managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Managers` (
  `managerID` varchar(10) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `inseason` smallint(1) NOT NULL default '1',
  `G` smallint(3) NOT NULL default '0',
  `W` smallint(3) NOT NULL default '0',
  `L` smallint(3) NOT NULL default '0',
  `rank` smallint(1) NOT NULL default '0',
  `plyrMgr` enum('Y','N') default 'N',
  PRIMARY KEY  (`managerID`,`yearID`,`teamID`,`inseason`),
  KEY `team` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ManagersHalf`
--

DROP TABLE IF EXISTS `ManagersHalf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ManagersHalf` (
  `managerID` varchar(10) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `inseason` int(2) default NULL,
  `half` smallint(1) NOT NULL default '1',
  `G` smallint(3) NOT NULL default '0',
  `W` smallint(3) NOT NULL default '0',
  `L` smallint(3) NOT NULL default '0',
  `rank` smallint(1) NOT NULL default '0',
  PRIMARY KEY  (`yearID`,`teamID`,`managerID`,`half`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AllstarFull`
--

DROP TABLE IF EXISTS `AllstarFull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AllstarFull` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `gameNum` tinyint(1) unsigned NOT NULL default '0',
  `game_id` varchar(12) NOT NULL default '',
  `teamID` char(3) default NULL,
  `lgID` char(2) NOT NULL default '',
  `GP` tinyint(1) unsigned default NULL,
  `startingPos` tinyint(2) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`gameNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AwardsPlayers`
--

DROP TABLE IF EXISTS `AwardsPlayers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AwardsPlayers` (
  `playerID` varchar(9) NOT NULL default '',
  `awardID` varchar(255) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `tie` char(1) default NULL,
  `notes` varchar(100) default NULL,
  PRIMARY KEY  (`yearID`,`awardID`,`lgID`,`playerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AwardsSharePlayers`
--

DROP TABLE IF EXISTS `AwardsSharePlayers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AwardsSharePlayers` (
  `awardID` varchar(25) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `playerID` varchar(9) NOT NULL default '',
  `pointsWon` double(5,1) default NULL,
  `pointsMax` int(4) default NULL,
  `votesFirst` double(5,1) default NULL,
  PRIMARY KEY  (`awardID`,`yearID`,`lgID`,`playerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AwardsManagers`
--

DROP TABLE IF EXISTS `AwardsManagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AwardsManagers` (
  `managerID` varchar(10) NOT NULL default '',
  `awardID` varchar(25) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `tie` char(1) default NULL,
  `notes` varchar(100) default NULL,
  PRIMARY KEY  (`yearID`,`awardID`,`lgID`,`managerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AwardsShareManagers`
--

DROP TABLE IF EXISTS `AwardsShareManagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AwardsShareManagers` (
  `awardID` varchar(25) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `lgID` char(2) NOT NULL default '',
  `managerID` varchar(10) NOT NULL default '',
  `pointsWon` int(4) default NULL,
  `pointsMax` int(4) default NULL,
  `votesFirst` int(4) default NULL,
  PRIMARY KEY  (`awardID`,`yearID`,`lgID`,`managerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HallOfFame`
--

DROP TABLE IF EXISTS `HallOfFame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HallOfFame` (
  `hofID` varchar(10) NOT NULL default '',
  `yearID` smallint(4) NOT NULL default '0',
  `votedBy` varchar(64) NOT NULL default '',
  `ballots` smallint(5) default NULL,
  `needed` varchar(20) default NULL,
  `votes` float(5,1) default NULL,
  `inducted` enum('Y','N') default 'N',
  `category` varchar(20) default NULL,
  PRIMARY KEY  (`hofID`,`yearID`,`votedBy`),
  KEY `hofID` (`hofID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BattingPost`
--

DROP TABLE IF EXISTS `BattingPost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BattingPost` (
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `round` varchar(10) NOT NULL default '',
  `playerID` varchar(9) NOT NULL default '',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `G` smallint(3) unsigned default NULL,
  `AB` smallint(3) NOT NULL default '0',
  `R` smallint(3) unsigned default NULL,
  `H` smallint(3) unsigned default NULL,
  `2B` smallint(3) unsigned default NULL,
  `3B` smallint(3) unsigned default NULL,
  `HR` smallint(3) unsigned NOT NULL default '0',
  `RBI` smallint(3) unsigned default NULL,
  `SB` smallint(3) unsigned default NULL,
  `CS` smallint(3) unsigned default NULL,
  `BB` smallint(3) unsigned default NULL,
  `SO` smallint(3) unsigned default NULL,
  `IBB` smallint(3) unsigned default NULL,
  `HBP` smallint(3) unsigned default NULL,
  `SH` smallint(3) unsigned default NULL,
  `SF` smallint(3) unsigned default NULL,
  `GIDP` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`yearID`,`round`,`playerID`),
  KEY `playerID` (`playerID`),
  KEY `teamID` (`teamID`,`yearID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FieldingPost`
--

DROP TABLE IF EXISTS `FieldingPost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FieldingPost` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `round` varchar(10) NOT NULL default '',
  `POS` char(2) NOT NULL default '',
  `G` smallint(3) unsigned default NULL,
  `GS` smallint(3) unsigned default NULL,
  `InnOuts` int(5) unsigned default NULL,
  `PO` smallint(3) unsigned default NULL,
  `A` smallint(3) unsigned default NULL,
  `E` smallint(2) unsigned default NULL,
  `DP` smallint(3) unsigned default NULL,
  `TP` smallint(3) unsigned default NULL,
  `PB` smallint(3) unsigned default NULL,
  `SB` smallint(3) unsigned default NULL,
  `CS` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`round`,`POS`),
  KEY `playerID` (`playerID`),
  KEY `team` (`teamID`,`yearID`,`lgID`),
  KEY `round` (`yearID`,`round`,`teamID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PitchingPost`
--

DROP TABLE IF EXISTS `PitchingPost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PitchingPost` (
  `playerID` varchar(9) NOT NULL default '',
  `yearID` smallint(4) unsigned NOT NULL default '0',
  `round` varchar(10) NOT NULL default '',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) NOT NULL default '',
  `W` smallint(2) unsigned default NULL,
  `L` smallint(2) unsigned default NULL,
  `G` smallint(3) unsigned default NULL,
  `GS` smallint(3) unsigned default NULL,
  `CG` smallint(3) unsigned default NULL,
  `SHO` smallint(3) unsigned default NULL,
  `SV` smallint(3) unsigned default NULL,
  `IPouts` int(5) unsigned default NULL,
  `H` smallint(3) unsigned default NULL,
  `ER` smallint(3) unsigned default NULL,
  `HR` smallint(3) unsigned default NULL,
  `BB` smallint(3) unsigned default NULL,
  `SO` smallint(3) unsigned default NULL,
  `BAOpp` decimal(5,3) unsigned default NULL,
  `ERA` decimal(5,2) unsigned default NULL,
  `IBB` smallint(3) unsigned default NULL,
  `WP` smallint(3) unsigned default NULL,
  `HBP` smallint(3) unsigned default NULL,
  `BK` smallint(3) unsigned default NULL,
  `BFP` smallint(6) unsigned default NULL,
  `GF` smallint(3) unsigned default NULL,
  `R` smallint(3) unsigned default NULL,
  `SH` smallint(3) unsigned default NULL,
  `SF` smallint(3) unsigned default NULL,
  `GIDP` smallint(3) unsigned default NULL,
  PRIMARY KEY  (`playerID`,`yearID`,`round`),
  KEY `player` (`playerID`),
  KEY `player2` (`playerID`,`yearID`,`teamID`,`lgID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SeriesPost`
--

DROP TABLE IF EXISTS `SeriesPost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SeriesPost` (
  `yearID` int(4) NOT NULL default '0',
  `round` varchar(5) NOT NULL default '',
  `teamIDwinner` varchar(3) default NULL,
  `lgIDwinner` varchar(2) NOT NULL default '',
  `teamIDloser` varchar(3) default NULL,
  `lgIDloser` varchar(2) NOT NULL default '',
  `wins` int(1) NOT NULL default '0',
  `losses` int(1) NOT NULL default '0',
  `ties` int(1) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Schools`
--

DROP TABLE IF EXISTS `Schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Schools` (
  `schoolID` varchar(15) NOT NULL default '',
  `schoolName` varchar(255) NOT NULL default '',
  `schoolCity` varchar(55) default NULL,
  `schoolState` varchar(55) default NULL,
  `schoolNick` varchar(55) default NULL,
  PRIMARY KEY  (`schoolID`),
  KEY `schoolID` (`schoolID`,`schoolName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SchoolsPlayers`
--

DROP TABLE IF EXISTS `SchoolsPlayers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchoolsPlayers` (
  `playerID` varchar(9) NOT NULL default '',
  `schoolID` varchar(15) NOT NULL default '',
  `yearMin` int(4) default NULL,
  `yearMax` int(4) default NULL,
  PRIMARY KEY  (`playerID`,`schoolID`),
  KEY `schoolID` (`schoolID`,`yearMin`,`yearMax`),
  KEY `schoolID_2` (`schoolID`,`yearMax`,`yearMin`),
  KEY `playerID` (`playerID`,`yearMin`,`yearMax`),
  KEY `playerID_2` (`playerID`,`yearMax`,`yearMin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xref_stats`
--

DROP TABLE IF EXISTS `xref_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xref_stats` (
  `playerID` varchar(9) NOT NULL default '',
  `statsID` int(5) default NULL,
  PRIMARY KEY  (`playerID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Appearances`
--

DROP TABLE IF EXISTS `Appearances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Appearances` (
  `yearID` smallint(4) NOT NULL default '0',
  `teamID` char(3) NOT NULL default '',
  `lgID` char(2) default NULL,
  `playerID` char(9) NOT NULL default '',
  `experience` tinyint(2) unsigned default NULL,
  `G_all` tinyint(3) unsigned default NULL,
  `GS` tinyint(3) unsigned default NULL,
  `G_batting` tinyint(3) unsigned default NULL,
  `G_defense` tinyint(3) unsigned default NULL,
  `G_p` tinyint(3) unsigned default NULL,
  `G_c` tinyint(3) unsigned default NULL,
  `G_1b` tinyint(3) unsigned default NULL,
  `G_2b` tinyint(3) unsigned default NULL,
  `G_3b` tinyint(3) unsigned default NULL,
  `G_ss` tinyint(3) unsigned default NULL,
  `G_lf` tinyint(3) unsigned default NULL,
  `G_cf` tinyint(3) unsigned default NULL,
  `G_rf` tinyint(3) unsigned default NULL,
  `G_of` tinyint(3) unsigned default NULL,
  `G_dh` tinyint(3) unsigned default NULL,
  `G_ph` tinyint(3) unsigned default NULL,
  `G_pr` tinyint(3) unsigned default NULL,
  PRIMARY KEY  (`yearID`,`teamID`,`playerID`),
  KEY `playerID` (`playerID`,`yearID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-28 17:12:38
