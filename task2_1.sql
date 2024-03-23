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
*/


WITH completed_orders AS (
    SELECT c.customer_id, o.order_id, o.status, c.gender
    FROM customers c, orders o, refunds r 
    WHERE c.customer_id = o.customer_id
    AND o.order_id = r.order_id
    AND o.status = 'COMPLETED'
)
SELECT co.customer_id, co.gender, SUM(p.price * sc.amount) AS sum
FROM completed_orders co, shopping_carts sc, products p
WHERE co.order_id = sc.order_id
AND sc.product_id = p.product_id
GROUP BY co.customer_id, co.gender;


/* PARTITION BY QUERY*/

/*
SELECT DISTINCT
    customer_id,
    gender,
    SUM(price * amount) OVER (PARTITION BY customer_id, gender) AS sum
FROM (
    SELECT
        c.customer_id,
        c.gender,
        p.price,
        sc.amount
    FROM 
        customers c
    JOIN 
        orders o ON c.customer_id = o.customer_id
    JOIN 
        refunds r ON o.order_id = r.order_id
    JOIN 
        shopping_carts sc ON o.order_id = sc.order_id
    JOIN 
        products p ON sc.product_id = p.product_id
    WHERE 
        o.status = 'COMPLETED'
    GROUP BY
        c.customer_id,
        c.gender,
        p.price,
        sc.amount
) AS completed_orders;

*/