--------------------------------------------------------
--  DDL for View UDV_DEMAND_MET_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_MET_SUMMARY" ("ITEM", "TOTALDEMAND", "TOTALMET", "%UNMET") AS 
  select item
      ,sum(totaldemand)                                                   as totaldemand
      ,sum(totalmet)                                                      as totalmet
      ,round((sum(totaldemand) - sum(totalmet)) 
             /sum(totaldemand)*100,2 
             ) as "%UNMET"
    from udv_demand_met
    group by item
    order by item asc
