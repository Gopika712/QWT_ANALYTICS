{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'transforming_dev'))}}
 
select
pdt.productid,
pdt.productname,
cat.categoryid,
supp.companyname as suppliercompany,
supp.contactname as suppliercontact,
supp.city as suppliercity,
pdt.unitcost,
pdt.unitprice,
pdt.unitsinstock,
pdt.unitsonorder,
pdt.unitprice - pdt.unitcost as profit,
IFF(pdt.unitsinstock > pdt.unitsonorder, 'Available', 'Not Available') as productavailablity
 
from {{ref("stg_products")}} pdt
inner join {{ref("trf_suppliers")}} supp
on pdt.supplierid = supp.supplierid
inner join {{ref("lkp_categories")}} cat
on pdt.categoryid = cat.categoryid