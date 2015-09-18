--------------------------------------------------------
--  DDL for View UDV_IGPERROR_STATS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_IGPERROR_STATS" ("RUN_DATE", "BOM", "CAL", "CALDATA", "COST", "COSTTIER", "PRODMETHOD", "PRODUCTIONSTEP", "PRODYIELD", "RES", "RESCONSTRAINT", "RESCOST", "RESPENALTY", "SKU", "SKUDEMANDPARAM", "SKUDEPLOYPARAM", "SKUSSPARAM", "SKUPLANNPARAM", "SKUPENALTY", "SOURCING", "SOURCINGMETRIC", "STORAGEREQ") AS 
  select to_char(run_date,'MM-DD-YY HH:MI:SS') as RUN_DATE
  , bom
  , cal
  , caldata
  , cost
  , costtier
  , prodmethod
  , productionstep
  , prodyield
  , res
  , resconstraint
  , rescost
  , respenalty
  , sku
  , skudemandparam
  , skudeployparam
  , skussparam
  , skuplannparam
  , skupenalty
  , sourcing
  , sourcingmetric
  , storagereq
from udt_igperror_stats
order by run_date desc
