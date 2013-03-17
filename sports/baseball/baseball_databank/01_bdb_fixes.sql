-- ===========================================================================
--
-- Fixes for 2012 Baseball Databank
--

-- correct a couple errors in the 2012 Baseball Databank (the 'January 9, 3:00 pm' release)

UPDATE `master`        SET `playerID` = 'baezjo01'  WHERE `lahmanID` = 460   AND `playerID` = 'baezda01';
UPDATE `master`        SET `bbrefID`  = 'snydech03' WHERE `lahmanID` = 19419 AND `playerID` = 'snydech03';
UPDATE `master`        SET `bbrefID`  = 'gilgahu01' WHERE `lahmanID` = 19417 AND `playerID` = 'gilgahu01';
UPDATE `AwardsPlayers` SET `playerID` = 'braunry02' WHERE `playerID` = 'braunry01' AND `awardID` = 'Silver Slugger' AND yearID = 2012 AND `lgID` = 'NL';
UPDATE `AwardsPlayers` SET `playerID` = 'brechha01' WHERE `playerID` = 'Brecheen'  AND `awardID` = 'Baseball Magazine All-Star';

-- ===========================================================================
--
-- Restore Indices for 2012 Baseball Databank
--

-- Optional: re-add indexes; joins very slow without

ALTER TABLE `master`
  ADD UNIQUE KEY `playerID`  (`playerID`),
  ADD UNIQUE KEY `bbrefID`   (`bbrefID`),
  ADD UNIQUE KEY `retroID`   (`retroID`,`bbrefID`),
  ADD UNIQUE KEY `managerID` (`managerID`),
  ADD UNIQUE KEY `hofID`     (`hofID`)
  ;
ALTER TABLE Teams
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE TeamsHalf
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Batting
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Pitching
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Fielding
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE BattingPost
  ADD KEY `playerID` (`playerID`,`yearID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE PitchingPost
  ADD KEY `playerID` (`playerID`,`yearID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE FieldingPost
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`),
  ADD KEY `round`    (`yearID`,`round`,`teamID`,`lgID`)
  ;
ALTER TABLE Managers
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Salaries
  ADD KEY `playerID` (`playerID`,`yearID`,`lgID`)
  ;
ALTER TABLE Appearances
  ADD KEY `playerID` (`playerID`,`yearID`)
  ;
