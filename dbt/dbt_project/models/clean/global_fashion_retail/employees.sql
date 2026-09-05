with source as (

    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY employee_id) as rn
    FROM {{ get_source('raw__global_fashion_retail', 'employees') }}

),

renamed as (

    SELECT
        CAST(employee_id AS INT) AS employee_id,
        CAST(store_id AS INT) AS store_id,
        name,
        position
    FROM source
    WHERE rn = 1

)

select * from renamed