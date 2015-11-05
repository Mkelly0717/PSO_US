--------------------------------------------------------
--  DDL for View UDV_TPM_CORRECTIONS_ALT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_TPM_CORRECTIONS_ALT" ("ITEM", "LOC", "EFF", "QTY") AS 
  select src.item item
      , src.dest loc
      , skc.eff eff
      , sum(fc.percen * skc.qty) as qty
    from sourcing src
      , udt_fixed_coll fc
      , skuconstraint skc
      , loc plant
    where   src.source=skc.loc
        and src.source=fc.loc
        and src.item =skc.item
        and src.dest=fc.plant
        and src.dest=plant.loc
        and plant.loc_type in ('2','4')
        and plant.u_area='NA'
        and plant.enablesw=1
        and skc.category=10
        and skc.qty > 0
    group by src.item
      , src.dest
      , skc.eff
    order by src.item
      , src.dest asc
      , eff
