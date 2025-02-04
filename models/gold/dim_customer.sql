{{ 
    config
    (    
        tags=["gold", "run_daily"],
        unique_key='ID'
    ) 
}}

with customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from {{ ref('slv_order') }}
    group by customer_id

),

customer_final as (
    select
        cu.customer_id,
        cu.first_name,
        cu.last_name,
        cu.full_name,
        od.first_order_date,
        od.most_recent_order_date,
        coalesce(od.number_of_orders, 0) as number_of_orders
    from {{ ref('slv_customer') }}  cu
    left join customer_orders od on cu.customer_id = od.customer_id
)

select * from customer_final