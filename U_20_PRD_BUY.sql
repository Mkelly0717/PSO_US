--------------------------------------------------------
--  DDL for Procedure U_20_PRD_BUY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_20_PRD_BUY" as

begin

/*
less than one minute -- (06/23/105)
*/

delete res where res like 'BUY%';

commit;

delete productionmethod where productionmethod = 'BUY' and item||loc in 

    (select item||loc
    from udt_yield y
    where productionmethod = 'BUY' 
    and dnd = 0
    );
    
commit;

delete bom where subord like '%RUNEW';

commit;

insert into res (res, loc, type, cal, cost,   descr,  avgskuchg,   avgfamilychg, avgskuchgcost,   avgfamilychgcost,  levelloadsw,     
    levelseqnum,    criticalitem,  checkmaxcap,  unitpenalty,  adjfactor, source,  enablesw, subtype, qtyuom,  currencyuom,  productionfamilychgoveropt)

select u.res, u.loc, u.type, ' ' cal, 0 cost,     ' ' descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' ' criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,     ' ' source,     1 enablesw,     u.subtype,     28 qtyuom,     11 currencyuom,     0 productionfamilychgoveropt
from res r, 

    (select distinct s.loc, 'BUY'||i.u_qualitybatch||'@'||s.loc res, 4 type, 1 subtype
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) u
    
where u.loc = r.loc(+)
and u.res = r.res(+)
and r.res is null;

commit;

insert into productionmethod (item, loc, productionmethod,     descr,     eff,     priority,     minqty,     incqty,     disc,     leadtime,     maxqty,     offsettype,     loadopt,     maxstartdur,     
    maxfindur,     splitordersw,     bomnum,     enablesw,     minleadtime,     maxleadtime,     yieldqty,     splitfactor,     nonewsupplydate,     finishcal,     leadtimecal,     workscope,     lotsizesenabledsw)

select u.item, u.loc, u.productionmethod, ' ' descr,  scpomgr.u_jan1970 eff,     1 priority,     0 minqty,     0 incqty,    scpomgr.u_jan1970 disc,     0 leadtime,     0 maxqty,     
    1 offsettype,     1 loadopt,     0 maxstartdur,     0 maxfindur,     0 splitordersw,     0 bomnum,     1 enablesw,     0 minleadtime,     1440 * 365 * 100 maxleadtime,     0 yieldqty,     1 splitfactor,     
    scpomgr.u_jan1970 nonewsupplydate,     ' ' finishcal,     ' ' leadtimecal,     ' ' workscope,     0 lotsizesenabledsw
from productionmethod p,

    (select s.item, s.loc, 'BUY' productionmethod
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.enablesw = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) u

where u.item = p.item(+)
and u.loc = p.loc(+) 
and u.productionmethod = p.productionmethod(+)
and p.item is null;

commit;

insert into productionstep (item, loc, productionmethod, stepnum,     nextsteptiming,     fixedresreq,     prodrate,     proddur,     prodoffset,     enablesw,     spread,     maxstartdur,     
  eff,     res,     descr,     loadoffsetdur,     prodcost,     qtyuom,     setup,     inusebeforesw,     prodfamily)

select pm.item, pm.loc, pm.productionmethod, 1 stepnum,     3 nextsteptiming,     0 fixedresreq,     1 prodrate,     0 proddur,     0 prodoffset,     1 enablesw,     0 spread,     0 maxstartdur,     
    scpomgr.u_jan1970 eff,     r.res,     ' ' descr,     0 loadoffsetdur,     0 prodcost,     28 qtyuom,     ' ' setup,     0 inusebeforesw,     ' ' prodfamily 
