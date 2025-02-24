{{ config(materialized = 'incremental', unique_key = ['orderid','lineno'] )}}
 
select od.*,o.orderdate from
{{source('raw_qwt','raw_orders')}} as o
inner join {{source('raw_qwt','raw_order_details')}} as od
on o.orderid = od.orderid
 
{% if is_incremental() %}
 
where o.orderdate > (select max(orderdate) from {{this}} )
 
{% endif %}