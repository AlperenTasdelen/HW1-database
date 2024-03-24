WITH OrderedProducts AS (
    SELECT
        p.category_id,
        s.product_id,
        SUM(s.amount) AS total_amount,
        ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY SUM(s.amount) DESC) AS rank
    FROM
        products p
    INNER JOIN
        shopping_carts s ON p.product_id = s.product_id
    GROUP BY
        p.category_id, s.product_id
),
RankedProducts AS (
    SELECT
        op.category_id,
        op.product_id,
        op.total_amount,
        op.rank,
        LAG(op.total_amount) OVER (ORDER BY op.total_amount DESC) AS prev_amount
    FROM
        OrderedProducts op
    WHERE
        op.rank = 1
)
SELECT
    pc.name AS name,
    rp.product_id,
    rp.total_amount AS total_ordered,
    rp.total_amount - rp.prev_amount AS diff_with_previous
FROM
    RankedProducts rp
INNER JOIN
    product_categories pc ON rp.category_id = pc.category_id
ORDER BY
    rp.total_amount DESC;
