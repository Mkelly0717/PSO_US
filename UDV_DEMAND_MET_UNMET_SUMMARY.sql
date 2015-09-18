--------------------------------------------------------
--  DDL for View UDV_DEMAND_MET_UNMET_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_MET_UNMET_SUMMARY" ("CATEGORY", "TOTAL_QTY", "TOTAL_NUMBER", "%Total_Number") AS 
  select category
      ,round(sum(value)) Total_Qty
      ,round(sum(sum(value)) over()) total_number
      ,round(sum(value)/(round(sum(sum(value)) over()))*100,3) "%Total_Number"
from skumetric
where category in (405,406)
group by category
order by category asc
