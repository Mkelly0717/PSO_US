--------------------------------------------------------
--  DDL for View U_02_FCST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_02_FCST" ("ITEM", "MATCODE", "QB", "LOC", "CATEGORY", "FCST") AS 
  SELECT DISTINCT item,
                     SUBSTR (item, 1, 5) matcode,
                     SUBSTR (item, 6, 55) qb,
                     loc,
                     category,
                     SUM (qty) fcst
       FROM skuconstraint
   --where category = 1
   GROUP BY item,
            loc,
            category,
            SUBSTR (item, 1, 5),
            SUBSTR (item, 6, 55)
   ORDER BY category, item, loc
