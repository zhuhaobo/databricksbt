{{ 
    config
    (    
        tags=["silver", "run_daily"],
        unique_key='ID',
        materialized="incremental"
    ) 
}}

select 
ID as CUSTOMER_ID,
FIRST_NAME,
LAST_NAME,
concat(FIRST_NAME, ' ', LAST_NAME) as FULL_NAME,
ingestion_datetime
from {{ ref('jaffle_shop_customers') }}

{% if is_incremental() %}
WHERE ingestion_datetime > (SELECT MAX(ingestion_datetime) FROM {{ this }})
{% endif %}

