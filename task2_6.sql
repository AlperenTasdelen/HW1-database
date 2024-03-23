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

     For each category find the product id that has been ordered most. Return the category,
    product id, amount and the difference of this amount compared to the previous category in
    decreasing order of amount. You must solve this using “lag” function.
*/

WITH OrderedProducts AS (
    SELECT
        p.product_id,
        p.category_id,
        o.customer_id,
        sc.amount AS amount,
        ROW_NUMBER() OVER(PARTITION BY p.category_id, p.product_id ORDER BY sc.amount DESC) AS row_num
    FROM
        products p
    INNER JOIN
        shopping_carts sc ON p.product_id = sc.product_id
    INNER JOIN
        orders o ON sc.order_id = o.order_id
    WHERE
        o.status = 'COMPLETED'
),

ProductWithPreviousAmount AS (
    SELECT
        op.product_id,
        op.category_id,
        op.amount,
        LAG(op.amount) OVER (PARTITION BY op.category_id ORDER BY op.amount DESC) AS previous_amount
    FROM
        OrderedProducts op
    WHERE
        op.row_num = 1
)

/*SELECT * FROM OrderedProducts;*/

SELECT
    pc.name AS category,
    pwa.product_id,
    pwa.amount,
    pwa.amount - COALESCE(pwa.previous_amount, 0) AS amount_difference
FROM
    ProductWithPreviousAmount pwa
INNER JOIN
    product_categories pc ON pwa.category_id = pc.category_id
ORDER BY
    pwa.amount DESC;