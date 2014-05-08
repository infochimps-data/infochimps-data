1.  `game_id`      -- Game ID, composed of home team ID, date, and game sequence id
2.  `event_seq`    -- Event sequence ID: All events are numbered consecutively throughout each game for easy reference. Note that there may be many events in a plate appearance, due to stolen bases and so forth.
3.  `year_id`      -- Year the game took place
4.  `game_date`    -- Game date, YYYY-mm-dd
5.  `game_seq`     -- Game sequence ID: 0 if only one game; otherwise 1 for first game in day, 2 for the second)
6.  `away_team_id` -- Team ID for the away (visiting) team; they bat first in each inning.
7.  `home_team_id` -- Team ID for the home team

8.  `inn`          -- Inning in which this play took place.
9.  `inn_home`     -- "0" if the visiting team is at bat, "1" if the home team is at bat
10. `beg_outs_ct`  -- Number of outs before this play.
11. `away_score`   -- Away score, the number of runs for the visiting team before this play.
12. `home_score`   -- Home score, the number of runs for the home team before this play.

13. `event_desc`   -- The complete description of the play using the format described for the event files.
14. `event_cd`     -- Simplified event type -- see below.
15. `hit_cd`       -- Value of hit: 0 = no hit; 1 = single; 2 = double; 3 = triple; 4 = home run.

16. `ev_outs_ct`   -- Number of outs recorded on this play.
17. `ev_runs_ct`   -- Number of runs recorded on this play.
18. `bat_dest`     -- The base which the batter reached at the conclusion of the play.  The value is 0 for an out, 4 if scores an earned run, 5 if scores and unearned, 6 if scores and team unearned.
19. `run1_dest`    -- Base reached by the runner on first at the conclusion of the play, using the same coding as `bat_dest`.  If there was no advance, then the base shown will be the one where the runner started.  Note that these runner fields are not updated on plays which end an inning, even if the inning-ending play would have resulted in an advance of one or more runners had it occurred earlier in the inning.
20. `run2_dest`    -- Base reached by the runner on second at the conclusion of the play -- see `run1_dest`.
21. `run3_dest`    -- Base reached by the runner on third at the conclusion of the play -- see `run1_dest`.

22. `is_end_bat`   -- 1 if the event terminated the batter's appearance; 0 means the same batter stayed at the plate, such as after a stolen base).
23. `is_end_inn`   -- 1 if the event terminated the inning.
24. `is_end_game`  -- 1 if this is the last record of a game.

25. `bat_team_id`  -- Team ID of the batting team
26. `fld_team_id`  -- Team ID of the fielding team
27. `pit_id`       -- Player ID code for the pitcher responsible for the play (NOTE: this is the `res_pit_id` field in the original).
28. `bat_id`       -- Player ID code for the batter responsible for the play (NOTE: this is the `res_bat_id` field in the original).
29. `run1_id`      -- Player ID code for the runner on first base, if any.
30. `run2_id`      -- Player ID code for the runner on second base, if any.
31. `run3_id`      -- Player ID code for the runner on third base, if any.																																																		

### Event Types

There are 25 different numeric codes to describe the type of event. They are:

```
    Code 	Meaning

    0    	Unknown event
    1    	No event
    2    	Generic out
    3    	Strikeout
    4    	Stolen base
    5    	Defensive indifference
    6    	Caught stealing
    7    	Pickoff error
    8    	Pickoff
    9    	Wild pitch
    10   	Passed ball
    11   	Balk
    12   	Other advance
    13   	Foul error
    14   	Walk
    15   	Intentional walk
    16   	Hit by pitch
    17   	Interference
    18   	Error
    19   	Fielder's choice
    20   	Single
    21   	Double
    22   	Triple
    23   	Home run
    24   	Missing play
```

































