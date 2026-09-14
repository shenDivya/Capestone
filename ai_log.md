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
''' SQL
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_orders ASC, p.product_name ASC;




AI-Assisted Prompt #2 (RCTCF)
Prompt Used:
Role: You are a senior Python data engineer who specialises in Pandas data-cleaning pipelines and is precise about the difference between dropping and capping outliers.

Context: I am cleaning a messy e-commerce export called orders_raw.csv in a Jupyter notebook. After removing 8 duplicate order_id rows (508 → 500) and coercing amount_inr to numeric with pd.to_numeric(..., errors='coerce') (which produced 10 NaNs that I exclude from all revenue maths), I now have a DataFrame orders_for_revenue. I need to treat high-side outliers on amount_inr, but only on rows where status == 'Delivered' and amount_inr is non-null. The file contains 5 deliberately injected extreme values (real amounts multiplied by 40), but I expect a genuine IQR fence to also flag some legitimately expensive orders.

Task: Explain, line by line, the correct Pandas code to (1) compute Q1 and Q3 with .quantile(), (2) derive IQR = Q3 - Q1 and the upper fence Q3 + 1.5 * IQR, and (3) cap — not drop — values above that fence using .clip(upper=...). Also explain why the lower fence is negative for this data and can therefore be ignored, and warn me about any SettingWithCopyWarning risk in my approach.

Constraints:

Must cap with .clip(upper=...), never drop rows
Quantiles must be computed on the Delivered + non-null subset only, not the whole DataFrame
Must not fill the 10 NaN amount_inr values with 0 or the mean
Must not alter the rating column (nulls there are legitimate for Cancelled/Pending orders)
Result must be written to a new column so the original amount_inr is preserved for auditing
Plain Pandas only — no scipy, no sklearn
Format: A short numbered explanation, then one runnable code block of under 15 lines, then a one-sentence statement of how many rows I should expect to be capped and why that number exceeds 5.
