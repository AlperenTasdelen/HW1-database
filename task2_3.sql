WITH refunded_fraud_categories AS (
    SELECT pc.name AS category_name,
           COUNT(*) AS fraud_count
    FROM refunds r
    JOIN orders o ON r.order_id = o.order_id
    JOIN shopping_carts sc ON o.order_id = sc.order_id
    JOIN products p ON sc.product_id = p.product_id
    JOIN product_categories pc ON p.category_id = pc.category_id
    WHERE r.reason = 'FRAUD_SUSPICION'
    GROUP BY pc.name
),
category_fraud_percentiles AS (
    SELECT category_name,
           fraud_count,
           NTILE(4) OVER (ORDER BY fraud_count DESC) AS category_percentile
    FROM refunded_fraud_categories
)
SELECT category_name AS name,
       fraud_count
FROM category_fraud_percentiles
WHERE category_percentile = 1
ORDER BY fraud_count DESC
LIMIT (SELECT COUNT(*) FROM product_categories) / 4;

