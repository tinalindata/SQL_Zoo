--- 1. 1962 movies
--- List the films where the yr is 1962 [Show id, title]

SELECT id, title
FROM movie
WHERE yr=1962;

--- 2. When was Citizen Kane released?
--- Give year of 'Citizen Kane'.

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

--- 3. Star Trek movies
--- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

--- 4. id for actor Glenn Close
--- What id number does the actor 'Glenn Close' have?

SELECT DISTINCT(id)
FROM actor 
JOIN casting
ON id = actorid
WHERE name = 'Glenn Close';

--- 5. id for Casablanca
--- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

--- 6. Cast list for Casablanca
--- Obtain the cast list for 'Casablanca'. The cast list is the names of the actors who were in the movie. Use movieid=11768, (or whatever value you got from the previous question)

SELECT name
FROM casting
JOIN actor 
ON id = actorid
WHERE movieid = 11768;

--- 7. Alien cast list
--- Obtain the cast list for the film 'Alien'

SELECT a.name
FROM casting c
JOIN movie m
ON c.movieid = m.id 
JOIN actor a 
ON a.id = c.actorid
WHERE title = 'Alien';

--- 8. Harrison Ford movies
--- List the films in which 'Harrison Ford' has appeared

SELECT m.title
FROM casting c
JOIN movie m
ON c.movieid = m.id 
JOIN actor a 
ON a.id = c.actorid
WHERE name = 'Harrison Ford';

--- 9. Harrison Ford as a supporting actor
--- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT m.title
FROM casting c
JOIN movie m
ON c.movieid = m.id 
JOIN actor a 
ON a.id = c.actorid
WHERE name = 'Harrison Ford' and ord <> 1;

--- 10. Lead actors in 1962 movies
--- List the films together with the leading star for all 1962 films.

SELECT m.title, a.name
FROM casting c
JOIN movie m
ON c.movieid = m.id 
JOIN actor a 
ON a.id = c.actorid
WHERE yr = 1962 and ord = 1;

--- 11. Busy years for Rock Hudson
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(*)
FROM casting c
  JOIN movie m
  ON c.movieid = m.id 
  JOIN actor a 
  ON a.id = c.actorid
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(*) > 2;

--- 12. Lead actor in Julie Andrews movies
--- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name
FROM casting c
  JOIN movie m
  ON c.movieid = m.id 
  JOIN actor a 
  ON a.id = c.actorid
WHERE ord = 1 
  AND movieid IN (SELECT movieid
                  FROM casting c
                  JOIN movie m
                  ON c.movieid = m.id 
                  JOIN actor a 
                  ON a.id = c.actorid
                  WHERE a.name = 'Julie Andrews');
