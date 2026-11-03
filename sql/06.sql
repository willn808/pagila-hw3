/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

SELECT "Actor Name"
FROM (
    SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name",
                    a.first_name || a.last_name AS sk
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    JOIN actor r ON fa2.actor_id = r.actor_id
    WHERE r.first_name = 'RUSSELL' AND r.last_name = 'BACALL'
      AND a.actor_id <> r.actor_id
) t
ORDER BY sk;
