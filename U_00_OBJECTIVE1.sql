--------------------------------------------------------
--  DDL for View U_00_OBJECTIVE1
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_OBJECTIVE1" ("ELEMENT", "COST") AS 
  SELECT 'Freight' element, ROUND (NVL (SUM (total_cost), 0), 0) cost
     FROM u_04_srcmetric
   UNION
   SELECT 'Storage' element, ROUND (NVL (SUM (total_cost), 0), 0) cost
     FROM u_09_storage
   UNION
   SELECT 'UnmetDemand' element, ROUND (NVL (SUM (total_exec), 0), 0) cost
     FROM u_03_skumetric
    WHERE category = 421
   UNION
     SELECT 'Production Resource' element,
            ROUND (NVL (SUM (s.VALUE), 0), 0) cost
       FROM productionresmetric s, metriccategory c
      WHERE s.category = c.category AND c.category = 435
   GROUP BY s.category, c.descr
