{{ config(materialized = 'view', schema = 'reporting_dev') }}
 
select distinct
emp.country, cust.companyname, cust.contactname, count(ord.orderid) as total_orders,
sum(ord.quantity) as total_quantity, sum(ord.linesalesamount) as total_sales,
avg(ord.margin) as avg_margin
from {{ref("fct_orders")}} as ord
inner join {{ref("dim_customers")}} as cust
on ord.customerid = cust.customerid
inner join {{ref("dim_employees")}} as emp
on ord.employeeid = emp.empid
where emp.country = '{{var("v_country", "Sweden")}}'
group  by emp.country, cust.companyname, cust.contactname
order by total_sales desc