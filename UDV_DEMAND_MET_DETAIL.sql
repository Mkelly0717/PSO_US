--------------------------------------------------------
--  DDL for View UDV_DEMAND_MET_DETAIL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_MET_DETAIL" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "%MetOnLane", "SOURCING") AS 
  select "ITEM"
      ,"DEST"
      ,"TOTALDEMAND"
      ,"TOTALMET"
      ,"%MetOnLane"
      ,"SOURCING"
    from udt_demand_detail_report
    where totalmet > 0
    order by dest asc
      , item asc
