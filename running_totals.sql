-- Next order amount
SELECT order_id, amount,
LEAD(amount) OVER(ORDER BY order_id) AS next_amount 
FROM orders;

-- Compare with next
SELECT order_id, amount,
LEAD(amount) OVER(ORDER BY order_id) AS next_amount,
LEAD(amount) OVER(ORDER BY order_id) - amount AS difference 
FROM orders;

-- Running total
SELECT order_id, amount,
SUM(amount) OVER(ORDER BY order_id) AS running_total 
FROM orders;

-- Running total per customer
SELECT customer_id, order_id,  amount,
SUM(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_id
    ) AS customer_running_total 
FROM orders;

-- Running revenue
SELECT order_id, amount,
SUM(amount) OVER(ORDER BY order_id) AS total_revenue 
FROM orders;

-- Revenue growth
SELECT order_id, amount,
LEAD(amount) OVER(ORDER BY order_id) AS nesxt_order,
LEAD(amount) OVER(ORDER BY order_id) - amount AS growth
FROM orders;

-- Customer spending trend
SELECT customer_id, order_id, amount,
SUM(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_id
) AS total_spent 
FROM orders;

-- Highest cummulative spender moment
SELECT *
FROM (
    SELECT customer_id, order_id,
    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_id
    ) AS total_spent 
    FROM orders
) t 
ORDER BY total_spent DESC
LIMIT 1;