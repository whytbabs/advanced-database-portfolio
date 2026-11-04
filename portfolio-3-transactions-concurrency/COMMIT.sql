BEGIN;
UPDATE products
SET stock = stock - 1
WHERE product_id = 1
AND stock >= 1;
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 1;
COMMIT;
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 1;