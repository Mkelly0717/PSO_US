--------------------------------------------------------
--  DDL for View UDV_SOURCE_TO_PLANT_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SOURCE_TO_PLANT_SUMMARY" ("SRC_SOURCE", "SRC_ITEM", "SM_NDESTS", "SM_QTY_SHIPPED", "SRC_NDESTS") AS 
  with shipped ( sm_source, sm_item, sm_ndests, sm_qty_shipped) as
    (select source
      , item
      , count( unique dest ) ndests
      , round(sum(value)) qty_shipped
    from sourcingmetric sm
      , loc l
      , loc l1
    where sm.category=418
        and sm.value > 0
        and sm.source=l.loc
        and l.loc_type in (1,2,4,5)
        and sm.dest=l1.loc
        and l1.loc_type in (1,2,4,5)
    group by source
      , item
    order by source asc
      , item asc
    )
  , src (src_source, src_item, src_ndests ) as
    (select src.source
      , src.item
      , count( unique src.dest) src_ndests
    from shipped shipped
      , sourcing src
      , loc l
    where shipped.sm_source(+)=src.source
        and shipped.sm_item(+)=src.item
        and src.dest=l.loc
        and l.loc_type in (1,2,4,5)
    group by src.source
      , src.item
    order by source asc
      , item asc
    )
  , src_list (srcl_source, srcl_item, srcl_dest) as
    (select src.source
      , src.item
      , src.dest
    from shipped shipped
      , sourcing src
      , loc l
    where shipped.sm_source(+)=src.source
        and shipped.sm_item(+)=src.item
        and src.dest=l.loc
        and l.loc_type in (1,2,4,5)
    order by source asc
      , item asc
    )
select src.src_source
  , src.src_item
  , nvl(shp.sm_ndests,0) sm_ndests
  , nvl(shp.sm_qty_shipped,0) sm_qty_shipped
  , src_ndests
from src src
  , shipped shp
where src.src_source=shp.sm_source(+)
    and src_item=sm_item(+)
order by sm_source asc
  , sm_item asc
