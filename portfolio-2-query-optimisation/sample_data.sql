
-- =====================================================
-- CAMPUSCART SAMPLE DATA
-- PORTFOLIO 2: QUERY PROCESSING AND OPTIMISATION
-- =====================================================

BEGIN;

-- 1. INSERT CUSTOMERS
INSERT INTO customers
(customer_name, email, phone, address)
VALUES
('John Adebayo', 'john@gmail.com', '08011111111', 'Lagos'),
('Mary Okafor', 'mary@gmail.com', '08022222222', 'Abuja'),
('David Bello', 'david@gmail.com', '08033333333', 'Ibadan'),
('Grace Eze', 'grace@gmail.com', '08044444444', 'Enugu'),
('Peter James', 'peter@gmail.com', '08055555555', 'Lagos'),
('Sarah Musa', 'sarah@gmail.com', '08066666666', 'Kano'),
('Daniel Obi', 'daniel@gmail.com', '08077777777', 'Port Harcourt'),
('Faith Johnson', 'faith@gmail.com', '08088888888', 'Lagos'),
('Michael Yusuf', 'michael@gmail.com', '08099999999', 'Kaduna'),
('Esther David', 'esther@gmail.com', '08100000000', 'Abuja')
ON CONFLICT (email) DO NOTHING;


-- 2. INSERT PRODUCT CATEGORIES
INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('Fashion', 'Clothing and fashion accessories'),
('Home Appliances', 'Household electrical appliances'),
('Books', 'Educational and general books'),
('Sports', 'Sports and fitness equipment')
ON CONFLICT (category_name) DO NOTHING;


-- 3. INSERT PRODUCTS
INSERT INTO products
(category_id, product_name, price, stock, description)
SELECT c.category_id, v.product_name,
       v.price, v.stock, v.description
FROM (VALUES
    ('Electronics', 'HP Laptop', 850000, 15, 'HP laptop 16GB RAM'),
    ('Electronics', 'Samsung Phone', 450000, 20, 'Samsung smartphone'),
    ('Electronics', 'Wireless Mouse', 12000, 50, 'Wireless computer mouse'),
    ('Electronics', 'Bluetooth Speaker', 35000, 25, 'Portable speaker'),
    ('Electronics', 'USB Keyboard', 18000, 30, 'Computer keyboard'),
    ('Fashion', 'Men Sneakers', 45000, 40, 'Casual sneakers'),
    ('Fashion', 'Ladies Handbag', 30000, 35, 'Fashion handbag'),
    ('Fashion', 'Wrist Watch', 25000, 28, 'Fashion wristwatch'),
    ('Home Appliances', 'Electric Blender', 65000, 12, 'Kitchen blender'),
    ('Home Appliances', 'Standing Fan', 95000, 18, 'Electric standing fan'),
    ('Home Appliances', 'Electric Kettle', 22000, 30, 'Water heating kettle'),
    ('Books', 'Database Systems Textbook', 18000, 45, 'Database learning book'),
    ('Books', 'Programming Guide', 15000, 40, 'Programming textbook'),
    ('Sports', 'Football', 12000, 50, 'Standard football'),
    ('Sports', 'Gym Dumbbells', 40000, 16, 'Fitness dumbbells')
) AS v(category_name, product_name, price, stock, description)
JOIN categories c
  ON c.category_name = v.category_name
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.product_name = v.product_name
);


