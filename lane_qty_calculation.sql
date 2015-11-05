create or replace view "SCPOMGR"."UDV_LANE_QTY_CALCULATION" ("SOURCE", "LOC", "ITEM", "EFF", "RES", "PERCEN", "QTY", "LANE_QTY")
as
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
    where res like 'COLL0FIXED%->%'
        and type=5
        and r.source=fc.loc
        and r.loc=fc.plant
        and fc.percen < 1
        and skc.loc=r.source
    order by r.source
      , r.loc
      , skc.eff