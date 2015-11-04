--------------------------------------------------------
--  DDL for View UDV_DEMAND_UNMET_DETAIL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_UNMET_DETAIL" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "DELTA", "SOURCING") AS 
  select "ITEM"
      ,"DEST"
      ,"TOTALDEMAND"
      ,"TOTALMET"
      ,"%MetOnLane"
      ,"SOURCING"
    from udt_demand_detail_report
    where totalmet =0
