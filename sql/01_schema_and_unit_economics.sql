-- ==============================================================================
-- 01. STAR SCHEMA DEFINITION & UNIT ECONOMICS FACT PIPELINE
-- ==============================================================================

-- Analytical Flat Table for Contribution Margin (CM2) Calculation
SELECT 
    fo.order_id,
    fo.order_date,
    STRFTIME(fo.order_date, '%Y-%m') AS order_year_month,
    fo.customer_id,
    dc.signup_date,
    STRFTIME(dc.signup_date, '%Y-%m') AS signup_cohort,
    dc.acquisition_channel,
    dc.city,
    fo.product_id,
    dp.category AS product_category,
    fo.quantity,
    fo.gross_amount,
    fo.discount_amount,
    fo.net_revenue,
    fo.shipping_cost,
    fo.payment_fee,
    dp.supplier_cost * fo.quantity AS total_cogs,
    (fo.net_revenue - (dp.supplier_cost * fo.quantity) - fo.shipping_cost - fo.payment_fee) AS cm2_operating_profit,
    ROUND((fo.discount_amount / NULLIF(fo.gross_amount, 0)) * 100, 1) AS discount_pct
FROM fact_orders fo
INNER JOIN dim_customers dc ON fo.customer_id = dc.customer_id
INNER JOIN dim_products dp ON fo.product_id = dp.product_id;
