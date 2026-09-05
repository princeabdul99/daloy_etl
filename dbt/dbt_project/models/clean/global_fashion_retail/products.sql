

with source as (

    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY product_id) as rn
    FROM {{ get_source('raw__global_fashion_retail', 'products') }}

),

renamed as (

    SELECT
        CAST(product_id AS INT) AS product_id,
        category,
        sub_category,
        description_en AS description,
        COALESCE(color, 'N/A') AS color,
        COALESCE(sizes, 'N/A') AS sizes, 
        CAST(production_cost AS DOUBLE) AS production_cost

    FROM source
    WHERE rn = 1

)

SELECT * FROM renamed