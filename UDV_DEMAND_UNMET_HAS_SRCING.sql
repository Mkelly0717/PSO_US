--------------------------------------------------------
--  DDL for View UDV_DEMAND_UNMET_HAS_SRCING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_UNMET_HAS_SRCING" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "DELTA", "SOURCING") AS 
  select "ITEM","DEST","TOTALDEMAND","TOTALMET","DELTA","SOURCING"
    from udv_demand_unmet udmd
    where not exists
        (select 1
        from udv_demand_no_sourcing no_src
        where no_src.dest=udmd.dest
            and no_src.item=udmd.item
        )
