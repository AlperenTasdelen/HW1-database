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

    Find customers who returned their order after the order is completed. For each such customer,
    list customer id, gender and the total amount of money that must be refunded, in ascending
    order of customer ids. You must solve this using “partition by”.
*/


WITH refunded_orders AS (
    SELECT 
        o.customer_id,
        o.order_id,
        SUM(p.price * sc.amount) AS refund_amount,
        ROW_NUMBER() OVER(PARTITION BY o.customer_id ORDER BY o.customer_id) AS rn
    FROM 
        orders o
    INNER JOIN 
        refunds r ON o.order_id = r.order_id
    INNER JOIN 
        shopping_carts sc ON o.order_id = sc.order_id
    INNER JOIN 
        products p ON sc.product_id = p.product_id
    WHERE 
        o.status = 'COMPLETED'
    GROUP BY 
        o.customer_id, o.order_id
),
customers_refunds AS (
    SELECT 
        c.customer_id,
        c.gender,
        SUM(CASE WHEN r.refund_amount IS NULL THEN 0 ELSE r.refund_amount END) AS total_refund_amount
    FROM 
        customers c
    LEFT JOIN 
        refunded_orders r ON c.customer_id = r.customer_id
    GROUP BY 
        c.customer_id, c.gender
)
SELECT 
    customer_id,
    gender,
    total_refund_amount AS sum
FROM 
    customers_refunds
WHERE 
    total_refund_amount > 0
ORDER BY 
    customer_id;
