{{ config(materialized = 'table') }}
 
select
OrderID,
LineNo,
ShipperID,
CustomerID,
ProductID,
EmployeeID,
to_date(SPLIT_PART(ShipmentDate, ' ', 1)) AS ShipmentDate,
Status
from
{{source('raw_qwt', 'raw_shipments')}}