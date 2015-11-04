--------------------------------------------------------
--  DDL for View UDV_DEMAND_UNMET_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_UNMET_SUMMARY" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET") AS 
  select item
  ,dest
  ,max(totaldemand) TotalDemand
  ,max(totalmet) TotalMet
from udt_demand_detail_report
where totalmet =0
group by item, dest
