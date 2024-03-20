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

    Task: Find customers who returned their order after the order is completed. For each such customer,
    list customer id, gender and the total amount of money that must be refunded, in ascending
    order of customer ids. You must solve this using “partition by”. Using PostgreSQL.
*/

WITH CompletedOrders AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.status,
        r.order_id AS refund_order_id,
        r.reason,
        ROW_NUMBER() OVER (PARTITION BY o.order_id ORDER BY r.reason) AS refund_order_rank
    FROM 
        orders o
    LEFT JOIN 
        refunds r ON o.order_id = r.order_id
    WHERE 
        o.status = 'completed'
),
RefundAmounts AS (
    SELECT 
        co.customer_id,
        co.reason,
        SUM(p.price) OVER (PARTITION BY co.customer_id) AS total_refund_amount
    FROM 
        CompletedOrders co
    JOIN 
        products p ON co.refund_order_id = p.product_id
    WHERE 
        co.refund_order_rank = 1 -- considering only the first refund order per completed order
)
SELECT 
    c.customer_id,
    c.gender,
    COALESCE(RA.total_refund_amount, 0) AS "sum"
FROM 
    customers c
LEFT JOIN 
    RefundAmounts RA ON c.customer_id = RA.customer_id
ORDER BY 
    c.customer_id;

