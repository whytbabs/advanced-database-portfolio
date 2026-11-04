SELECT *
FROM customers;
SELECT
    product_id,
    product_name,
    price,
    stock
FROM products
WHERE stock > 0;
SELECT
    product_name,
    price
FROM products
WHERE price > 50000
ORDER BY price DESC;
SELECT
    c.customer_name,
    c.email,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;
SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY c.category_name;
SELECT
    SUM(amount) AS total_successful_sales
FROM payments
WHERE status = 'Successful';
SELECT
    COUNT(*) AS total_orders
FROM orders;
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;
SELECT
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;
SELECT
    ROUND(AVG(price), 2) AS average_product_price
FROM products;