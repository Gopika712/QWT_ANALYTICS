{{ config(materialized = 'view', schema = 'reporting_view') }}
 
{% set v_linenos = get_order_linenos() %}
 
select
orderid,
 
{% for linenumber in v_linenos -%}
 
sum(case when lineno = {{linenumber}} then linesalesamount else 0 end) as lineno{{linenumber}}_sales,
 
{% endfor -%}
 
sum(linesalesamount) as total_sales
 
from {{ref("fct_orders")}}
group by orderid