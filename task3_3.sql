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

    Create a customer view that allows customers to see only their shopping cart, and
    orders. They should not have access to refunds, orders, details of other customers (like in a
    realistic e-commerce site) Which type of view you would choose, standard or materialized?
    What are the reasons? Explain briefly in a few sentences and put your SQL query in the .sql
    file.
*/

DROP MATERIALIZED VIEW IF EXISTS customer_view;

CREATE MATERIALIZED VIEW customer_view AS
SELECT c.customer_id, c.name AS name, c.surname AS surname, o.order_id, o.order_time, o.shipping_time, o.status,
       p.product_id, p.name AS product_name, sc.amount, p.price

FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN shopping_carts sc ON o.order_id = sc.order_id
JOIN products p ON sc.product_id = p.product_id;