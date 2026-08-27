# E-Commerce Unit Economics & Cohort LTV Analytics

Interactive BI Dashboard: [Tableau Public Live Link](https://public.tableau.com/authoring/E-CommerceUnitEconomicsProfitabilityDashboard/Dashboard1#1)

## Executive Overview
This repository contains an end-to-end analytical data pipeline analyzing 50,000+ e-commerce transactions. The project evaluates customer acquisition channel efficiency, lifecycle purchase velocity, and Contribution Margin 2 (CM2) operating profitability across multiple product lines.

## Tech Stack
* Engine: DuckDB SQL (Window Functions, CTEs, Date Partitioning)
* Statistical Analysis: Python (Pandas, Plotly)
* Business Intelligence: Tableau Public (Cross-Filtered Interactive Dashboard)
* Data Architecture: Dimensional Modeling (Star Schema)

## Core Business Findings
* Acquisition Channel Margin: Paid Search generated the highest absolute CM2 operating profit (INR 6.7M+), demonstrating superior conversion efficiency compared to top-of-funnel social channels.
* Inter-Purchase Interval Expansion: Analysis of transaction lag intervals indicates lifecycle purchase deceleration. Average days between consecutive orders widen as customers mature:
  * Order 1 to Order 2: 14.9 days
  * Order 2 to Order 3: 18.2 days
  * Order 3 to Order 4: 20.9 days
  * Order 4 to Order 5: 23.9 days
* Promotional Sensitivity: Categories with high discount penetration (>18% on Electronics and Beauty) drove substantial Gross Merchandise Value (GMV) but experienced margin compression at the unit contribution level.

## Data Warehouse Architecture
The dimensional model implements a star schema optimized for analytical query performance:

* `fact_orders`: Granular order metrics (order_id, dates, gross_amount, discount_amount, net_revenue, shipping_cost, payment_fee)
* `dim_customers`: Customer dimension (customer_id, signup_date, acquisition_channel, city)
* `dim_products`: Product dimension (product_id, category, supplier_cost, list_price)

## Repository Structure
* `sql/`: Production SQL scripts for dimensional aggregation, cohort retention, and window functions.
* `notebooks/`: Python statistical EDA, DuckDB integration, and in-memory transformations.
* `data/`: Master analytics export used to populate the Tableau BI dashboard.

## Author
Lahari G.
