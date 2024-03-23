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

     Find which product category pair is ordered together most. List 10 pairs, and the number of
    orders. Consider non-cancelled, non-refunded orders. Consider 2 different categories in pairs.
    Return category 1, category 2, and the order count in descending order by count.
*/

WITH ordered_products AS (
    SELECT o.order_id, p.category_id AS category_id
    FROM orders o
    JOIN shopping_carts sc ON o.order_id = sc.order_id
    JOIN products p ON sc.product_id = p.product_id
    LEFT JOIN refunds r ON o.order_id = r.order_id
    WHERE o.status != 'CANCELLED' AND r.order_id IS NULL
),
category_pairs AS (
    SELECT op1.category_id AS category1, op2.category_id AS category2
    FROM ordered_products op1
    JOIN ordered_products op2 ON op1.order_id = op2.order_id
    WHERE op1.category_id != op2.category_id
)
SELECT pc1.name AS category1, pc2.name AS category2, COUNT(*) AS total_value
FROM category_pairs cp
JOIN product_categories pc1 ON cp.category1 = pc1.category_id
JOIN product_categories pc2 ON cp.category2 = pc2.category_id
GROUP BY cp.category1, cp.category2, pc1.name, pc2.name
HAVING pc1.name < pc2.name
ORDER BY total_value DESC
LIMIT 10;




