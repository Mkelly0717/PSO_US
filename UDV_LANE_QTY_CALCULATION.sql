--------------------------------------------------------
--  DDL for View UDV_LANE_QTY_CALCULATION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_LANE_QTY_CALCULATION" ("SOURCE", "LOC", "ITEM", "EFF", "RES", "PERCEN", "QTY", "LANE_QTY") AS 
  select r.source
      , r.loc
      , skc.item
      , skc.eff
      , r.res
      , fc.percen
      , skc.qty
      , fc.percen*skc.qty lane_qty
    from res r
      , udt_fixed_coll fc
      , skuconstraint skc
      , item i
    where res like 'COLL0FIXED%->%'
        and type=5
        and r.source=fc.loc
        and r.loc=fc.plant
        and fc.percen < 1
        and skc.loc=r.source
        and skc.category=10
        and i.item=skc.item
        and i.u_stock='A'
        and i.enablesw=1
    order by r.source
      , r.loc
      , skc.eff
