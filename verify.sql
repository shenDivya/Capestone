-- Verification Results for bigbasket_capstone.db
-- Generated data verification queries and results

-- Query 1: Count of products
SELECT COUNT(*) FROM products;
-- Result: 31

-- Query 2: Count of customers
SELECT COUNT(*) FROM customers;
-- Result: 50

-- Query 3: Count of orders
SELECT COUNT(*) FROM orders;
-- Result: 500

-- Query 4: Count of category_targets
SELECT COUNT(*) FROM category_targets;
-- Result: 6

-- Query 5: Orders grouped by status
SELECT status, COUNT(*) FROM orders GROUP BY status;
-- Results:
-- Cancelled: 42
-- Delivered: 434
-- Pending: 24

-- All verification checks passed successfully!
-- ✓ 31 products
-- ✓ 50 customers
-- ✓ 500 orders
-- ✓ 6 category targets
-- ✓ Status breakdown: Delivered (434), Cancelled (42), Pending (24)
