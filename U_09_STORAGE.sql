--------------------------------------------------------
--  DDL for View U_09_STORAGE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_09_STORAGE" ("RES", "LOC", "CATEGORY", "DESCR", "RATE", "TOTAL_COST", "TOTAL_EXEC", "A0313", "A0314", "A0315", "A0316", "A0317", "A0318", "A0319", "A0320", "A0321", "A0322", "A0323", "A0324", "A0325", "A0326") AS 
  SELECT res,
          loc,
          category,
          descr,
          rate,
          rate
          * (  NVL (a0313, 0)
             + NVL (a0314, 0)
             + NVL (a0315, 0)
             + NVL (a0316, 0)
             + NVL (a0317, 0)
             + NVL (a0318, 0)
             + NVL (a0319, 0)
             + NVL (a0320, 0)
             + NVL (a0321, 0)
             + NVL (a0322, 0)
             + NVL (a0323, 0)
             + NVL (a0324, 0)
             + NVL (a0325, 0)
             + NVL (a0326, 0))
             total_cost,
          (  NVL (a0313, 0)
           + NVL (a0314, 0)
           + NVL (a0315, 0)
           + NVL (a0316, 0)
           + NVL (a0317, 0)
           + NVL (a0318, 0)
           + NVL (a0319, 0)
           + NVL (a0320, 0)
           + NVL (a0321, 0)
           + NVL (a0322, 0)
           + NVL (a0323, 0)
           + NVL (a0324, 0)
           + NVL (a0325, 0)
           + NVL (a0326, 0))
             total_exec,
          NVL (a0313, 0) a0313,
          NVL (a0314, 0) a0314,
          NVL (a0315, 0) a0315,
          NVL (a0316, 0) a0316,
          NVL (a0317, 0) a0317,
          NVL (a0318, 0) a0318,
          NVL (a0319, 0) a0319,
          NVL (a0320, 0) a0320,
          NVL (a0321, 0) a0321,
          NVL (a0322, 0) a0322,
          NVL (a0323, 0) a0323,
          NVL (a0324, 0) a0324,
          NVL (a0325, 0) a0325,
          NVL (a0326, 0) a0326
     FROM (  SELECT DISTINCT
                    res,
                    category,
                    descr,
                    loc,
                    rate,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/13/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0313,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/14/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0314,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/15/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0315,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/16/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0316,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/17/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0317,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/18/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0318,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/19/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0319,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/20/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0320,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/21/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0321,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/22/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0322,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/23/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0323,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/24/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0324,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/25/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0325,
                    SUM (
                       CASE
                          WHEN eff = TO_DATE ('03/26/2014', 'MM/DD/YYYY')
                          THEN
                             VALUE
                       END)
                       a0326
               FROM -- (select u.eff, u.res, u.loc, u.category, u.descr, u.value*x.value value
                                                                        --from
                    (SELECT c.eff,
                            c.res,
                            r.loc,
                            c.category,
                            m.descr,
                            c.VALUE,
                            v.rate
                       FROM resmetric c,
                            metriccategory m,
                            res r,
                            (SELECT SUBSTR (cost, 11, 12) res, cost, VALUE rate
                               FROM costtier
                              WHERE SUBSTR (cost, 1, 17) = 'LOCAL:RES:STORAGE') v
                      WHERE     c.category = m.category
                            AND c.res = r.res
                            AND r.subtype = 5
                            AND c.res = v.res
                            AND c.category = 401) u
           GROUP BY res,
                    category,
                    descr,
                    loc,
                    rate)
