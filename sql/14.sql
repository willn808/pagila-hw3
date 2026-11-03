/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

WITH film_rentals AS (
    SELECT cat.name, f.film_id, f.title, count(*) AS "total rentals"
    FROM category cat
    JOIN film_category fc USING (category_id)
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    GROUP BY cat.name, f.film_id, f.title
),
ranked AS (
    SELECT *,
           rank() OVER (PARTITION BY name ORDER BY "total rentals" DESC, film_id DESC) AS rnk
    FROM film_rentals
)
SELECT name, title, "total rentals"
FROM ranked
WHERE rnk <= 5
ORDER BY name, "total rentals" DESC, title;
