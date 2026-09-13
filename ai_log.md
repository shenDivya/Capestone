ROLE:->
You are an expert SQLite database consultant specializing in e-commerce analytics.

CONTEXT:->
I have a SQLite database called bigbasket_capstone.db with tables: orders (order_id, customer_id, product_id, order_date, quantity, amount_inr, payment_mode, status, rating), products (product_id, product_name, category, supplier, unit_price_inr), customers (customer_id, name, signup_date, city), and category_targets (category, target_revenue_inr). The orders table has 500 records with status values 'Delivered', 'Cancelled', or 'Pending'. Only 'Delivered' orders should be included in revenue calculations.

TASK:->
Write a SQL query that performs a LEFT JOIN of products to orders, groups by product, and counts total orders per product. The query must use COUNT(o.order_id) instead of COUNT(*) to correctly show 0 for products with no orders. One product (Premium Face Cream 50g, product_id 31) has zero orders and must appear in the results with a count of 0.

CONSTRAINTS:->
 Must use LEFT JOIN (not INNER JOIN) to preserve products with no orders
 Must use COUNT(o.order_id) to correctly count NULL rows as 0
 Must include product_id, product_name, category, and total_orders columns
 Must order results ascending by total_orders to show least-ordered products first

 FORMAT:->
 Provide only the SQL query with column aliases clearly labeled.

 AI Responses Query

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_orders ASC, p.product_name ASC;
