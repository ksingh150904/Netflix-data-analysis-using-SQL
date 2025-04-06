-- Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*)
FROM netflix_titles
GROUP BY 1

-- Find the most common rating for movies and TV shows

WITH RatCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix_titles
    GROUP BY type, rating
),
RankedRating AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) as rank
    FROM RatCounts
)
SELECT 
    type,
    rating AS most_freq_rating
FROM RankedRating
WHERE rank = 1;


-- List all movies released in a specific year (e.g., 2020)

SELECT * 
FROM netflix_titles
WHERE release_year = 2020


-- Find the top 5 countries with the most content on Netflix

SELECT * 
FROM
(
	SELECT
		UNNEST(STRING_TO_ARRAY(country, ',')) as country,
		COUNT(*) as total_content
	FROM netflix_titles
	GROUP BY 1
)as t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5


-- Identify the longest movie

SELECT 
	*
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC


-- Find content added in the last 5 years
SELECT
*
FROM netflix_titles
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'



-- List all TV shows with more than 5 seasons

SELECT *
FROM netflix_titles
WHERE 
	TYPE = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::INT > 5


-- Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix_titles
GROUP BY 1


--  Find each year and the average numbers of content release by India on netflix. 


SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
	ROUND(
		COUNT(show_id)::numeric/
								(SELECT COUNT(show_id) FROM netflix_titles WHERE country = 'India')::numeric * 100
		,2
		)
		as avg_release
FROM netflix_titles
WHERE country = 'India' 
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5



-- Find the top 10 actors who have appeared in the highest number of movies produced in India.



SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix_titles
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

/*
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/


SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix_titles
) AS categorized_content
GROUP BY 1,2
ORDER BY 2


