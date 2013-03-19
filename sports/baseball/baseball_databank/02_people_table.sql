-- ===========================================================================
--
-- People Table
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `lahmanID`    int(11)      DEFAULT NULL,
  `playerID`    varchar(10)  CHARACTER SET ascii DEFAULT NULL,
  `bbrefID`     varchar(9)   CHARACTER SET ascii DEFAULT NULL,
  `retroID`     varchar(9)   CHARACTER SET ascii DEFAULT NULL,
  --
  `nameCommon`  varchar(100) DEFAULT NULL,
  --
  `birthYear`   int(11)      DEFAULT NULL,
  `birthMonth`  int(11)      DEFAULT NULL,
  `birthDay`    int(11)      DEFAULT NULL,
  `birthCountry` varchar(50) DEFAULT NULL,
  `birthState`  varchar(2)   DEFAULT NULL,
  `birthCity`   varchar(50)  DEFAULT NULL,
  `deathYear`   int(11)      DEFAULT NULL,
  `deathMonth`  int(11)      DEFAULT NULL,
  `deathDay`    int(11)      DEFAULT NULL,
  `deathCountry` varchar(50) DEFAULT NULL,
  `deathState`  varchar(2)   DEFAULT NULL,
  `deathCity`   varchar(50)  DEFAULT NULL,
  `nameFirst`   varchar(50)  DEFAULT NULL,
  `nameLast`    varchar(50)  DEFAULT NULL,
  `nameNote`    varchar(255) DEFAULT NULL,
  `nameGiven`   varchar(255) DEFAULT NULL,
  `nameNick`    varchar(255) DEFAULT NULL,
  --
  `weight`      int(11)      DEFAULT NULL,
  `height`      double       DEFAULT NULL,
  `bats`        varchar(1)   DEFAULT NULL,
  `throws`      varchar(1)   DEFAULT NULL,
  `debut`       varchar(10)  DEFAULT NULL,
  `finalGame`   varchar(10)  DEFAULT NULL,
  `college`     varchar(50)  DEFAULT NULL,
  --
  `managerID`   varchar(10)  CHARACTER SET ascii DEFAULT NULL,
  `hofID`       varchar(10)  CHARACTER SET ascii DEFAULT NULL,

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
