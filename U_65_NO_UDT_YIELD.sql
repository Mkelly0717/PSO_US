--------------------------------------------------------
--  DDL for View U_65_NO_UDT_YIELD
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_NO_UDT_YIELD" ("ITEM", "LOC", "PRODUCTIONMETHOD", "U_DFU_GRP", "U_DEFPLANT", "UDT_YIELD", "TOTAL_EXEC") AS 
  select m.item, m.loc, m.productionmethod, v.u_dfu_grp, v.u_defplant, y.productionmethod udt_yield, m.total_exec
from u_65_productionmetric_wk m,

    (select distinct item, loc, productionmethod from udt_yield) y,

        (select distinct v.dmdunit item, v.u_defplant, max(v.u_dfu_grp) u_dfu_grp  --once dfuview is created for new items need to test this  !!!
        from dfuview v, loc l
        where v.loc = l.loc
        and l.loc_type = 3
        group by v.dmdunit, v.u_defplant
        ) v

where m.productionmethod = 'DEF'
and m.item = v.item(+)
and m.loc = v.u_defplant(+)
and m.item = y.item(+)
and m.loc = y.loc(+)
