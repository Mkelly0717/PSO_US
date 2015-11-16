--------------------------------------------------------
--  DDL for View U_01_SUPPLY_REGIONAL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_SUPPLY_REGIONAL" ("ITEM", "LOC", "COL", "INS", "REP", "CONS", "BUY", "SUBIN", "SUBOUT", "ISS", "EOH", "DIFF", "CHK") AS 
  select y.item, y.loc,   
    round (nvl (ci.col, 0), 0) col, round (nvl (i.ins, 0), 0) ins, round(nvl (r.rep, 0), 0) rep, round(nvl (k.cons, 0), 0) cons, round (nvl (b.buy, 0), 0) buy, round (nvl (si.subin, 0), 0) subin, round (nvl (so.subout, 0), 0) subout,  
    round (nvl (co.iss, 0), 0) iss, round (nvl (eoh.eoh, 0), 0) eoh,
    round((nvl(ci.col, 0)+nvl(i.ins, 0)+nvl(r.rep, 0)+nvl(k.cons, 0)+nvl(b.buy, 0)+nvl(si.subin, 0)+nvl(so.subout, 0)+nvl(co.iss, 0)- nvl(eoh.eoh, 0)),0) diff, 
    case when round((nvl(ci.col, 0)+nvl(i.ins, 0)+nvl(r.rep, 0)+nvl(k.cons, 0)+nvl(b.buy, 0)+nvl(si.subin, 0)+nvl(so.subout, 0)+nvl(co.iss, 0)- nvl(eoh.eoh, 0)),0) <> 0 and substr(y.item, -2) <> 'AR' then 1 else 0 end chk  

from

(select distinct outputitem item, loc from productionyield union select distinct subord, loc from bom) y,

 (SELECT DISTINCT c.item,
                               c.source,
                               c.category,
                               m.descr,
                               -SUM (VALUE) iss
                 FROM sourcingmetric c, metriccategory m, loc ls, loc ld
                WHERE     c.category = m.category
                      AND c.category IN (418)    --and c.item = '00008RUPCSTD'
                      AND c.VALUE > 0
                      and c.source = ls.loc
                      and ls.loc_type = 2
                      and c.dest = ld.loc
                      and ld.loc_type = 3
             GROUP BY c.item,
                      c.source,
                      c.category,
                      m.descr) co,
                      
(SELECT DISTINCT c.item,
                               c.dest,
                               c.category,
                               m.descr,
                               SUM (VALUE) col
                 FROM sourcingmetric c, metriccategory m, loc ls, loc ld
                WHERE     c.category = m.category
                      AND c.category IN (418)    --and c.item = '00008RUPCSTD'
                      AND c.VALUE > 0
                      and c.source = ls.loc
                      and ls.loc_type = 3
                      and c.dest = ld.loc
                      and ld.loc_type = 2
             GROUP BY c.item,
                      c.dest,
                      c.category,
                      m.descr) ci,                      
                      
( SELECT DISTINCT y.outputitem,
                               SUBSTR (y.outputitem, 6, 2) qb2,
                               SUBSTR (y.outputitem, 6, 55) qb,
                               y.yieldqty,
                               s.prodrate,
                               c.loc,
                               c.productionmethod,
                               c.category,
                               m.descr,
                               SUM (VALUE) qty,
                               SUM (VALUE) * y.yieldqty ins
                 FROM productionmetric c,
                      metriccategory m,
                      productionyield y,
                      productionstep s
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.item = y.item
                      AND c.loc = y.loc
                      AND c.productionmethod = y.productionmethod
                      AND c.item = s.item
                      AND c.loc = s.loc
                      AND c.productionmethod = s.productionmethod
                      AND c.productionmethod = 'INS'
                      --AND SUBSTR (y.outputitem, 6, 2) = 'RU'
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY c.loc,
                      c.category,
                      m.descr,
                      y.outputitem,
                      y.yieldqty,
                      s.prodrate,
                      c.productionmethod
               HAVING SUM (VALUE) > 0) i,
               
( SELECT DISTINCT y.outputitem,
                               SUBSTR (y.outputitem, 6, 2) qb2,
                               SUBSTR (y.outputitem, 6, 55) qb,
                               y.yieldqty,
                               s.prodrate,
                               c.loc,
                               c.productionmethod,
                               c.category,
                               m.descr,
                               SUM (VALUE) qty,
                               SUM (VALUE) * y.yieldqty rep
                 FROM productionmetric c,
                      metriccategory m,
                      productionyield y,
                      productionstep s
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.item = y.item
                      AND c.loc = y.loc
                      AND c.productionmethod = y.productionmethod
                      AND c.item = s.item
                      AND c.loc = s.loc
                      AND c.productionmethod = s.productionmethod
                      AND c.productionmethod = 'REP'
                      AND SUBSTR (y.outputitem, 6, 2) = 'RU'
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY c.loc,
                      c.category,
                      m.descr,
                      y.outputitem,
                      y.yieldqty,
                      s.prodrate,
                      c.productionmethod
               HAVING SUM (VALUE) > 0) r,
               
    (SELECT DISTINCT subord, loc, -sum(cons) cons
    from
    (SELECT DISTINCT y.outputitem, b.subord, b.drawqty,
                                   SUBSTR (y.outputitem, 6, 2) qb2,
                                   SUBSTR (y.outputitem, 6, 55) qb,
                                   y.yieldqty,
                                   s.prodrate,
                                   c.loc,
                                   c.productionmethod,
                                   c.category,
                                   m.descr,
                                   SUM (VALUE) qty,
                                   SUM (VALUE) * y.yieldqty*b.drawqty cons
                     FROM productionmetric c,
                          metriccategory m,
                          productionyield y,
                          productionstep s,
                          bom b
                    WHERE     c.category = m.category
                          AND c.category IN (418)
                          and c.item = b.item
                          and c.loc = b.loc
                          and b.bomnum = 1
                          AND c.item = y.item
                          AND c.loc = y.loc
                          AND c.productionmethod = y.productionmethod
                          AND c.item = s.item
                          AND c.loc = s.loc
                          AND c.productionmethod = s.productionmethod
                          AND c.productionmethod in ('REP', 'INS') --and c.loc = 'ES1J' and substr(c.item, 1, 5) = '00003'
                          --AND SUBSTR (y.outputitem, 6, 2) = 'RU'
                          AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
                 GROUP BY c.loc,
                          c.category,
                          m.descr,
                          y.outputitem,
                          y.yieldqty,
                          s.prodrate,
                          c.productionmethod,
                          b.subord, 
                          b.drawqty
                   HAVING SUM (VALUE) > 0)
    group by subord, loc) k,

