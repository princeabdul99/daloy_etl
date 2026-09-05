
Test dbt connection
 dbt debug --profiles-dir ..

 Generate Base Model
 dbt run-operation generate_base_model --args '{"source_name": "raw__global_fashion_retail_dev",  "table_name": "discounts"}' --profiles-dir .. 