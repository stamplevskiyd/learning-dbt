-- Create a fct_orders.sql (not stg_orders) model with the following fields.  Place this in the marts/core directory.
-- order_id
-- customer_id
-- amount (hint: this has to come from payments)

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments')}}
),

order_payments as (
    select 
        order_id,
        sum(case when status = 'success' then amount end) as amount
    from payments
    group by 1    
),

final as (
    select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount
    from orders
    left join order_payments using (order_id)    
)

select * from final