--------------------------------------------------------
--  DDL for View U_10_SEL_SOURCE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_10_SEL_SOURCE" ("ITEM", "SOURCE", "DEST", "FREIGHT", "ISS", "INS", "REP", "BUY", "SUBIN", "EOH", "DIFF", "SEL_SOURCE") AS 
  select c.item, c.source, c.dest, c.freight, c.iss, c.ins, c.rep, c.buy, c.subin, c.eoh, c.diff, 
    case when nvl(x.iss, 0) = 0 then 0 else 1 end sel_source
from

    (select c.item, c.source, c.dest, t.freight, nvl(x.iss, 0) iss, nvl(s.ins, 0) ins, nvl(s.rep, 0) rep, nvl(s.buy, 0) buy, nvl(s.subin, 0) subin, nvl(s.eoh, 0) eoh, nvl(s.diff, 0) diff
    from sourcing c, sourcingrequirement r, u_01_supply_regional s,

        (select r.res, t.value freight
        from costtier t, res r
        where r.subtype = 6
        and r.res = substr(t.cost, 11, 16)) t,

        (select distinct item, dest
        from sourcing
        group by item, dest
        having count(*) > 1) u,
        
        (select distinct item, source, sourcing, dest, round(sum(value), 1) iss
        from sourcingmetric
        where category = 418
        and value > 0
        group by item, source, dest, sourcing) x
        
    where c.item = r.item
    and c.dest = r.dest
    and c.source = r.source
    and c.sourcing = r.sourcing --and c.dest = '0100018074' and c.item = '00003RUPCSTD'
    and r.res = t.res
    and c.item = u.item
    and c.dest = u.dest
    and c.item = s.item(+)
    and c.source = s.loc(+)
    and c.item = x.item(+)
    and c.dest = x.dest(+)
    and c.source = x.source(+)
    and c.sourcing = x.sourcing(+)) c,

    (select distinct item, dest, max(iss) iss
    from
        (select distinct item, source, sourcing, dest, round(sum(value), 1) iss
        from sourcingmetric
        where category = 418
        and value > 0 --and dest = '0100018074' and item = '00003RUPCSTD'
        group by item, source, dest, sourcing) 
        
    group by item, dest) x
    
where c.item = x.item(+)
and c.dest = x.dest(+)
and c.iss = x.iss(+)

order by c.item, c.dest, c.source
