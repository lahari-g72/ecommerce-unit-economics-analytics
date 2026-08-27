-- ==============================================================================
-- 02. ADVANCED SQL: INTER-PURCHASE CYCLE & REPURCHASE INTERVALS
-- ==============================================================================

WITH customer_order_sequences AS (
    SELECT 
        customer_id,
        order_id,
        order_date,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS order_sequence_number,
        LAG(order_date, 1) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
    FROM fact_orders
),
inter_purchase_intervals AS (
    SELECT 
        customer_id,
        order_sequence_number,
        order_date,
        previous_order_date,
        DATEDIFF('day', previous_order_date, order_date) AS days_since_previous_order
    FROM customer_order_sequences
)
SELECT 
    order_sequence_number,
    ROUND(AVG(days_since_previous_order), 1) AS avg_days_since_previous_order,
    COUNT(order_sequence_number) AS total_orders_in_sequence
FROM inter_purchase_intervals
WHERE order_sequence_number <= 5
GROUP BY order_sequence_number
ORDER BY order_sequence_number ASC;
