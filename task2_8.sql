SELECT 
    pc.name AS category,
    p.name AS product_name,
    COUNT(r.order_id) AS refunded_orders,
    RANK() OVER (PARTITION BY pc.category_id ORDER BY COUNT(r.order_id) DESC) AS product_rank
FROM 
    products p
JOIN 
    product_categories pc ON p.category_id = pc.category_id
JOIN 
    shopping_carts sc ON p.product_id = sc.product_id
JOIN 
    orders o ON sc.order_id = o.order_id
JOIN 
    refunds r ON o.order_id = r.order_id
WHERE 
    r.reason = 'DAMAGED_DELIVERY'
GROUP BY 
    pc.category_id, p.product_id
ORDER BY 
    pc.name, product_rank, p.name;


