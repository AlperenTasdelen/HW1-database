psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS product_categories CASCADE;"
psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS products CASCADE;"
psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS customers CASCADE;"
psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS orders CASCADE;"
psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS shopping_carts CASCADE;"
psql -U alperentasdelen -d postgres -c "DROP TABLE IF EXISTS refunds CASCADE;"
