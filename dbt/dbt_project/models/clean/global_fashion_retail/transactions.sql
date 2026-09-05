

with source as (

    SELECT * from {{ macrobrew.source('raw__global_fashion_retail', 'transactions') }}
),

products AS (
    SELECT
        product_id,
        category,
        sub_category
    FROM {{ ref('products') }}  
),

renamed as (

    SELECT
        t.invoice_id,
        CAST(t.line AS INT) AS line,
        CAST(t.customer_id AS INT) AS customer_id,
        CAST(t.product_id AS INT) AS product_id,
        t.size,
        t.color,
        CAST(t.unit_price AS DOUBLE) AS unit_price,
        CAST(t.quantity AS INT) AS quantity,
        t.date,
        CAST(t.discount AS DOUBLE) AS discount,
        CAST(t.line_total AS DOUBLE) AS line_total,
        CAST(t.store_id AS INT) AS store_id,
        CAST(t.employee_id AS INT) AS employee_id,
        t.currency,
        t.currency_symbol,
        CONCAT(
            LEFT(UPPER(COALESCE(p.category, 'XX')), 2),
            LEFT(UPPER(COALESCE(p.sub_category, 'XX')), 2),
            t.product_id
        ) AS sku,
        t.transaction_type,
        t.payment_method,
        CAST(t.invoice_total AS DOUBLE) AS invoice_total

    FROM source t
    LEFT JOIN products p
        ON CAST(t.product_id AS INT) = p.product_id 

)

SELECT * FROM renamed