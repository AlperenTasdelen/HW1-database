DROP TABLE IF EXISTS category_avg_prices CASCADE;
DROP FUNCTION IF EXISTS update_avg_price;
/*DROP TRIGGER IF EXISTS update_avg_price_trigger;*/

CREATE TABLE category_avg_prices (
  category_id INTEGER PRIMARY KEY,
  avg_price DECIMAL (10, 2) NOT NULL
);

INSERT INTO category_avg_prices (category_id, avg_price)
SELECT category_id, AVG(price) AS avg_price
FROM products
GROUP BY category_id
ORDER BY category_id;

CREATE OR REPLACE FUNCTION update_avg_price_function() RETURNS TRIGGER AS $$
DECLARE
    avg_price DECIMAL(10, 2);
BEGIN
    SELECT AVG(price) INTO avg_price
    FROM products
    WHERE category_id = NEW.category_id;
    
    UPDATE category_avg_prices
    SET avg_price = avg_price
    WHERE category_id = NEW.category_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_avg_price
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION update_avg_price_function();





