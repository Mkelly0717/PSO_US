--------------------------------------------------------
--  DDL for View U_01_SUPPLY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_SUPPLY" ("ITEM", "LOC", "FCST", "INS", "REP", "BUY", "SUBIN", "SUBOUT", "REC", "SHP", "EOH", "DIFF") AS 
  SELECT f.item,
            f.loc,
            f.fcst,
            ROUND (NVL (i.ins, 0), 0) ins,
            ROUND (NVL (r.rep, 0), 0) rep,
            ROUND (NVL (b.buy, 0), 0) buy,
            ROUND (NVL (s1.subin, 0), 0) subin,
            ROUND (NVL (s2.subout, 0), 0) subout,
            ROUND (NVL (cd.rec, 0), 0) rec,
            ROUND (NVL (co.shp, 0), 0) shp,
            ROUND (NVL (eoh.eoh, 0), 0) eoh,
            ROUND (
               f.fcst
               - (  NVL (i.ins, 0)
                  + NVL (r.rep, 0)
                  + NVL (b.buy, 0)
                  + NVL (s1.subin, 0)
                  + NVL (s2.subout, 0)
                  + NVL (cd.rec, 0)
                  + NVL (co.shp, 0)
                  - NVL (eoh.eoh, 0)),
               0)
               diff
       FROM (  SELECT DISTINCT item, loc, SUM (qty) fcst
                 FROM skuconstraint
                WHERE category = 1
             GROUP BY item, loc) f,
            (  SELECT DISTINCT c.item,
                               c.dest,
                               c.category,
                               m.descr,
                               SUM (VALUE) rec
                 FROM sourcingmetric c, metriccategory m
                WHERE     c.category = m.category
                      AND c.category IN (418)
                      AND c.VALUE > 0
             GROUP BY c.item,
                      c.dest,
                      c.category,
                      m.descr) cd,
            (  SELECT DISTINCT c.item,
                               c.source,
                               c.category,
                               m.descr,
                               -SUM (VALUE) shp
                 FROM sourcingmetric c, metriccategory m
                WHERE     c.category = m.category
                      AND c.category IN (418)    --and c.item = '00008RUPCSTD'
                      AND c.VALUE > 0
             GROUP BY c.item,
                      c.source,
                      c.category,
                      m.descr) co,
            (  SELECT DISTINCT y.outputitem,
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
                      AND SUBSTR (y.outputitem, 6, 2) = 'RU'
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY c.loc,
                      c.category,
                      m.descr,
                      y.outputitem,
                      y.yieldqty,
                      s.prodrate,
                      c.productionmethod
               HAVING SUM (VALUE) > 0) i,
            (  SELECT DISTINCT y.outputitem,
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
            (  SELECT DISTINCT y.outputitem,
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
                      AND SUBSTR (y.outputitem, 6, 2) = 'RU'
                      AND s.stepnum = 1 --and c.loc = 'ES1J' --and productionmethod in ('BUY', 'REP') or
             GROUP BY c.loc,
                      c.category,
                      m.descr,
                      y.outputitem,
                      y.yieldqty,
                      s.prodrate,
                      c.productionmethod
               HAVING SUM (VALUE) > 0) b,
            (  SELECT DISTINCT y.outputitem,
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
               HAVING SUM (VALUE) > 0) s1,
            (  SELECT DISTINCT b.subord,
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
               HAVING SUM (VALUE) > 0) s2,
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
      WHERE     f.item = cd.item(+)
            AND f.loc = cd.dest(+)
            AND f.item = co.item(+)
            AND f.loc = co.source(+)
            AND f.item = i.outputitem(+)
            AND f.loc = i.loc(+)
            AND f.item = r.outputitem(+)
            AND f.loc = r.loc(+)
            AND f.item = b.outputitem(+)
            AND f.loc = b.loc(+)
            AND f.item = s1.outputitem(+)
            AND f.loc = s1.loc(+)
            AND f.item = s2.subord(+)
            AND f.loc = s2.loc(+)
            AND f.item = eoh.item(+)
            AND f.loc = eoh.loc(+) --and f.item = '00008RUPCSTD' and f.loc = 'ES59'
   ORDER BY f.loc, f.item
