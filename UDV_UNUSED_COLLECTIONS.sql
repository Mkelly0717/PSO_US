--------------------------------------------------------
--  DDL for View UDV_UNUSED_COLLECTIONS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_UNUSED_COLLECTIONS" ("RES", "EFF", "SOURCE", "DEST", "ITEM", "RC_QTY", "SM_VALUE", "REMAINING_QTY", "CATEGORY") AS 
  select rc.res
      , rc.eff
      , sm.source
      , sm.dest
      , sm.item
      , round(rc.qty,2) RC_QTY
      , round(sm.value,2) SM_VALUE
      , round(rc.qty - sm.value) as remaining_qty
      , sm.category
    from resconstraint rc
      , sourcingmetric sm
    where instr(rc.res, sm.sourcing) > 0
        and sm.category=418
        and rc.category=12
        and instr(rc.res, sm.source) > 0
        and instr(rc.res, sm.dest) > 0
        and rc.eff=sm.eff
        and abs(round(rc.qty - sm.value)) > 0
