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