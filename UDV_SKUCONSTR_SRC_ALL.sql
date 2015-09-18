--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_ALL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_ALL" ("ITEM", "LOC", "TOTALDEMAND", "TOTALSRC") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
),
total_src (item, loc, TotalSrc)
as 
( select skc1.item, skc1.loc, nvl(count(1),0)
    from sourcing src, total_demand skc1
   where skc1.item=src.item(+)
     and skc1.loc=src.dest(+)
     and src.item is not null
   group by skc1.item, skc1.loc
  union
  select skc1.item, skc1.loc,0
    from sourcing src, total_demand skc1
   where skc1.item=src.item(+)
     and skc1.loc=src.dest(+)
     and src.item is null
)
select td.item, td.loc, td.TotalDemand, ts.TotalSrc
from total_demand td, total_src ts
where td.item=ts.item
  and td.loc=ts.loc
