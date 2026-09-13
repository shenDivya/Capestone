-- 03_reporting.sql
-- CASE WHEN tiering, date-based reports, and derived-fields queries

-- (a) Tier every product by its total Delivered revenue using CASE WHEN
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.amount_inr) AS total_revenue,
    CASE 
        WHEN SUM(o.amount_inr) >= 3000 THEN 'High'
        WHEN SUM(o.amount_inr) >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM products as p
INNER JOIN orders as o ON p.product_id = o.product_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;

-- (b) Monthly-by-category business report with order_count, total_revenue, avg_revenue
-- Delivered orders only, grouped by category and month, ordered by category then month
SELECT 
    p.category,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders as o
INNER JOIN products as p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category, month
ORDER BY p.category, month;

-- (c) Derived-fields query: category revenue vs targets with variance calculations
-- Computing variance, percentage_variance, and status tags
SELECT 
    ct.category,
    ct.target_revenue_inr,
    COALESCE(SUM(o.amount_inr), 0) AS total_revenue,
    ct.target_revenue_inr - COALESCE(SUM(o.amount_inr), 0) AS variance,
    ((COALESCE(SUM(o.amount_inr), 0) - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
    CASE 
        WHEN COALESCE(SUM(o.amount_inr), 0) >= ct.target_revenue_inr THEN 'Above Target'
        WHEN ((ct.target_revenue_inr - COALESCE(SUM(o.amount_inr), 0)) * 100.0) / ct.target_revenue_inr <= 15 THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS status
FROM category_targets as ct
LEFT JOIN products as p ON ct.category = p.category
LEFT JOIN orders as o ON p.product_id = o.product_id AND o.status = 'Delivered'
GROUP BY ct.category, ct.target_revenue_inr
ORDER BY ct.category;
