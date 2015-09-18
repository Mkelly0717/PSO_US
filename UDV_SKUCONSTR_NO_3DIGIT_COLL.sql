--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_3DIGIT_COLL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_3DIGIT_COLL" ("ITEM", "LOC", "TOTALCOLLECTION", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  with total_collection ( item, loc, totalcollection) as
    (select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totalcollection
    from skuconstraint skc
    where skc.category=10
        and skc.qty > 0
    group by skc.item
      , skc.loc
    )
select tc.item
  ,tc.loc
  ,tc.totalcollection
  ,l.u_3digitzip "3DigitZip"
  ,l.u_equipment_type
from total_collection tc
  , loc l
  , udt_cost_transit ct
where tc.loc=l.loc
    and l.u_3digitzip=ct.source_geo(+)
    and ct.source_geo is null
