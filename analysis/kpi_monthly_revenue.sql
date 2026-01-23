-- kpi_monthly_revenue.sql
-- Purpose: Calculate monthly revenue and month-over-month (MoM) growth
-- Source table: fact_order_items

WITH monthly AS (
    SELECT
        FORMAT(order_purchase_timestamp, 'yyyy-MM') AS year_month,
        SUM(item_total_value) AS total_revenue
    FROM dbo.fact_order_items
    WHERE order_purchase_timestamp IS NOT NULL
    GROUP BY FORMAT(order_purchase_timestamp, 'yyyy-MM')
)
SELECT
    year_month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year_month) AS prev_month_revenue,
    CASE
        WHEN LAG(total_revenue) OVER (ORDER BY year_month) IS NULL THEN NULL
        WHEN LAG(total_revenue) OVER (ORDER BY year_month) = 0 THEN NULL
        ELSE (total_revenue - LAG(total_revenue) OVER (ORDER BY year_month)) * 1.0
             / LAG(total_revenue) OVER (ORDER BY year_month)
    END AS mom_growth_rate
FROM monthly
ORDER BY year_month;
