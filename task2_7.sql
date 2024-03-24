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

    Write a single SQL query that computes the statistics present in a cross tabulation over
    genders and months. The aggregate value reported should be total money spent for each
    gender-month pair. Each row should contain gender, month name, total money spent. You
    must solve this using “cube” function. Also write a crosstab function with this query.
*/

WITH gender_month_spent AS (
    SELECT 
        COALESCE(c.gender, 'Total') AS gender,
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
    WHERE 
        o.status = 'COMPLETED'
    GROUP BY 
        CUBE(c.gender, TO_CHAR(o.order_time, 'Month'))
)
SELECT 
    gender,
    month_name,
    total_money_spent AS total_money_spent,
FROM 
    gender_month_spent
ORDER BY 
    gender NULLS LAST, 
    month_name NULLS LAST;



/*
CREATE OR REPLACE FUNCTION gender_month_cross_tab() RETURNS TABLE (gender TEXT, month INT, total_money_spent NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(c.gender, 'Total') AS gender,
        COALESCE(EXTRACT(MONTH FROM o.order_time), 0) AS month,
        SUM(p.price * sc.amount) AS total_money_spent
    FROM 
        orders o
    JOIN 
        customers c ON o.customer_id = c.customer_id
    JOIN 
        shopping_carts sc ON o.order_id = sc.order_id
    JOIN 
        products p ON sc.product_id = p.product_id
    WHERE 
        o.status = 'COMPLETED'
    GROUP BY 
        CUBE(c.gender, EXTRACT(MONTH FROM o.order_time))
    ORDER BY 
        c.gender, EXTRACT(MONTH FROM o.order_time);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM gender_month_cross_tab();
*/