select
    id as payment_id,
    orderid as order_id,
    amount / 100 as amount,
    status

from `dbt-tutorial`.stripe.payment    