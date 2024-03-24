/*
    I would prefer materialized view because the data provided by e-commerce here is not frequently changed and we need
    physically represented pre-computed data in order to quickly provide customer data.
    Precomputed and stored data is efficient and periodic update is unnecessary.
    Unfortunately virtual view is not suitable because speed is important in this case.
*/

DROP MATERIALIZED VIEW IF EXISTS customer_view;

CREATE MATERIALIZED VIEW customer_view AS
SELECT c.customer_id, c.name AS name, c.surname AS surname, o.order_id, o.order_time, o.shipping_time, o.status,
       p.product_id, p.name AS product_name, sc.amount, p.price

FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN shopping_carts sc ON o.order_id = sc.order_id
JOIN products p ON sc.product_id = p.product_id;