/*
    In this PostgreSQL task, we will make SQL statements that It is used to create tables.

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

*/

DROP TABLE IF EXISTS product_categories, products, customers, orders, shopping_carts, refunds;

CREATE TABLE product_categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
  product_id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category_id INTEGER NOT NULL,
  weight NUMERIC NOT NULL,
  price NUMERIC NOT NULL
);

CREATE TABLE customers (
  customer_id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  surname VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  gender VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
  order_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  order_time TIMESTAMP NOT NULL,
  shipping_time TIMESTAMP,
  status VARCHAR(255) NOT NULL
);

CREATE TABLE shopping_carts (
  order_id UUID NOT NULL,
  product_id UUID NOT NULL,
  amount INTEGER NOT NULL
); 

CREATE TABLE refunds (
  order_id UUID NOT NULL,
  reason VARCHAR(255) NOT NULL
);

