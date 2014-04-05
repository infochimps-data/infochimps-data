-- ALTER TABLE `events`
--   ADD COLUMN yearID       SMALLINT(4) DEFAULT NULL AFTER game_id,
--   ADD COLUMN gamedate     DATE        DEFAULT NULL AFTER yearID,
--   ADD        KEY `batter`    (`bat_ID`, yearID),
--   ADD        KEY `pitcher`   (`pit_ID`, yearID),
--   ADD        KEY `team_h`    (`home_team_id`, yearID),
--   ADD        KEY `team_a`    (`away_team_id`, yearID)
--   ;

UPDATE `events`
  SET
    yearID       = SUBSTRING(game_id,4,4), 
    gamedate     = SUBSTRING(game_id,4,8)
  ;
