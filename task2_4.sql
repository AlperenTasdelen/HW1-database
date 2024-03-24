WITH ValidOrders AS (
    SELECT o.order_id, o.order_time, o.status, p.price, sc.amount
    FROM orders o
    JOIN shopping_carts sc ON o.order_id = sc.order_id
    JOIN products p ON sc.product_id = p.product_id
    WHERE UPPER(o.status) != 'CANCELLED'
    AND o.order_id NOT IN (SELECT order_id FROM refunds)
),
DayOfWeekRevenue AS (
    SELECT 
        EXTRACT(DOW FROM vo.order_time) AS day_of_week,
        SUM(vo.price * vo.amount) AS daily_revenue,
        COUNT(DISTINCT DATE(vo.order_time)) AS valid_day_count
    FROM ValidOrders vo
    GROUP BY EXTRACT(DOW FROM vo.order_time)
)
SELECT 
    CASE 
        WHEN day_of_week = 0 THEN 'Sunday'
        WHEN day_of_week = 1 THEN 'Monday'
        WHEN day_of_week = 2 THEN 'Tuesday'
        WHEN day_of_week = 3 THEN 'Wednesday'
        WHEN day_of_week = 4 THEN 'Thursday'
        WHEN day_of_week = 5 THEN 'Friday'
        WHEN day_of_week = 6 THEN 'Saturday'
    END AS weekday,
    SUM(daily_revenue) / SUM(valid_day_count) AS avg_daily_revenue
FROM DayOfWeekRevenue
GROUP BY weekday
ORDER BY avg_daily_revenue DESC
LIMIT 3;