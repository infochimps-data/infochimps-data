
CREATE TABLE lg_averages AS
SELECT p.yearID, p.lgID
, ROUND(SUM(p.ER)/(SUM(p.ipouts/3))*9,2) as lgERA
, ROUND(g.cFIP+(SUM(p.HR)*13+(SUM(p.BB)+SUM(p.HBP))*3-SUM(p.so)*2)/(SUM(p.ipouts)/3),2) as lgFIP
FROM pitching p, GUTS g
WHERE p.yearID = g.season
GROUP BY yearID, lgID;

CREATE INDEX year_idx ON lg_averages (yearID);

-- ((g.cFIP+(SUM(p.HR)*13+(SUM(p.BB)+SUM(p.HBP))*3-SUM(p.so)*2)/(SUM(p.ipouts)/3)) / l.lgFIP

SELECT
CONCAT(m.namefirst," ",m.namelast) as NAME
, p.yearID, p.lgID
, ROUND(SUM(p.ER)/(SUM(p.ipouts/3))*9,2) as ERA
, ROUND(SUM(p.ER)/(SUM(p.ipouts/3))*9/l.lgERA*(200-t.ppf),0) as ERA_minus
, ROUND(g.cFIP+(sum(p.HR)*13+(sum(p.BB)+sum(p.HBP))*3-sum(p.so)*2)/(sum(p.ipouts)/3),2) as FIP
, ROUND(((g.cFIP+(sum(p.HR)*13+(sum(p.BB)+sum(p.HBP))*3-sum(p.so)*2)/(sum(p.ipouts)/3))/l.lgFIP*(200-t.ppf)),0) as FIP_minus
, ROUND((sum(p.ipouts)/3),1) as IP
, t.PPF
FROM pitching p, master m, GUTS g, lg_averages l, teams t
WHERE p.playerID = m.playerID 
AND p.yearID = l.yearID and p.yearID = t.yearID AND g.season = p.yearID AND p.yearID = 2012
AND p.teamID = t.teamID
AND p.lgID = t.lgID AND p.lgID = l.lgID
GROUP BY p.playerID, yearID, lgID
HAVING IP > 150
ORDER BY FIP asc
LIMIT 10;
