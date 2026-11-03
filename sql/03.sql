/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT co.country, sum(p.amount) AS total_payments
FROM payment p
JOIN customer c USING (customer_id)
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id)
GROUP BY co.country
ORDER BY total_payments DESC, co.country;
