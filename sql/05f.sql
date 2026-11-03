/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

SELECT f2.title
FROM film_category fc1
JOIN film_category fc2 USING (category_id)
JOIN film f1 ON fc1.film_id = f1.film_id
JOIN film f2 ON fc2.film_id = f2.film_id
WHERE f1.title = 'AMERICAN CIRCUS'
GROUP BY f2.title
HAVING count(*) >= 2
INTERSECT
SELECT DISTINCT f2.title
FROM film_actor fa1
JOIN film_actor fa2 USING (actor_id)
JOIN film f1 ON fa1.film_id = f1.film_id
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f1.title = 'AMERICAN CIRCUS'
ORDER BY title;
