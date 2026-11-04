BEGIN;
UPDATE products
SET stock = stock - 5
WHERE product_id = 1
AND stock >= 5;
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 1;
ROLLBACK;
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 1;