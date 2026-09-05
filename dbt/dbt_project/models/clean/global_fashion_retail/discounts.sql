

with source as (

    select * from {{ get_source('raw__global_fashion_retail', 'discounts') }}

),

renamed as (

    select
        CAST(start AS DATE) AS start,
        CAST(end AS DATE) AS end,
        discont AS discount,
        description,
        category,
        sub_category

    from source

)

select * from renamed