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

    Trigger #1: We want to keep average product prices per product category.
    • Write query to create category avg prices table, by taking the average price of products
    in a category.
    • This table should contain category id and avg price.
    • Then write queries to trigger an update on category avg prices table, when a new product
    is added to the database.
    • You can assume that the product category will exist in the database, while adding the
    product.
*/

DROP TABLE IF EXISTS category_avg_prices CASCADE;
DROP FUNCTION IF EXISTS update_avg_price;
/*DROP TRIGGER IF EXISTS update_avg_price_trigger;*/

CREATE TABLE category_avg_prices (
  category_id INTEGER PRIMARY KEY,
  avg_price FLOAT
);

INSERT INTO category_avg_prices (category_id, avg_price)
SELECT category_id, AVG(price) AS avg_price
FROM products
GROUP BY category_id
ORDER BY category_id;

/*
CREATE OR REPLACE FUNCTION update_avg_price()
RETURNS TRIGGER AS $$
BEGIN
    DECLARE category_avg DECIMAL(10, 2);
    
    -- Calculate the new average price for the category of the newly added product
    SELECT AVG(price) INTO category_avg_prices
    FROM products
    WHERE category_id = NEW.category_id;
    
    -- Update the category_avg_prices table with the new average price
    UPDATE category_avg_prices
    SET avg_price = category_avg
    WHERE category_id = NEW.category_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_avg_price_trigger
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION update_avg_price();
*/



