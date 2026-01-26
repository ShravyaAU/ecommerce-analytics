# E-Commerce Analytics Engineering Project

## Overview
This project demonstrates an end-to-end analytics workflow for an e-commerce platform, from raw transactional data to analytics-ready datasets and executive dashboards.

The goal of the project is to showcase practical **Data Analyst** and **Analytics Engineer** skills, including data modeling, SQL-based transformations, KPI development, data quality validation, and dashboarding.

---

## Tech Stack
- **SQL Server** – data modeling, transformations, and analytics queries  
- **Python** – initial data cleaning and ETL preparation  
- **Power BI** – executive-level interactive dashboard  
- **GitHub** – version control and project documentation  

---

## Data Pipeline
1. Raw e-commerce CSV data ingested into SQL Server staging tables  
2. Transformation into analytics-ready fact and dimension tables  
3. KPI queries built using advanced SQL (CTEs, window functions)  
4. Power BI dashboard created for business reporting  
5. Data quality checks implemented to validate analytics reliability  

---

## Data Modeling
- **fact_order_items** – item-level fact table (revenue, freight, delivery metrics)  
- **dim_customers** – customer attributes and identifiers  

Fact and dimension tables follow analytics engineering best practices to support scalable reporting and BI usage.

---

## Key Analytics & KPIs
- Monthly Revenue & Order Trends  
- Month-over-Month (MoM) Revenue Growth (window functions)  
- New vs Repeat Customer Analysis using `customer_unique_id`  
- Delivery delay analysis at the order-item level  

All KPI logic is documented and reproducible using SQL scripts in the `analysis/` folder.

---

## Power BI Dashboard
The dashboard provides an **Executive Overview** with:
- Total Revenue and Total Orders  
- Monthly Revenue Trend  
- Interactive filters (year, customer attributes)  

The dashboard enables drill-down analysis and KPI exploration for business stakeholders.

---

## Data Quality Checks
Automated data quality checks were implemented to ensure analytics reliability:
- Verified referential integrity between fact and dimension tables  
- Checked null rates on critical analytical columns  
- Captured results in a reusable data quality summary table with timestamps  

This ensures the datasets are production-ready for reporting and decision-making.

---

## Repository Structure
data/ → raw and processed datasets
models/ → SQL transformations and table definitions
analysis/ → KPI and data quality SQL queries
scripts/ → Python ETL scripts
dashboard/ → Power BI report
docs/ → project documentation and screenshots
