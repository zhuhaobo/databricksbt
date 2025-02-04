{{ 
    config
    (    
        tags=["silver", "run_daily"],
        unique_key='ID',
        materialized="view"
    ) 
}}

select 
ID as ORDER_ID,
USER_ID as CUSTOMER_ID,
ORDER_DATE,
STATUS,
ingestion_datetime
from {{ ref('jaffle_shop_orders') }}

