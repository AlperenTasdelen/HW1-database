WITH gender_month_spent AS (
    SELECT 
        COALESCE(c.gender, NULL) AS gender,
        TO_CHAR(o.order_time, 'Month') AS month_name,
        SUM(p.price * sc.amount) AS total_money_spent
    FROM 
        orders o
    JOIN 
        shopping_carts sc ON o.order_id = sc.order_id
    JOIN 
        products p ON sc.product_id = p.product_id
    JOIN 
        customers c ON o.customer_id = c.customer_id
    GROUP BY 
        CUBE(c.gender, TO_CHAR(o.order_time, 'Month'))
)
SELECT 
    gender,
    month_name AS month,
    total_money_spent AS cart_total
FROM 
    gender_month_spent
ORDER BY 
    gender NULLS LAST, 
    month_name NULLS LAST;