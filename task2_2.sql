/*
    *product_categories*
    category_id
    name

    *products*
    product_id
    name
    category_id
    weight
    price
    
    *customers*
    customer_id
    name
    surname
    address
    state
    gender

    *orders*
    order_id
    customer_id
    order_time
    shipping_time
    status

    *shopping_carts*
    order_id
    product_id
    amount

    *refunds*
    order_id
    reason

    Task:  Find the customers who have the most expensive order for each month. Return customer ids,
    year, month, cart total in ascending order by month. Using PostgreSQL.

*/

WITH monthly_orders AS (
    SELECT
        EXTRACT(YEAR FROM order_time) AS year,
        EXTRACT(MONTH FROM order_time) AS month,
        customer_id,
        order_id,
        SUM(price * amount) AS cart_total,
        ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM order_time), EXTRACT(MONTH FROM order_time) ORDER BY SUM(price * amount) DESC) AS rn
    FROM
        orders
    JOIN
        shopping_carts USING (order_id)
    JOIN
        products USING (product_id)
    GROUP BY
        EXTRACT(YEAR FROM order_time),
        EXTRACT(MONTH FROM order_time),
        customer_id,
        order_id
)
SELECT
    customer_id,
    year,
    month,
    cart_total
FROM
    monthly_orders
WHERE
    rn = 1
ORDER BY
    year ASC,
    month ASC;
