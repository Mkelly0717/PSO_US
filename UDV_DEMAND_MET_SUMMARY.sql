--------------------------------------------------------
--  DDL for View UDV_DEMAND_MET_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_MET_SUMMARY" ("ITEM", "TOTALDEMAND", "TOTALMET", "%MET") AS 
  select ITEM
      ,SUM(TOTALDEMAND) as TOTALDEMAND
      ,SUM(TOTALMET) as TOTALMET
      ,ROUND((SUM(TOTALDEMAND) - SUM(TOTALMET))
              /SUM(TOTALDEMAND)*100,2
            ) as "%MET"
from UDV_DEMAND_MET
group by ITEM
order by item asc;
