-- 02_aggregation_joins.sql
-- Aggregation, JOIN, and HAVING queries

-- (a) INNER JOIN of orders to products, GROUP BY category with aggregations and HAVING filter
-- Computing COUNT, SUM(amount_inr) as total_revenue, and AVG(amount_inr) for Delivered orders only
-- Filtering categories with total_revenue > 10000
SELECT 
    p.category,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_order_value
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000
ORDER BY total_revenue DESC;

-- (b) LEFT JOIN of products to orders, GROUP BY product to count total orders per product
-- Using COUNT(o.order_id) to correctly show 0 for products with no orders
-- Ordered ascending to surface the least-ordered products (including zero-order products)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_orders ASC, p.product_name ASC;
