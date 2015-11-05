--------------------------------------------------------
--  DDL for View UDV_TPM_CORRECTIONS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_TPM_CORRECTIONS" ("ITEM", "LOC", "EFF", "QTY") AS 
  select s.item item
  , s.dest loc
  , skc.eff eff
  , sum(fc.percen * skc.qty) as qty
from sourcing s
  , udt_fixed_coll fc
  , skuconstraint skc
  , loc l
where s.sourcing like '%COL%'
    and s.source=fc.loc
--    and fc.plant='USZR'
    and s.dest =fc.plant
    and s.source=skc.loc
    and s.item=skc.item
    and l.loc=s.dest
    and l.loc_type in ('2','4')
    and l.u_area='NA'
    and l.enablesw=1
    and skc.qty > 0
    and skc.category=10
group by s.item
  , s.dest
  , skc.eff
order by s.item
  , s.dest asc
  , eff
