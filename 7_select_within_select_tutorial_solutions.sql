--- 1. Bigger than Russia
--- List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

--- 2. Richer than UK
--- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world 
WHERE continent = 'Europe' 
   AND gdp/population > (SELECT gdp/population 
                         FROM world
                         WHERE name = 'United Kingdom');

--- 3. Neighbours of Argentina and Australia
--- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent 
                    FROM world 
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

--- 4. Between Canada and Poland
--- Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population 
                    FROM world
                    WHERE name = 'Canada')
   AND population < (SELECT population 
                     FROM world
                     WHERE name = 'Poland');
 
 --- 5. Percentages of Germany
 --- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
 
 SELECT name, 
    CONCAT(ROUND(population*100/(SELECT population
                         FROM world
                         WHERE name = 'Germany'                                              
)), '%') AS percentage              
FROM world; 

--- 6. Bigger than every country in Europe
--- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name 
FROM world 
WHERE gdp > ALL(SELECT gdp 
                FROM world
                WHERE continent = 'Europe'
                AND gdp > 0);
 
--- 7. Largest in each continent
--- Find the largest country (by area) in each continent, show the continent, the name and the area
SELECT continent, name, area 
FROM world x
WHERE area >= ALL
                   (SELECT area
                    FROM world y
                    WHERE y.continent=x.continent
                    AND population>0);
--- Method 2: 
SELECT w1.continent, name, w1.area 
FROM world AS w1
  JOIN (SELECT continent, MAX(area) AS area
          FROM world 
         GROUP BY continent) AS w2
    ON w1.continent = w2.continent
   AND w1.area = w2.area

--- 8. First country of each continent (alphabetically)
--- List each continent and the name of the country that comes first alphabetically.

SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name 
                  FROM world y 
                  WHERE x.continent = y.continent);

--- 9. Difficult Questions That Utilize Techniques Not Covered In Prior Sections
--- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population 
FROM world x
WHERE 25000000 >= ALL(SELECT population
                      FROM world y
                      WHERE x.continent = y.continent);
 
--- 10. Three time bigger
--- Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world x
WHERE population/3 >= ALL 
                       (SELECT population
                        FROM world y
                        WHERE x.continent = y.continent
                              AND x.name != y.name);
 
