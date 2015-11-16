--------------------------------------------------------
--  DDL for View U_00_DATAEXCEPTIONS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_DATAEXCEPTIONS" ("ELEMENT", "OBJECT") AS 
  SELECT 'Sourcing w/o Sourcing Requirment' element,
          c.item || '--' || c.source || '->' || c.dest || '_' || c.sourcing
             object
     FROM sourcing c, sourcingrequirement r
    WHERE     c.item = r.item(+)
          AND c.dest = r.dest(+)
          AND c.source = r.source(+)
          AND c.sourcing = r.sourcing(+)
          AND r.item IS NULL
   UNION
   SELECT 'Cost w/o CostTier' element, c.cost object
     FROM costtier t,
          (SELECT cost, SUBSTR (cost, 11, 55) lane
             FROM cost
            WHERE cost <> ' ') c
    WHERE c.lane = SUBSTR (t.cost(+), 11, 55) AND t.cost IS NULL
   UNION
   SELECT 'RES w/o RESCOST' element, r.res object
     FROM res r, rescost c
    WHERE     r.res <> ' '
          AND r.subtype = 6
          AND r.res = c.res(+)
          AND c.res IS NULL
   UNION
   SELECT 'Unattached RES' element, r.res object
     FROM res r, sourcingrequirement t
    WHERE r.subtype = 6 AND r.res = t.res(+) AND t.res IS NULL
   UNION
   SELECT 'Unattached Cost' element, c.cost object
     FROM rescost r, cost c
    WHERE     c.cost = r.localcost(+)
          AND c.cost <> ' '
          AND c.cost NOT LIKE '%STORAGE%'
          AND r.localcost IS NULL
   UNION
   SELECT 'ISS FCST w/o Souricng' element, s.item || '@' || s.loc object
     FROM skuconstraint s, sourcing c
    WHERE     category = 1
          AND s.item = c.item(+)
          AND s.loc = c.dest(+)
          AND c.item IS NULL
   UNION
   SELECT 'Storablesw wrong' element, s.item || '@' || s.loc object
     FROM sku s, loc l
    WHERE s.loc = l.loc AND l.loc_type = 2 AND s.storablesw <> 1
   UNION
   SELECT 'Storablesw wrong' element, s.item || '@' || s.loc object
     FROM sku s, loc l
    WHERE s.loc = l.loc AND l.loc_type = 3 AND storablesw <> 0
   UNION
   SELECT 'No Production Method' element, s.item || '@' || s.loc object
     FROM sku s, loc l, productionmethod p
    WHERE     s.loc = l.loc
          AND l.loc_type = 2
          AND SUBSTR (s.item, -2) <> 'AI'
          AND s.item = p.item(+)
          AND s.loc = p.loc(+)
          AND p.item IS NULL
   UNION
   SELECT 'STG not Assigned to SKU' element, s.item || '@' || s.loc object
     FROM sku s, loc l, storagerequirement r
    WHERE     s.loc = l.loc
          AND l.loc_type = 2
          AND SUBSTR (s.item, -2) <> 'AI'
          AND s.item = r.item(+)
          AND s.loc = r.loc(+)
          AND r.res IS NULL
   UNION
   SELECT 'COL SKU w/o Sourcing' element, k.item || '@' || k.loc object
     FROM sourcing c,
          (SELECT DISTINCT item, loc
             FROM skuconstraint
            WHERE category = 10) k
    WHERE     k.item = c.item(+)
          AND k.loc = c.source(+)
          AND SUBSTR (k.item, -2) <> 'AI'
          AND c.source IS NULL
   UNION
   SELECT DISTINCT
          'FCST w/o Buy Process' element, c.item || '@' || c.loc object
     FROM skuconstraint c,
          (SELECT DISTINCT item, loc
             FROM productionmethod
            WHERE productionmethod = 'BUY') p
    WHERE     c.category = 1
          AND c.item = p.item(+)
          AND c.loc = p.loc(+)
          AND p.item IS NULL
