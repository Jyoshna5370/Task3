create database netflix_db;
use netflix;
CREATE TABLE netflix_titles (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title VARCHAR(255),
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(100),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    description TEXT
);
/*10 analytical queries*/
-- (1)Total no.of titles;
SELECT COUNT(*) AS total_titles
FROM netflix_titles;
-- (2)Movies vs TV Shows count;
SELECT type, COUNT(*) AS count
FROM netflix_titles
GROUP BY type;
-- (3)Top 10 countries by number of titles;
SELECT country, COUNT(*) AS content_count
FROM netflix_titles
GROUP BY country
ORDER BY content_count DESC
LIMIT 10;
-- (4)Top 10 genres;
SELECT listed_in AS genre, COUNT(*) AS genre_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY genre_count DESC
LIMIT 10;
-- (5)Release year distribution;
SELECT release_year, COUNT(*) AS count
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;
-- (6)Average duration of movies;
SELECT AVG(CAST(SUBSTRING(duration, 1, INSTR(duration, ' ') - 1) AS UNSIGNED)) AS avg_duration
FROM netflix_titles
WHERE type = 'Movie';
-- (7)TV Shows released in India;
SELECT title, release_year
FROM netflix_titles
WHERE country = 'India' AND type = 'TV Show';
-- (8)Most common rating;
SELECT rating, COUNT(*) AS rating_count
FROM netflix_titles
GROUP BY rating
ORDER BY rating_count DESC
LIMIT 1;
-- (9)Directors with most titles;
SELECT director, COUNT(*) AS title_count
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY title_count DESC
LIMIT 5;
-- (10) Subquery: Movies longer than average duration
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
AND CAST(SUBSTRING(duration, 1, INSTR(duration, ' ') - 1) AS UNSIGNED) >
    (SELECT AVG(CAST(SUBSTRING(duration, 1, INSTR(duration, ' ') - 1) AS UNSIGNED))
     FROM netflix_titles WHERE type = 'Movie');

SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv'
INTO TABLE netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM netflix_titles;
SELECT * FROM netflix_titles LIMIT 5;
