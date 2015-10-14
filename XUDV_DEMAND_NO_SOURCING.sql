--------------------------------------------------------
--  DDL for View XUDV_DEMAND_NO_SOURCING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."XUDV_DEMAND_NO_SOURCING" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "DELTA", "SOURCING") AS 
  select "ITEM","DEST","TOTALDEMAND","TOTALMET","DELTA","SOURCING"
from udv_demand_unmet udmd
where not exists
    ( select 1 
        from sourcing src 
       where src.dest=udmd.dest 
         and src.item=udmd.item
    )
