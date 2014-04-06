-- ===========================================================================
--
-- People Table
--

SELECT NOW() AS starting_datetime, "people: ids from all sources";

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `lahmanID`     INT(11)      DEFAULT NULL,
  `playerID`     char(9)      CHARACTER SET ascii DEFAULT NULL,
  `bbrefID`      char(9)      CHARACTER SET ascii DEFAULT NULL,
  `retroID`      char(8)      CHARACTER SET ascii DEFAULT NULL,
  --
  `nameCommon`   VARCHAR(100) DEFAULT NULL,
  --
  `birthYear`    INT(11)      DEFAULT NULL,
  `birthMonth`   INT(11)      DEFAULT NULL,
  `birthDay`     INT(11)      DEFAULT NULL,
  `birthCountry` VARCHAR(50)  DEFAULT NULL,
  `birthState`   VARCHAR(2)   DEFAULT NULL,
  `birthCity`    VARCHAR(50)  DEFAULT NULL,
  `deathYear`    INT(11)      DEFAULT NULL,
  `deathMonth`   INT(11)      DEFAULT NULL,
  `deathDay`     INT(11)      DEFAULT NULL,
  `deathCountry` VARCHAR(50)  DEFAULT NULL,
  `deathState`   VARCHAR(2)   DEFAULT NULL,
  `deathCity`    VARCHAR(50)  DEFAULT NULL,
  `nameFirst`    VARCHAR(50)  DEFAULT NULL,
  `nameLast`     VARCHAR(50)  DEFAULT NULL,
  `nameNote`     VARCHAR(255) DEFAULT NULL,
  `nameGiven`    VARCHAR(255) DEFAULT NULL,
  `nameNick`     VARCHAR(255) DEFAULT NULL,
  --
  `weight`       INT(11)      DEFAULT NULL,
  `height`       FLOAT        DEFAULT NULL,
  `bats`         VARCHAR(1)   DEFAULT NULL,
  `throws`       VARCHAR(1)   DEFAULT NULL,
  `debut`        VARCHAR(10)  DEFAULT NULL,
  `finalGame`    VARCHAR(10)  DEFAULT NULL,
  `college`      VARCHAR(50)  DEFAULT NULL,
  --
  `managerID`    CHAR(10)     CHARACTER SET ascii DEFAULT NULL,
  `hofID`        CHAR(10)     CHARACTER SET ascii DEFAULT NULL,

  PRIMARY KEY (`lahmanID`),
  UNIQUE KEY `bbrefID`   (`bbrefID`),
  UNIQUE KEY `playerID`  (`playerID`),
  UNIQUE KEY `retroID`   (`retroID`,`bbrefID`),
  UNIQUE KEY `managerID` (`managerID`),
  UNIQUE KEY `hofID`     (`hofID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

REPLACE INTO `people`
        (`playerID`, `retroID`, `lahmanID`, `bbrefID`, `birthYear`, `birthMonth`, `birthDay`, `birthCountry`, `birthState`, `birthCity`, `deathYear`, `deathMonth`, `deathDay`, `deathCountry`, `deathState`, `deathCity`, `nameFirst`, `nameLast`, `nameNote`, `nameGiven`, `nameNick`, `weight`, `height`, `bats`, `throws`, `debut`, `finalGame`, `college`, `managerID`, `hofID`)
  SELECT `playerID`, `retroID`, `lahmanID`, `bbrefID`, `birthYear`, `birthMonth`, `birthDay`, `birthCountry`, `birthState`, `birthCity`, `deathYear`, `deathMonth`, `deathDay`, `deathCountry`, `deathState`, `deathCity`, `nameFirst`, `nameLast`, `nameNote`, `nameGiven`, `nameNick`, `weight`, `height`, `bats`, `throws`, `debut`, `finalGame`, `college`, `managerID`, `hofID`
  FROM `master`
  ;
