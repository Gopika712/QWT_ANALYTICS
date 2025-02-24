{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'transforming_dev'))}}
 
select
get(xmlget(SUPPLIERSINFO, 'SupplierID'),'$') as supplierid,
get(xmlget(SUPPLIERSINFO, 'CompanyName'),'$')::varchar as companyname,
get(xmlget(SUPPLIERSINFO, 'ContactName'),'$')::varchar as contactname,
get(xmlget(SUPPLIERSINFO, 'Address'),'$')::varchar as address,
get(xmlget(SUPPLIERSINFO, 'City'),'$')::varchar as city,
get(xmlget(SUPPLIERSINFO, 'PostalCode'),'$')::varchar as postalcode,
get(xmlget(SUPPLIERSINFO, 'Phone'),'$')::varchar as phone,
get(xmlget(SUPPLIERSINFO, 'Fax'),'$')::varchar as fax
from {{ref("stg_suppliers")}}