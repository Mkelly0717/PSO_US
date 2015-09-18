--------------------------------------------------------
--  DDL for View UDV_DEMAND_MET
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_MET" ("ITEM", "DEST", "TOTALDEMAND", "TOTALMET", "DELTA", "SOURCING") AS 
  with total_demand as
    (select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totaldemand
    from skuconstraint skc
    where skc.category=1
        and skc.qty > 0
    group by skc.item
      , skc.loc
    )
  , total_met as
    (select sm.sourcing
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
      , dest
    )
select td.item               as item
  ,td.loc                    as dest
  ,td.totaldemand            as totaldemand
  , TM.QTY                   as TOTALMET
  ,round((td.totaldemand - tm.qty)) as delta
  ,TM.SOURCING               as SOURCING
from total_demand td
  , total_met tm
where td.loc=tm.dest(+)
    and TD.ITEM=TM.ITEM(+)
    and trim(tm.dest) is not null
