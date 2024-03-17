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
