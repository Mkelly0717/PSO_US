--------------------------------------------------------
--  DDL for View UDV_PLANTS_WITH_NO_COLL_LANES
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_PLANTS_WITH_NO_COLL_LANES" ("LOC") AS 
  select distinct loc
from loc l
where l.loc_type in (2,4,5)
    and l.u_area='NA'
    and l.enablesw=1
    and not exists
    ( select 1 from sourcing src where src.dest=l.loc
    )
    and exists
    ( select 1 from productionmethod pm where pm.loc=l.loc
    )
