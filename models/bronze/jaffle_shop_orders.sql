
select *, current_timestamp() as ingestion_datetime
from {{source('source_table','jaffle_shop_orders')}}