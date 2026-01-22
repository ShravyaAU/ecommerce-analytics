# Data Model – Olist E-commerce Analytics

## Fact Table
### fact_order_items
Grain: One row per order item (order_id + order_item_id)

Metrics:
- price
- freight_value

Foreign Keys:
- order_id → dim_orders
- product_id → dim_products
- customer_id → dim_customers (via orders)

## Dimension Tables
### dim_customers
Source: olist_customers_dataset  
Key: customer_id  
Attributes: customer_unique_id, city, state

### dim_products
Source: olist_products_dataset  
Key: product_id  
Attributes: category, weight, dimensions

### dim_orders
Source: olist_orders_dataset  
Key: order_id  
Attributes: order_status, purchase_timestamp, delivered_date

### dim_payments
Source: olist_order_payments_dataset  
Key: order_id  
Attributes: payment_type, installments, payment_value
