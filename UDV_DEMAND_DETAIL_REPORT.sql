--------------------------------------------------------
--  DDL for View UDV_DEMAND_DETAIL_REPORT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_DETAIL_REPORT" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "DELTA", "SOURCING") AS 
  with TOTAL_DEMAND
as
( select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totaldemand
    from skuconstraint skc
    where skc.category=1
        and skc.qty > 0
    group by SKC.ITEM
      , SKC.LOC
),
TOTAL_MET
as
( select sm.sourcing
      ,sm.item
      ,sm.dest
      ,round(sum(value),0) qty
    from sourcingmetric sm
      , loc l
    where sm.category=418
        and sm.dest=l.loc --and loc='4000108628'
        and l.loc_type=3
    group by sm.sourcing
      ,sm.item
      ,sm.dest
    order by sourcing
      , item
      , DEST
)select TD.ITEM as ITEM
       ,TD.LOC  as DEST
       ,TD.TOTALDEMAND as TOTALDEMAND
       , TM.QTY as TOTALMET
       ,(TD.TOTALDEMAND - TM.QTY) as DELTA
       ,tm.sourcing as Sourcing
from TOTAL_DEMAND TD, TOTAL_MET TM
where TD.LOC=TM.DEST(+)
  and td.item=tm.item(+)
