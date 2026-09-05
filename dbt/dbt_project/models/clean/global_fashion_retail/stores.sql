with source as (

    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY store_id ) as rn
    FROM {{ get_source('raw__global_fashion_retail', 'stores') }}

),
renamed as (

    SELECT
        CAST(store_id AS INT) AS store_id,
        CASE 
            WHEN country = '中国' THEN 'China'
            WHEN country = 'España' THEN 'Spain'
            ELSE country
        END AS country,

        CASE 
            WHEN city = '上海' THEN 'Shanghai'
            WHEN city = '北京' THEN 'Beijing'
            WHEN city = '广州' THEN 'Guangzhou'
            WHEN city = '深圳' THEN 'Shenzhen'
            WHEN city = '重庆' THEN 'Chongqing'
            ELSE city
        END AS city, 

        CASE 
            WHEN store_name = 'Store 上海' THEN 'Store Shanghai'
            WHEN store_name = 'Store 北京' THEN 'Store Beijing'
            WHEN store_name = 'Store 广州' THEN 'Store Guangzhou'
            WHEN store_name = 'Store 深圳' THEN 'Store Shenzhen'
            WHEN store_name = 'Store 重庆' THEN 'Store Chongqing'
            ELSE store_name
        END AS store_name,
        CAST(number_of_employees AS INT) AS number_of_employees,
        zip_code,
        CAST(latitude AS DOUBLE) AS latitude,
        CAST(longitude AS DOUBLE) AS longitude

    FROM source
    WHERE rn = 1
)

SELECT * FROM renamed