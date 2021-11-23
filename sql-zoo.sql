-- 6 --

-- 1.
SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER';

-- 2.
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

-- 3.
SELECT player,goal.teamid,stadium,mdate
FROM game 
JOIN goal 
ON id = goal.matchid
WHERE goal.teamid = 'GER';

-- 4.
SELECT team1, team2, goal.player
FROM game 
JOIN goal 
ON id = goal.matchid
WHERE player LIKE 'Mario%';

-- 5.
SELECT player, teamid, eteam.coach, gtime
FROM goal 
JOIN eteam 
ON eteam.id = teamid
WHERE gtime<=10;

-- 6.
SELECT mdate, eteam.teamname
FROM game 
JOIN eteam 
ON eteam.id = team1
WHERE eteam.coach = 'Fernando Santos';

-- 7.
SELECT goal.player
FROM game 
JOIN goal 
ON id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- 8.
SELECT DISTINCT player
FROM game 
JOIN goal ON id = goal.matchid
WHERE (team1='GER' OR team2='GER') AND goal.teamid!='GER';

-- 9.
SELECT teamname, COUNT(teamid)
FROM eteam 
JOIN goal ON id=teamid
GROUP BY teamname;

-- 10.
SELECT stadium, COUNT(*)
FROM game 
JOIN goal ON id=matchid
GROUP BY stadium;

-- 11.
SELECT matchid,mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- 12.
SELECT matchid,mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id 
WHERE teamid = 'GER' 
GROUP BY matchid, mdate;

-- 13.
SELECT mdate, team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game 
LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2



-- 7 --

-- 1.
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2.
SELECT yr
FROM movie
WHERE title =  'Citizen Kane';

-- 3.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4.
SELECT id
FROM actor
WHERE name = 'Glenn Close';


-- 5.
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6.
SELECT actor.name
FROM actor
JOIN casting ON actorid = actor.id
WHERE movieid = '11768';

-- 7.
SELECT actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.title = 'Alien';

-- 8.
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 9.
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;

-- 10.
SELECT title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE yr=1962 AND casting.ord = 1;

-- 11.
SELECT yr,COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12.
SELECT DISTINCT m.title, a.name
 FROM (
  SELECT movie.*
  FROM movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
  WHERE actor.name = 'Julie Andrews') AS m
 JOIN (
  SELECT actor.*, casting.movieid AS movieid
  FROM actor
  JOIN casting ON casting.actorid = actor.id
  WHERE casting.ord = 1) AS a
 ON m.id = a.movieid
 ORDER BY m.title;
 
-- 13.
SELECT name
FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY name
HAVING COUNT(*) >= 15;

-- 14.
SELECT title, COUNT(casting.actorid)
FROM movie
JOIN casting ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(casting.actorid) DESC, title

-- 15.
SELECT name FROM actor JOIN casting ON actor.id = actorid
WHERE movieid IN
  (SELECT id FROM movie WHERE title IN
    (SELECT title FROM movie JOIN casting ON movie.id = movieid WHERE actorid IN
      (SELECT id FROM actor WHERE name = 'Art Garfunkel')))
  AND name != 'Art Garfunkel'