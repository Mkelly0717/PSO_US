--------------------------------------------------------
--  DDL for View U_64_ORPHAN_ISS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_64_ORPHAN_ISS" ("ITEM", "LOC", "QTY") AS 
  select k.item, k.loc, k.qty
from sourcing c, 

    (
    select distinct k.item, k.loc, sum(qty) qty
    from skuconstraint k, item i, loc l
    where k.category = 1
    and k.item = i.item
    and i.u_stock = 'C'
    and k.loc = l.loc
    and l.loc_type = 3
    group by k.item, k.loc
    having sum(qty) > 0
    ) k

where k.item = c.item(+)
and k.loc = c.dest(+)
and c.item is null
