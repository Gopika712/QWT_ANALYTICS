{{ config(materialized='table')}}
 
select
MD5(OfficeHashKey||empID) as empofficehashkey,
current_timestamp as LoadDateTime,
'Office' as RecordSrc,
OfficeHashKey,
empID
from
{{ref('stg_employees')}} as e inner join
{{ref('stg_hub_offices')}} as o on e.office = o.officeid