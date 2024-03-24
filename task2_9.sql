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

     Users & permissions:
    • Create a user and login to the database with that user.
    • Try to query all cancelled orders.
    • Now give permission to query orders table to the new user.
    • Try to query all cancelled orders again.
    • Write down all your observations and queries you executed during this process. Basic
    .txt file will be enough for this report. Please be brief for your explanations.
*/

/*
    First I created a new user and logged in to the database.
    I tried to query some tables but I got an error because I have no permission over querying data.
    Then I granted permission to the new user (myself) to the table which I want to work on.
    Tried to query same same tables again and got a successful result.

    CREATE USER task2_9;
    SET PASSWORD FOR task2_9 = PASSWORD('task2_9');
    GRANT CONNECT TO task2_9;
    USE postgres;

    SELECT * FROM orders WHERE status = 'COMPLETED';
    -- This query got an error indicating permission errors.

    GRANT SELECT ON orders TO task2_9;
    -- This query granted permission to the new user to query orders table.

    SELECT * FROM orders WHERE status = 'COMPLETED';
    -- This query got a successful result.
*/