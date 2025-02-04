{{ 
    config
    (    
        tags=["silver", "run_daily"],
        unique_key='ID',
        materialized="view"
    ) 
}}

select 
ID as CUSTOMER_ID,
FIRST_NAME,
LAST_NAME,
concat(FIRST_NAME, ' ', LAST_NAME) as FULL_NAME,
ingestion_datetime
from {{ ref('jaffle_shop_customers') }}

