SELECT
    product_id,
    product_name,
    stock
FROM products
WHERE product_id = 1;
BEGIN TRANSACTION
ISOLATION LEVEL READ COMMITTED;
SELECT
    product_id,
    product_name,
    stock
FROM products
WHERE product_id = 1;
SELECT
    product_id,
    product_name,
    stock
FROM products
WHERE product_id = 1;
COMMIT;