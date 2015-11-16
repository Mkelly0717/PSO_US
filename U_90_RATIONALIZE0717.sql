--------------------------------------------------------
--  DDL for View U_90_RATIONALIZE0717
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_90_RATIONALIZE0717" ("ITEM", "DEST", "SOURCE", "MET", "UNMET", "PENALTY", "FREIGHT") AS 
  select c.item, c.dest, c.source, nvl(m.met, 0) met, nvl(u.unmet, 0) unmet, p.rate penalty, r.freight 
from sourcing c, 

    (select c.item, c.dest, c.source, c.res, t.value freight
    from sourcingrequirement c, costtier t, rescost r
    where c.res = r.res
    and r.localcost = t.cost) r,

    (select item, loc, rate from skupenalty where category = 101) p,

    (select distinct item, loc, sum(total_exec) met
    from v_03_skumetric
    where descr = 'SKU Met Demand'
    and total_exec > 0
    group by item, loc) m,
    
    (select distinct item, loc, sum(total_exec) unmet
    from v_03_skumetric
    where descr = 'SKU Unmet Demand'
    and total_exec > 0
    group by item, loc) u
    
where c.item = m.item(+)
and c.dest = m.loc(+)
and c.item = u.item(+)
and c.dest = u.loc(+) 
and c.item = p.item(+)
and c.dest = p.loc(+)
and c.item = r.item(+)
and c.dest = r.dest(+)
and c.source = r.source(+)
and c.source = 'AT11' and c.item = '00003RUPCSTD'
