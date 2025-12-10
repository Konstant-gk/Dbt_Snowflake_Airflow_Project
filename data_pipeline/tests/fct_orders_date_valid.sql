{{ config(enabled=true) }}

-- Test: Ensure order dates are valid (not in future and not before 1990-01-01)
select 
    *
from
    {{ ref('fct_orders') }}
where
    order_date > CURRENT_DATE()
    or order_date < '1990-01-01'::DATE
