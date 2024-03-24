CREATE OR REPLACE FUNCTION check_shopping_cart_amount()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.amount <= 0 THEN
        RAISE EXCEPTION 'Invalid amount in shopping cart: %', NEW.amount;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER shopping_cart_amount_trigger
BEFORE INSERT ON shopping_carts
FOR EACH ROW
EXECUTE FUNCTION check_shopping_cart_amount();
