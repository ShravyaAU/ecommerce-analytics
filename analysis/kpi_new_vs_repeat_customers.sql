-- kpi_new_vs_repeat_customers.sql
-- Purpose: Identify new vs repeat customers by month
-- Note: Uses customer_unique_id (true customer identifier)

WITH customer_first_month AS (
    SELECT
        dc.customer_unique_id,
        MIN(FORMAT(f.order_purchase_timestamp, 'yyyy-MM')) AS first_month
    FROM dbo.fact_order_items f
    JOIN dbo.dim_customers dc
        ON f.customer_id = dc.customer_id
    WHERE f.order_purchase_timestamp IS NOT NULL
    GROUP BY dc.customer_unique_id
),
monthly_customer_orders AS (
    SELECT DISTINCT
        dc.customer_unique_id,
        FORMAT(f.order_purchase_timestamp, 'yyyy-MM') AS year_month
    FROM dbo.fact_order_items f
    JOIN dbo.dim_customers dc
        ON f.customer_id = dc.customer_id
    WHERE f.order_purchase_timestamp IS NOT NULL
)
SELECT
    m.year_month,
    SUM(CASE WHEN m.year_month = f.first_month THEN 1 ELSE 0 END) AS new_customers,
    SUM(CASE WHEN m.year_month <> f.first_month THEN 1 ELSE 0 END) AS repeat_customers,
    COUNT(*) AS total_customers
FROM monthly_customer_orders m
JOIN customer_first_month f
  ON m.customer_unique_id = f.customer_unique_id
GROUP BY m.year_month
ORDER BY m.year_month;
