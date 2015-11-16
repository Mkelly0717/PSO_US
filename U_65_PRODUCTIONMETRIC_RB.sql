--------------------------------------------------------
--  DDL for View U_65_PRODUCTIONMETRIC_RB
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_PRODUCTIONMETRIC_RB" ("ITEM", "OUTPUTITEM", "YIELDQTY", "PRODRATE", "LOC", "OH", "PRODUCTIONMETHOD", "CATEGORY", "DESCR", "PROXY", "SUB_QTY", "TOTAL_EXEC", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26") AS 
  SELECT item, outputitem, yieldqty, prodrate, loc, oh, productionmethod, category, descr, proxy, sub_qty,
          ROUND (total_exec, 0) total_exec, 
          round(p1, 1) p1,     round(p2, 1) p2,     round(p3, 1) p3,     round(p4, 1) p4,     round(p5, 1) p5,     round(p6, 1) p6,     round(p7, 1) p7,     round(p8, 1) p8,     round(p9, 1) p9,     
          round(p10, 1) p10,     round(p11, 1) p11,     round(p12, 1) p12,     round(p13, 1) p13,     round(p14, 1) p14,     round(p15, 1) p15,     round(p16, 1) p16,     round(p17, 1) p17,     
          round(p18, 1) p18,     round(p19, 1) p19,     round(p20, 1) p20,     round(p21, 1) p21,     round(p22, 1) p22,     round(p23, 1) p23,     round(p24, 1) p24,     round(p25, 1) p25,     round(p26, 1) p26
     FROM 
     
     (  SELECT u.item, u.outputitem, u.yieldqty, u.prodrate, u.loc, u.oh, u.productionmethod, u.category, u.descr, t.sc_qty, b.proxy, b.sub_qty,
                    (  p1+    p2+    p3+    p4+    p5+    p6+    p7+    p8+    p9+    p10+    p11+    p12+    p13+    p14+    p15+    p16+    p17+    p18+    p19+    p20+    p21+    p22+    p23+    p24+    p25+    p26) total_exec, 
                    p1,     p2,     p3,     p4,     p5,     p6,     p7,     p8,     p9,     p10,     p11,     p12,     p13,     p14,     p15,     p16,     p17,     p18,     p19,     p20,     p21,     p22,     p23,     p24,     p25,     p26
               FROM 
               
               (  SELECT DISTINCT c.item, y.outputitem, c.loc, s.oh, c.productionmethod, y.yieldqty, q.prodrate, c.category, m.descr,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 0 THEN VALUE*y.yieldqty END), 0) p1,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 7 THEN VALUE*y.yieldqty END), 0) p2,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 14 THEN VALUE*y.yieldqty END), 0) p3,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 21 THEN VALUE*y.yieldqty END), 0) p4,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 28 THEN VALUE*y.yieldqty END), 0) p5,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 35 THEN VALUE*y.yieldqty END), 0) p6,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 42 THEN VALUE*y.yieldqty END), 0) p7,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 49 THEN VALUE*y.yieldqty END), 0) p8,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 56 THEN VALUE*y.yieldqty END), 0) p9,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 63 THEN VALUE*y.yieldqty END), 0) p10,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 70 THEN VALUE*y.yieldqty END), 0) p11,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 77 THEN VALUE*y.yieldqty END), 0) p12,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 84 THEN VALUE*y.yieldqty END), 0) p13,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 91 THEN VALUE*y.yieldqty END), 0) p14,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 98 THEN VALUE*y.yieldqty END), 0) p15,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 105 THEN VALUE*y.yieldqty END), 0) p16,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 112 THEN VALUE*y.yieldqty END), 0) p17,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 119 THEN VALUE*y.yieldqty END), 0) p18,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 126 THEN VALUE*y.yieldqty END), 0) p19,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 133 THEN VALUE*y.yieldqty END), 0) p20,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 140 THEN VALUE*y.yieldqty END), 0) p21,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 147 THEN VALUE*y.yieldqty END), 0) p22,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 154 THEN VALUE*y.yieldqty END), 0) p23,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 161 THEN VALUE*y.yieldqty END), 0) p24,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 168 THEN VALUE*y.yieldqty END), 0) p25,
                        NVL (SUM (CASE WHEN c.eff = s.ohpost + 175 THEN VALUE*y.yieldqty END), 0) p26
                         FROM udt_productionmetric_rb c, metriccategory m, productionstep q, productionyield y, sku s
                        WHERE     c.category = m.category
                              AND c.category IN (418)
                              AND c.item = y.item
                              AND c.loc = y.loc
                              AND c.productionmethod = y.productionmethod
                              AND c.item = s.item 
                              AND c.loc = s.loc
                              and c.item = q.item
                              and c.loc = q.loc
                              and c.productionmethod = q.productionmethod
                              and q.stepnum = 1
                     GROUP BY c.item, c.loc, s.oh, c.productionmethod, y.outputitem, c.category, m.descr, y.yieldqty, q.prodrate
                     ) u,
                     
                    (  SELECT DISTINCT c.item,y.outputitem, y.yieldqty, s.prodrate, c.loc, c.productionmethod, c.category, m.descr, SUM (VALUE) * y.yieldqty sc_qty
                         FROM udt_productionmetric_rb c, metriccategory m, productionyield y, productionstep s
                        WHERE     c.category = m.category
                              AND c.category IN (418)
                              AND c.item = y.item
                              AND c.loc = y.loc
                              AND c.productionmethod = y.productionmethod
                              AND c.item = s.item 
                              AND c.loc = s.loc
                              AND c.productionmethod = s.productionmethod
                              AND s.stepnum = 1
                     GROUP BY c.item, c.loc, c.category, m.descr, y.outputitem, y.yieldqty, s.prodrate, c.productionmethod
                              ) t,
                                                  
                    (select distinct m.item, b.subord proxy, m.loc, m.productionmethod, p.bomnum, round(sum(m.value), 0) sub_qty
                    from udt_productionmetric_rb m, productionmethod p, bom b
                    where m.category = 418
                    and substr(m.productionmethod, 1, 2) = 'SU'
                    and m.value > 0
                    and m.item = p.item
                    and m.loc = p.loc
                    and m.productionmethod = p.productionmethod
                    and m.item = b.item
                    and m.loc = b.loc
                    and p.bomnum = b.bomnum
                    group by m.item, b.subord, m.loc, m.productionmethod, p.bomnum
                    ) b
                                                  
              WHERE   u.item = t.item(+)
                    AND u.outputitem = t.outputitem(+)
                    AND u.loc = t.loc(+)
                    AND u.productionmethod = t.productionmethod(+) 
                    and u.item = b.item(+)
                    AND u.outputitem = b.item(+)
                    AND u.loc = b.loc(+)
                    AND u.productionmethod = b.productionmethod(+)
           ORDER BY u.category, u.productionmethod, u.item, u.loc)
