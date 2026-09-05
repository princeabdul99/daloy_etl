
with source as (

    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) as rn
    FROM {{ macrobrew.source('raw__global_fashion_retail', 'customers') }}

),

renamed as (

    SELECT
        CAST(customer_id AS INT) AS customer_id,
        name,
        email,
        telephone,
        CASE 
            WHEN city = '上海' THEN 'Shanghai'
            WHEN city = '北京' THEN 'Beijing'
            WHEN city = '广州' THEN 'Guangzhou'
            WHEN city = '深圳' THEN 'Shenzhen'
            WHEN city = '重庆' THEN 'Chongqing'
            ELSE city
        END AS city,
        CASE 
            WHEN country = '中国' THEN 'China'
            WHEN country = 'España' THEN 'Spain'
            ELSE country
        END AS country,
        CASE
            WHEN gender IS NULL THEN 'N/A'
            WHEN gender NOT IN ('M', "F") THEN 'N/A'
            ELSE gender
        END AS gender,
        CAST(date_of_birth AS DATE) AS date_of_birth,
        COALESCE(job_title, 'N/A') AS job_title

    FROM source
    WHERE rn = 1
)

SELECT * FROM renamed