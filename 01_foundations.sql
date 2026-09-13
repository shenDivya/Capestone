-- 01_foundations.sql
-- Foundational SQL queries demonstrating core SQL concepts

-- 1. SELECT/WHERE: Orders in a specific city (Bengaluru)
SELECT o.order_id, c.name, c.city, o.order_date, o.amount_inr
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Bengaluru';

-- 2. DISTINCT: List every distinct category
SELECT DISTINCT category
FROM products;

-- 3. ORDER BY + LIMIT: The 5 highest-value orders by amount_inr
SELECT order_id, customer_id, product_id, order_date, amount_inr, status
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4. Alias (AS): Rename an aggregate/column in output
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- 5. IN: Orders whose payment_mode is in a 2-mode list
SELECT order_id, customer_id, payment_mode, amount_inr, status
FROM orders
WHERE payment_mode IN ('UPI', 'Credit Card');

-- 6. BETWEEN: Orders with amount_inr in a stated range (100 to 300)
SELECT order_id, product_id, amount_inr, order_date, status
FROM orders
WHERE amount_inr BETWEEN 100 AND 300;

-- 7. NOT BETWEEN: Orders with amount_inr outside a stated range (not between 100 and 300)
SELECT order_id, product_id, amount_inr, order_date, status
FROM orders
WHERE amount_inr NOT BETWEEN 100 AND 300;

-- 8. IS NULL: Orders with no rating recorded (Cancelled/Pending orders)
SELECT order_id, customer_id, order_date, amount_inr, status, rating
FROM orders
WHERE rating IS NULL;
