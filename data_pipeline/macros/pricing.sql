{% macro discounted_amount(extended_price, discount_percentage, scale=2) -%}
  ({{ extended_price | safe }} * {{ discount_percentage | safe }})::decimal(16, {{ scale }})
{%- endmacro %}