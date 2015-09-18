--------------------------------------------------------
--  DDL for View UDV_DEMAND_DETAIL_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_DETAIL_SUMMARY" ("ITEM", "TOTALDEMAND") AS 
  select item, sum(totaldemand) as TotalDemand
from UDV_DEMAND_DETAIL_REPORT
group by ITEM
order by item asc
