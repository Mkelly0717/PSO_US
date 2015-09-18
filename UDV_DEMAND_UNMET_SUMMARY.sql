--------------------------------------------------------
--  DDL for View UDV_DEMAND_UNMET_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_UNMET_SUMMARY" ("ITEM", "TOTALDEMAND") AS 
  select item
      , SUM(TOTALDEMAND) as TOTALDEMAND
    from udv_demand_unmet
    group by ITEM
    order by item asc
