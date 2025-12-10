{{ config(enabled=true) }}

-- Test: Ensure no negative discount amounts exist
-- This test fails if any rows have item_discount_amount < 0
select
    *
from
    {{ ref('fct_orders') }}
where
    item_discount_amount < 0
