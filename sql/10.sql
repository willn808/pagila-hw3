/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

SELECT customer_id, name, total_payment, percentile
FROM (
    SELECT c.customer_id,
           c.first_name || ' ' || c.last_name AS name,
           sum(p.amount) AS total_payment,
           ntile(100) OVER (ORDER BY sum(p.amount)) AS percentile,
           c.first_name || c.last_name AS sk
    FROM customer c
    JOIN payment p USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name
) t
WHERE percentile >= 90
ORDER BY sk;
