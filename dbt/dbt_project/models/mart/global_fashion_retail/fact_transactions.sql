WITH 

dim_customers AS (
    SELECT 
        customer_id
    FROM {{ ref('customers') }}    
),

dim_products AS (
    SELECT
        product_id,
        sizes,
        color
    FROM {{ ref('products') }}  
),

dim_employees AS (
    SELECT
        employee_id,
        store_id
    FROM {{ ref('employees') }}  
),

dim_stores AS (
    SELECT
        store_id
    FROM {{ ref('stores') }}
),

transactions AS (
    SELECT 
        *
    FROM {{ ref('transactions') }}
)

SELECT 
    t.invoice_id,
    dc.customer_id,
    ds.store_id,
    de.employee_id,
    dp.product_id,
    t.sku,
    t.line,
    t.size,
    t.color,
    t.unit_price,
    t.quantity,
    t.date,
    t.discount,
    ROUND(t.unit_price * t.quantity * (1-t.discount), 2) AS line_total,
    t.currency,
    t.currency_symbol,
    t.transaction_type,
    t.payment_method,
    t.invoice_total

FROM transactions t

LEFT JOIN dim_products dp
    ON t.product_id = dp.product_id

LEFT JOIN dim_customers dc
    ON t.customer_id = dc.customer_id

LEFT JOIN dim_employees de
    ON t.employee_id = de.employee_id

LEFT JOIN dim_stores ds
    ON t.store_id = ds.store_id