from productionmethod pm, productionstep ps, res r, loc l, item i
where r.loc = pm.loc
and 'BUY'||i.u_qualitybatch||'@'||pm.loc = r.res
and pm.loc = l.loc
and l.loc_type = 1
and r.enablesw = 1
and pm.enablesw = 1 
and pm.item = i.item
and pm.productionmethod = 'BUY' 
and pm.item = ps.item(+)
and pm.loc = ps.loc(+)
and pm.productionmethod = ps.productionmethod(+)
and ps.item is null;

commit;

-- now need to create production methods, unconstrained, no cost, to consume RUNEW into RUSTD....

insert into bom (item, loc, bomnum,     subord,     drawqty,     eff,     disc,     offset,     mixfactor,     yieldfactor,     shrinkagefactor,     drawtype,     explodesw,     unitconvfactor,     enablesw,     
    ecn,     supersedesw,     ff_trigger_control,     qtyuom,     qtyperassembly)

select u.item, u.loc, u.bomnum,     u.subord,     u.drawqty,     scpomgr.u_jan1970 eff,     scpomgr.u_jan1970 disc,     0 offset,     100 mixfactor,     100 yieldfactor,     
    0 shrinkagefactor,     2 drawtype,     0 explodesw,     0 unitconvfactor,     1 enablesw,     ' ' ecn,     0 supersedesw,   '' ff_trigger_control,     18 qtyuom,     0 qtyperassembly
from bom b, sku s, sku ss,

    (select s.item, i.u_materialcode||'RUNEW' subord, s.loc, 1 bomnum, 1 drawqty
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch <> 'RUNEW'
    and i.u_stock = 'C'
    and l.loc <> ' '
    ) u

where u.item = s.item
and u.loc = s.loc
and u.subord = ss.item
and u.loc = ss.loc
and s.enablesw = 1
and ss.enablesw = 1
and u.item = b.item(+)
and u.loc = b.loc(+)
and u.subord = b.subord(+)
and u.bomnum = b.bomnum(+)
and b.item is null;

commit;

insert into productionmethod (item, loc, productionmethod,     descr,     eff,     priority,     minqty,     incqty,     disc,     leadtime,     maxqty,     offsettype,     loadopt,     maxstartdur,     
    maxfindur,     splitordersw,     bomnum,     enablesw,     minleadtime,     maxleadtime,     yieldqty,     splitfactor,     nonewsupplydate,     finishcal,     leadtimecal,     workscope,     lotsizesenabledsw)

select t.item, t.loc, t.productionmethod, ' ' descr,  scpomgr.u_jan1970 eff,     1 priority,     0 minqty,     0 incqty,     scpomgr.u_jan1970 disc,     0 leadtime,     0 maxqty,     
    1 offsettype,     1 loadopt,     0 maxstartdur,     0 maxfindur,     0 splitordersw,     t.bomnum,     1 enablesw,     0 minleadtime,     1440 * 365 * 100 maxleadtime,     0 yieldqty,     1 splitfactor,     
    scpomgr.u_jan1970 nonewsupplydate,     ' ' finishcal,     ' ' leadtimecal,     ' ' workscope,     0 lotsizesenabledsw
from productionmethod p, 

    (select b.item, b.loc, 'BUY' productionmethod, b.bomnum
    from bom b, loc l, item i, udt_cost_unit u
    where b.loc = l.loc
    and l.loc_type = 1
    and b.subord = i.item
    and b.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) t

where  t.item = p.item(+)
and t.loc = p.loc(+)
and t.bomnum = p.bomnum(+)
and t.productionmethod = p.productionmethod(+)
and p.item is null;

commit;

--is a productionstep record necessary ??
--removed 08/18

insert into productionyield (item, loc, productionmethod, eff, qtyuom, outputitem, yieldqty)

select p.item, p.loc, p.productionmethod, scpomgr.u_jan1970 eff, 18 qtyuom, p.item outputitem, 1 yieldqty 
from productionyield y, productionmethod p
where p.item = y.item(+)
and p.loc = y.loc(+)
and p.productionmethod = y.productionmethod(+)
and y.item is null;

commit;

end;

/

