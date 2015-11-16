--------------------------------------------------------
--  DDL for View U_01_METRIC_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_METRIC_SUMMARY" ("TYPEX", "CATEGORY", "DESCR", "VALUE", "CNT") AS 
  SELECT typex,
            category,
            descr,
            ROUND (VALUE, 1) VALUE,
            cnt
       FROM (  SELECT DISTINCT 'SKU' typex,
                               s.category,
                               c.descr,
                               SUM (s.VALUE) VALUE,
                               COUNT (*) cnt
                 FROM skumetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
               SELECT DISTINCT 'SRC' typex,
                               s.category,
                               c.descr,
                               SUM (s.VALUE) VALUE,
                               COUNT (*)
                 FROM sourcingmetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
               SELECT DISTINCT 'PRD' typex,
                               s.category,
                               c.descr,
                               SUM (s.VALUE) VALUE,
                               COUNT (*)
                 FROM productionmetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
               SELECT DISTINCT 'RES' typex,
                               s.category,
                               c.descr,
                               SUM (s.VALUE) VALUE,
                               COUNT (*)
                 FROM resmetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
               SELECT DISTINCT 'RES' typex,
                               category,
                               descr,
                               SUM (penalty_cost) VALUE,
                               COUNT (*)
                 FROM (SELECT s.eff,
                              s.res,
                              s.category,
                              'Resource Under-Utilization Penalty Cost' descr,
                              s.VALUE,
                              r.pen_min,
                              s.VALUE * r.pen_min penalty_cost
                         FROM resmetric s,
                              metriccategory c,
                              (SELECT DISTINCT r.res, r.rate pen_min --distinct r.category, p.descr, count(*)
                                 FROM respenalty r, penaltycategory p
                                WHERE r.category = p.category
                                      AND r.category = 111) r
                        WHERE     s.category = c.category
                              AND s.category = 403
                              AND s.res = r.res
                              AND s.VALUE > 0
                       UNION
                       SELECT s.eff,
                              s.res,
                              s.category,
                              'Resource Over-Utilization Penalty Cost' descr,
                              s.VALUE,
                              r.pen_min,
                              s.VALUE * r.pen_min penalty_cost
                         FROM resmetric s,
                              metriccategory c,
                              (SELECT DISTINCT r.res, r.rate pen_min --distinct r.category, p.descr, count(*)
                                 FROM respenalty r, penaltycategory p
                                WHERE r.category = p.category
                                      AND r.category = 112) r
                        WHERE     s.category = c.category
                              AND s.category = 402
                              AND s.res = r.res
                              AND s.VALUE > 0)
             GROUP BY category, descr
             UNION
               SELECT DISTINCT 'PRDRES' typex,
                               s.category,
                               c.descr,
                               SUM (s.VALUE) VALUE,
                               COUNT (*)
                 FROM productionresmetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
               SELECT DISTINCT 'SRCRES' typex, s.category, c.descr, SUM (s.VALUE) VALUE, COUNT (*)
                 FROM sourcingresmetric s, metriccategory c
                WHERE s.category = c.category
             GROUP BY s.category, c.descr
             UNION
             select distinct 'SKU' typex, c.category, 'A STK GID EOH' descr, sum(k.value) value, count(*)
                from skumetric k, loc l, item i, metriccategory c
                where k.category = 414
                and k.category = c.category
                and k.item = i.item
                and i.u_stock = 'A'
                and k.loc = l.loc
                and l.loc_type = 3 
                and k.value > 0
                and k.eff = (select max(eff) from skuconstraint where category = 10)
                group by c.category, c.descr
             UNION             
             select distinct 'SKU' typex, c.category, 'C STK GID EOH' descr, nvl(sum(k.value), 0) value, count(*)
                from skumetric k, loc l, item i, metriccategory c
                where k.category = 414
                and k.category = c.category
                and k.item = i.item
                and i.u_stock = 'C'
                and k.loc = l.loc
                and l.loc_type = 3 
                --and k.value > 0
                and k.eff = (select max(eff) from skuconstraint where category = 10)
                group by c.category, c.descr
             UNION
             SELECT 'STORAGE' typex,
                    999 category,
                    'Storage Costs' descr,
                    SUM (storcost) VALUE,
                    COUNT (*) cnt
               FROM (SELECT u.eff,
                            u.item,
                            u.loc,
                            u.eoh,
                            NVL (c.VALUE, 0) rate,
                            u.eoh * NVL (c.VALUE, 0) * 7 storcost
                       FROM (  SELECT c.eff,
                                      c.item,
                                      c.loc,
                                      c.category,
                                      m.descr,
                                      c.VALUE eoh
                                 FROM skumetric c, metriccategory m
                                WHERE     c.category = m.category
                                      AND c.category IN ('414')
                                      AND c.VALUE > 0 --and c.item = '00003RUPCSTD' and c.loc = 'PT01'
                                      AND c.eff <=
                                             (SELECT MAX (eff) FROM skuconstraint)
                             ORDER BY c.loc, c.item, c.eff) u,
                            (SELECT t.item,
                                    t.loc,
                                    r.res,
                                    c.VALUE
                               FROM costtier c, rescost r, storagerequirement t
                              WHERE     c.cost = r.localcost
                                    AND r.res = t.res
                                    AND SUBSTR (c.cost, 11, 7) = 'STORAGE') c --and c.cost in ('LOCAL:RES:STORAGE@0100558491-202', 'LOCAL:RES:STORAGE@ES1J-202')) c
                      WHERE u.item = c.item(+) 
                      AND u.loc = c.loc(+)))
   ORDER BY typex, category, descr
