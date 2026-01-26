-- dq_fact_order_items_summary.sql
-- Purpose: Capture data quality metrics for fact_order_items
-- Checks: Null counts for critical analytical columns

DROP TABLE IF EXISTS dbo.dq_fact_order_items_summary;

SELECT
    'fact_order_items' AS table_name,
    COUNT(*) AS total_rows,

    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS null_order_purchase_ts,
    SUM(CASE WHEN item_total_value IS NULL THEN 1 ELSE 0 END) AS null_item_total_value,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,

    GETDATE() AS dq_check_timestamp
INTO dbo.dq_fact_order_items_summary
FROM dbo.fact_order_items;
