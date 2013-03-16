# Baseball Reference Data


## Wins Above Replacement (WAR)


http://www.baseball-reference.com/about/war_explained.shtml


### Column Headings

From [Baseball Reference's Glossary](http://www.baseball-reference.com/about/war_explained_glossary.shtml):

#### Batting Column Headings

* `name_common`
* `player_ID`
* `year_ID`
* `team_ID`
* `stint_ID`
* `lg_ID`
* `PA`                    - plate appearances
* `G`                     - games played
* `Inn`                   - innings played in field
* `runs_bat`              - batting runs from our modified wRAA
* `runs_br`               - baserunning runs, includes SB and CS runs
* `runs_dp`               - runs from avoiding GIDP's in DP situation GB's.
* `runs_field`            - total fielding runs from TZR and DRS
* `runs_infield`          - defensive dp turn runs
* `runs_outfield`         - outfield arm ratings
* `runs_catcher`          - catcher defense
* `runs_good_plays`       - superlative defensive plays
* `runs_defense`          - overall defensive ability
* `runs_position`         - runs from the position they play (non-pitching)
* `runs_position_p`       - adjustment to zero out the negative contribution of pitcher offense.
* `runs_replacement`      - the replacement level adjustment for the league
* `runs_above_rep`        - the sum of the above components (double-counting excluded)
* `runs_above_avg`        - same as runs_above_rep without runs_replacement
* `runs_above_avg_off`    - save as runs_above_avg without defense
* `runs_above_avg_def`    - defense plus position
* `WAA`                   - wins above average
* `WAA_off`               - wins above average using runs_above_avg_off
* `WAA_def`               - wins above average using runs_above_avg_def
* `WAR`                   - wins above replacement the final number
* `WAR_def`               - just defense and position
* `WAR_off`               - just offense, position and replacement level
* `WAR_rep`               - WAR attributable to replacement level
* `salary`                - what it says
* `pitcher`               - yes or no
* `teamRpG`               - an avg team runs scored with this player
* `oppRpG`                - an avg team runs allowed with this player
* `oppRpPA_rep`           - an avg team runs allowed per pa by a replacement player
* `oppRpG_rep`            - an avg team runs allowed per g by a replacement player
* `pyth_exponent`         - pythagenpat exponent based on run environment for avg teams
* `pyth_exponent_rep`     - pythagenpat exponent based on a run environment for a replacement player
* `waa_win_perc`          - the win percentage using the pyth_exponent and team and opp R/G
* `waa_win_perc_off`      - just for offense
* `waa_win_perc_def`      - just for defense
* `waa_win_perc_rep`      - how a replacent player would do.

#### Pitching Column Headings

* `name_common`
* `player_ID`
* `year_ID`
* `team_ID`
* `stint_ID`
* `lg_ID`
* `G`
* `GS`
* `IPouts`                - `IP * 3`
* `IPouts_start`          - as a starter
* `IPouts_relief`         - as a reliever
* `RA`                    - actual runs allowed
* `xRA`                   - expected runs allowed based on offenses faced and interleague play
* `xRA_sprp_adj`          - adjustment based on whether innings were as a starter or reliever
* `xRA_def_pitcher`       - adjustment based on the quality of the pitcher's defense behind them
* `PPF`                   - the pitcher's team park factor
* `PPF_custom`            - the park factor based on where they pitched
* `xRA_final`             - xRA with all needed adjustments
* `BIP`                   - balls in play
* `BIP_perc`              - percentage of team's balls in play (used for defensive adjustment)
* `RS_def_total`          - teams defensive runs saved
* `runs_above_avg`        - xRA_final - RA
* `runs_above_avg_adj`    - adjustment, so the runs_above_avg equal zero
* `runs_above_rep`        - runs_above_avg multiplied by the league replacement level factor
* `RpO_replacement`       - runs per out for a replacement level pitcher (used to get the win_loss_perc for WAR later)
* `GR_leverage_index_avg` - leverage in relief games
* `WAR`                   - wins above replacement
* `salary`
* `teamRpG`               - the R/G for an average team in games this pitcher pitched
* `oppRpG`                - an avg opp's R/G in games this pitcher pitched
* `pyth_exponent`         - pythagenpat exponent
* `waa_win_perc`          - wins above average W-L perc
* `WAA`                   - wins above avg
* `WAA_adj`               - adjustment to make these sum to zero.
* `oppRpG_rep`            - the run scoring of an avg team facing a replacement level pitcher
* `pyth_exponent_rep`     - that pythagenpat exponent
* `waa_win_perc_rep`      - and their W-L perc
* `WAR_rep`               - the amount of WAR attributable to replacement level


__________________________________________________________________________

### Baseball-Reference.com WAR Explained

Since we added Sean Smith's ("rallymonkey" to some) Wins Above Replacement measurement in 2010, we've seen its use expand in to many new areas and its popularity catch on in the media and the general population, but there have also been a lot of questions about how it's calculated and whether it has validity. In this tutorial, I'm going to run through the calculations in graphic detail and point out areas where our approach differs from some of the other popular WAR or WAR-like approaches.

#### How to Use WAR

The idea behind the WAR framework is that we want to know how much better a player is than what a team would typically have to replace that player. We start by comparing the player to average in a variety of venues and then compare our theoretical replacement player to the average player and add the two results together.

There is no one way to determine WAR. There are hundreds of steps to make this calculation, and dozens of places where reasonable people can disagree on the best way to implement a particular part of the framework. We have taken the utmost care and study at each step in the process, and believe all of our choices are well reasoned and defensible. But WAR is necessarily an approximation and will never be as precise or accurate as one would like.

We present the WAR values with decimal places because this relates the WAR value back to the runs contributed (as one win is about ten runs), but you should not take any full season difference between two players of less than one to two wins to be definitive (especially when the defensive metrics are included).

#### The Concept of Replacement Players

Average is a well-defined concept. You sum up all of the observations and then divide by the number of observations. We compute averages every day.

So why don't we compute Wins Above Average rather than Wins above Replacement? When computing the value of a major league player, average is a poor baseline for comparison. Average players are relatively rare and can be expensive to acquire. Average players don't make the league minimum. Plus, not all average performances are equal. A team would pay much more for 200 league average innings than for 50. When a star player is injured, they are rarely replaced by an average player--usually their replacement is much worse.

That last point is our premise here. Average players are relatively rare and difficult to obtain. Replacement level players, by their very definition, are players easy to obtain when a starter goes down. These are the players who receive non-roster invites at the start of the year or the players who are 6-year minor league free agents. Baseball talent among the population is generally distributed normally, but only the very right-end of that curve plays professional baseball.

                         __
                       _-  -_          replacement
                      /      \         level
                     /        \           |
                   _/          \_    |    |
                __/              \__ |    |
            ___/                    \|__  |
    ____---'                         |  `-|-____
                                     |mnrs| majors


There is some dispute over where to place the replacement level, but most sabermetricians agree that comparing players to a general replacement level is the best approach to valuing players. We'll talk more about this later.

Sports Reference sets replacement level at a .320 winning percentage for recent seasons. This means that we expect a team of replacement players to have a .320 win-loss percentage or a 52-110 record. We also set the value differently between the two leagues, since the AL has been shown to be the stronger league by inter-league play. This means that in the AL our replacement team might win 48 games while in the NL, 56 games.

### WAR: The General Idea

The basic currency of WAR is runs. We start with runs added or lost versus an average player and then compare the average player to a replacement player. I just got done saying we don't want to use averages, but an equation should explain what we are doing here.

	Players Runs over Replacement = Player_runs - ReplPlayer_runs
	  = (Player_runs - AvgPlayer_runs) + (AvgPlayer_runs - ReplPlayer_runs)

This gives us two components, player runs above average (RAA) and then the average player's runs above replacement.

Ultimately, baseball teams are interested in wins and losses, and so is WAR. RAA is converted to wins above average by running the results through a PythagenPat win-loss estimator (a rundown of PythagenPat. This allows us to more accurately model the interaction between the player and league and the effect on wins. Generally, ten runs will give you one win, but that does not always hold.

Adding up all of the WAR on a team (adjusting for replacement level), should get you very, very close to the team's actual wins and losses, and should match up even more closely with their Pythagorean win-loss records.

Unfortunately, the statistics at our disposal to compare Tris Speaker and Ken Griffey Jr. have changed over time. We now have exact data regarding types and location of batted balls, and this has led to improvements in various measurements (defensive measurements most notably). When we compute our metrics for the various components of WAR, we always use as much data as possible. For example, with baserunning this means that we'll use stolen bases alone when that is all we have, stolen bases and caught stealings when that is all we have, and full play-by-play accounts of steals by base, pickoffs, and advancements on passed balls, wild pitches, sac flies, doubles, singles, etc when we have that. Here is an up-to-date listing of our Data Coverage.

WAR is calculated separately for pitchers and for position players, so we'll deal with each of them separately.

* [WAR for Position Players](http://www.baseball-reference.com/about/war_explained_position.shtml)
* [WAR for Pitchers](http://www.baseball-reference.com/about/war_explained_pitch.shtml)
* [WAR Comparison](http://www.baseball-reference.com/about/war_explained_comparison.shtml)

### Converting Runs to Wins

If you had to pick one number over the history of baseball to convert runs into wins, it would 10 runs per win. Across 140 seasons, every ten runs a player adds or subtracts adds about one win, so if we were doing this by hand, we would use 10 runs per win and be done with it. We are using computers, though, so we can compute more exact values for every player and season.

With update 2.1, we are now on our third method for converting runs to wins. Version 1.0, used a R/W estimation based on the league's runs per game. With Version 2.0, we introduced a variable runs to wins estimation which varied with the leagues runs per game and the player's runs added or subtracted from average per game. This was an appropriate step, but the approximation we were using broke down for extreme players like 1985 Gooden, 2009 Greinke or 1999-2004 Bonds. I noticed this issue, but didn't quite followthrough on realizing it was a problem until after posting the numbers. Version 2.1, is going to fix this issue, but it complicates the calculation considerably, so we've split the explanation onto a separate page.

The league context obviously plays a major role in how much runs translate into a win. A typical Babe Ruth season is going to win you more games in 1912 than it would in 1933. Teams scored many fewer runs in 1912, so the value of each run is heightened.

The second effect is smaller, but still important. Each Babe Ruth run added has less value than a Wally Pipp run if both are placed into a league average context. Ruth, because he is so good, is going to produce some excess, unneeded runs. So since more of his runs are unneeded to produce wins, his runs to wins calculation will be higher than Pipp's. Ruth still produces way more wins than Pipp, but not as many as if we used a constant run estimation.

In the same way, dominant pitchers lower the run environment, so their runs saved become more valuable. Bob Gibson's runs saved will translate into more wins than the runs saved by a league average pitcher like Ken Johnson.

The runs to wins estimators are related to the pythagorean formula for baseball.

	Team Pythagorean W-L% = (RS2)/(RS2 + RA2)

This is using an exponent of two, but extensive research by a sabermetrician who goes by the nom de plume of Patriot has shown that using a variable exponent based on the run scoring environment of the league does better. So we get a better estimate called Team PythagenPat W-L% = (RSx)/(RSx + RAx) where x = (runs/gm).285, so if the two teams average 4.50 runs per game each the exponent is x = 9.285 = 1.87, not far off from 2.0, but a little better. Additional info on PythagenPat.

#### Thanks

I owe a big thanks to many people, but wanted to single out the following.

Sean Smith, who provided us with the original WAR incarnation on the site and provided much of the methodology used including, but not limited to TZR (pre-2003), GIDP runs, Baserunning Runs, Replacement Level, and Pitcher WAR.
Baseball Info Solutions licenses up their tremendous defensive metrics.
Tom Tango, who provided us with a great deal of feedback related to modifying and improving on wRAA and runs-to-wins calculations.
Neil Paine, who walked through each step of this rethinking with me.
RetroSheet, Pete Palmer and Baseball Info Solutions, for the batting, pitching, and fielding numbers that go into the system.
