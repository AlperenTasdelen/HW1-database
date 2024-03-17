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

    Task: List the first 25% product categories that were in the refunded orders, because of a fraud
    suspicion. Return category name and fraud count in descending order by fraud count. You
    must solve this using “ntile” function. Using PostgreSQL.

*/