( SELECT DISTINCT y.outputitem,
                               SUBSTR (y.outputitem, 6, 2) qb2,
                               SUBSTR (y.outputitem, 6, 55) qb,
                               y.yieldqty,
                               s.prodrate,
                               c.loc,
                               c.productionmethod,
                               c.category,
                               m.descr,
                               SUM (VALUE) qty,
                               SUM (VALUE) * y.yieldqty buy
                 FROM productionmetric c,
                      metriccategory m,
                      productionyield y,
                      productionstep s
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.item = y.item
                      AND c.loc = y.loc
                      AND c.productionmethod = y.productionmethod
                      AND c.item = s.item
                      AND c.loc = s.loc
                      AND c.productionmethod = s.productionmethod
                      AND c.productionmethod = 'BUY'
                      AND SUBSTR (y.outputitem, 6, 2) = 'RU' -- and c.loc = 'ES1J'
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY c.loc,
                      c.category,
                      m.descr,
                      y.outputitem,
                      y.yieldqty,
                      s.prodrate,
                      c.productionmethod
               HAVING SUM (VALUE) > 0) b,
               
( SELECT DISTINCT y.outputitem,
                               c.loc,
                               c.category,
                               m.descr,
                               SUM (VALUE) * y.yieldqty subin
                 FROM productionmetric c,
                      metriccategory m,
                      productionyield y,
                      productionstep s,
                      bom b,
                      productionmethod p
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.item = y.item
                      AND c.loc = y.loc
                      AND c.productionmethod = y.productionmethod
                      AND c.item = s.item
                      AND c.loc = s.loc
                      AND SUBSTR (c.productionmethod, 1, 2) = 'SU'
                      AND c.productionmethod = s.productionmethod
                      AND c.item = b.item
                      AND c.loc = b.loc
                      AND c.item = p.item
                      AND c.loc = p.loc
                      AND c.productionmethod = p.productionmethod
                      AND p.bomnum = b.bomnum
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY y.outputitem,
                      c.loc,
                      c.category,
                      m.descr,
                      y.yieldqty
               HAVING SUM (VALUE) > 0)  si,
               
(SELECT DISTINCT b.subord,
                               c.loc,
                               c.category,
                               m.descr,
                               -SUM (VALUE) * y.yieldqty subout
                 FROM productionmetric c,
                      metriccategory m,
                      productionyield y,
                      productionstep s,
                      bom b,
                      productionmethod p
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.item = y.item
                      AND c.loc = y.loc
                      AND c.productionmethod = y.productionmethod
                      AND c.item = s.item
                      AND c.loc = s.loc
                      AND SUBSTR (c.productionmethod, 1, 2) = 'SU'
                      AND c.productionmethod = s.productionmethod
                      AND c.item = b.item
                      AND c.loc = b.loc
                      AND c.item = p.item
                      AND c.loc = p.loc
                      AND c.productionmethod = p.productionmethod
                      AND p.bomnum = b.bomnum
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY b.subord,
                      c.loc,
                      c.category,
                      m.descr,
                      y.yieldqty
               HAVING SUM (VALUE) > 0) so,
               
(  SELECT DISTINCT c.item,
                               c.loc,
                               c.category,
                               m.descr,
                               SUM (c.VALUE) eoh
                 FROM skumetric c, metriccategory m
                WHERE     c.category = m.category
                      AND c.category IN ('414')
                      AND c.eff = (SELECT MAX (eff) FROM skuconstraint)
                      AND c.VALUE > 0
             GROUP BY c.item,
                      c.loc,
                      c.category,
                      m.descr) eoh                     
                      
where y.item = co.item(+)
and y.loc = co.source(+)
and y.item = ci.item(+)
and y.loc = ci.dest(+)
and y.item = i.outputitem(+)
and y.loc = i.loc(+)
and y.item = r.outputitem(+)
and y.loc = r.loc(+)
and y.item = k.subord(+)
and y.loc = k.loc(+)
and y.item = b.outputitem(+)
and y.loc = b.loc(+)
and y.item = si.outputitem(+)
and y.loc = si.loc(+)
and y.item = so.subord(+)
and y.loc = so.loc(+)
and y.item = eoh.item(+)
and y.loc = eoh.loc(+) --and y.loc = 'ES1J' and substr(y.item, 1, 5) = '00003' 
and  abs(nvl(ci.col, 0)+nvl(i.ins, 0))+abs(nvl(r.rep, 0))+abs(nvl(k.cons, 0))+abs(nvl(b.buy, 0))+abs(nvl(si.subin, 0))+abs(nvl(so.subout, 0))+abs(nvl(co.iss, 0))+abs(NVL(eoh.eoh, 0)) > 0
order by y.loc, y.item
