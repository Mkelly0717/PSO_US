--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_5ZIP_COSTTRN
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_5ZIP_COSTTRN" ("ITEM", "LOC", "TOTALDEMAND", "POSTALCODE", "U_EQUIPMENT_TYPE") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
)
select td.item
      ,td.loc
      ,td.totaldemand
      ,l.postalcode
      ,l.u_equipment_type
from total_demand td, loc l, udt_cost_transit ct
where td.loc=l.loc
  and l.postalcode=ct.dest_pc(+)
  and ct.dest_pc is null