-- 4. INSERT CUSTOMER ORDERS
INSERT INTO orders (customer_id, order_date, status)
SELECT c.customer_id, v.order_date::timestamp, v.status
FROM (VALUES
    ('john@gmail.com', '2026-01-05 10:00:00', 'Delivered'),
    ('mary@gmail.com', '2026-01-07 11:30:00', 'Delivered'),
    ('david@gmail.com', '2026-01-10 09:15:00', 'Delivered'),
    ('grace@gmail.com', '2026-01-12 14:00:00', 'Processing'),
    ('peter@gmail.com', '2026-01-15 12:00:00', 'Delivered'),
    ('sarah@gmail.com', '2026-01-18 16:30:00', 'Shipped'),
    ('daniel@gmail.com', '2026-01-20 13:00:00', 'Processing'),
    ('faith@gmail.com', '2026-01-22 10:45:00', 'Delivered'),
    ('michael@gmail.com', '2026-01-25 15:00:00', 'Cancelled'),
    ('esther@gmail.com', '2026-01-28 09:30:00', 'Pending')
) AS v(email, order_date, status)
JOIN customers c ON c.email = v.email
WHERE NOT EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date = v.order_date::timestamp
);


-- 5. INSERT ORDER ITEMS
INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
SELECT o.order_id, p.product_id, v.quantity, v.unit_price
FROM (VALUES
    ('john@gmail.com', '2026-01-05 10:00:00', 'HP Laptop', 1, 850000),
    ('john@gmail.com', '2026-01-05 10:00:00', 'Wireless Mouse', 1, 12000),
    ('mary@gmail.com', '2026-01-07 11:30:00', 'Samsung Phone', 1, 450000),
    ('mary@gmail.com', '2026-01-07 11:30:00', 'Wrist Watch', 1, 25000),
    ('david@gmail.com', '2026-01-10 09:15:00', 'Men Sneakers', 2, 45000),
    ('grace@gmail.com', '2026-01-12 14:00:00', 'Electric Blender', 1, 65000),
    ('peter@gmail.com', '2026-01-15 12:00:00', 'Standing Fan', 1, 95000),
    ('peter@gmail.com', '2026-01-15 12:00:00', 'Electric Kettle', 1, 22000),
    ('sarah@gmail.com', '2026-01-18 16:30:00', 'Database Systems Textbook', 2, 18000),
    ('daniel@gmail.com', '2026-01-20 13:00:00', 'Bluetooth Speaker', 1, 35000),
    ('daniel@gmail.com', '2026-01-20 13:00:00', 'USB Keyboard', 1, 18000),
    ('faith@gmail.com', '2026-01-22 10:45:00', 'Ladies Handbag', 1, 30000),
    ('michael@gmail.com', '2026-01-25 15:00:00', 'Football', 2, 12000),
    ('esther@gmail.com', '2026-01-28 09:30:00', 'Gym Dumbbells', 1, 40000),
    ('esther@gmail.com', '2026-01-28 09:30:00', 'Programming Guide', 1, 15000)
) AS v(email, order_date, product_name, quantity, unit_price)
JOIN customers c ON c.email = v.email
JOIN orders o
  ON o.customer_id = c.customer_id
 AND o.order_date = v.order_date::timestamp
JOIN products p ON p.product_name = v.product_name
WHERE NOT EXISTS (
    SELECT 1 FROM order_items oi
    WHERE oi.order_id = o.order_id
      AND oi.product_id = p.product_id
);


-- 6. INSERT PAYMENTS
INSERT INTO payments
(order_id, amount, payment_method, status)
SELECT o.order_id,
       SUM(oi.quantity * oi.unit_price),
       'Bank Transfer',
       CASE
           WHEN o.status = 'Cancelled' THEN 'Failed'
           ELSE 'Successful'
       END
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE NOT EXISTS (
    SELECT 1 FROM payments p
    WHERE p.order_id = o.order_id
)
GROUP BY o.order_id, o.status;


-- 7. INSERT DELIVERIES
INSERT INTO deliveries
(order_id, delivery_address, delivery_status)
SELECT o.order_id, c.address,
       CASE
           WHEN o.status = 'Delivered' THEN 'Delivered'
           WHEN o.status = 'Shipped' THEN 'In Transit'
           ELSE 'Pending'
       END
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
  AND NOT EXISTS (
      SELECT 1 FROM deliveries d
      WHERE d.order_id = o.order_id
  )
AND o.status IN ('Delivered', 'Shipped', 'Processing');

COMMIT;
