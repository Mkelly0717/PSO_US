--------------------------------------------------------
--  DDL for View U_64_NOTINSKUCONSTRAINT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_64_NOTINSKUCONSTRAINT" ("DMDUNIT", "DMDGROUP", "LOC", "CATEGORY", "U_DFU_GRP", "U_DEFPLANT", "LOC_TYPE", "QTY", "REASON") AS 
  select f.dmdunit, f.dmdgroup, f.loc, f.category, f.u_dfu_grp, f.u_defplant, f.loc_type, f.qty,
    case when f.u_dfu_grp = 1 and f.loc_type not in (2, 4) then 'LOC_TYPE'
            when f.u_stock = 'A' and f.dmdgroup in ('ISS', 'CPU') then 'A STK ISS' 
            when f.u_stock = 'C' and f.dmdgroup in ('COL', 'RET') then 'C STK now A STK' else 'UNKNOWN' end reason 
from 

    (select distinct item, loc, category, sum(qty) qty
    from skuconstraint
    group by item, loc, category
    )k,

    (select distinct dmdunit, loc, dmdgroup, category, u_dfu_grp, u_defplant, loc_type, u_stock, round(sum(qty), 1) qty
    from
    
        (select f.dmdunit, f.loc, f.dmdgroup, 
            case when f.dmdgroup in ('ISS', 'CPU') then 1 else 10 end category, v.u_dfu_grp, v.u_defplant, lp.loc_type, i.u_stock, qty 
        from fcst f, dfuview v, loc l, loc lp, item i
        where f.startdate between (select min(startdate) from dfutoskufcst) and (select max(startdate) from dfutoskufcst)
        and f.dmdgroup in ('ISS', 'CPU', 'COL', 'RET')
        and f.dmdunit = v.dmdunit
        and f.dmdgroup = v.dmdgroup
        and f.loc = v.loc  --and f.dmdunit = '8RUSTANDRD' and f.loc = '5000442204'
        and v.u_dfulevel = 0 --and f.dmdunit = '116AI' and f.loc = '5000593587'
        and f.loc = l.loc
        and l.u_area = 'EU'  
        and f.dmdunit = i.item
        and i.u_stock in ('A', 'C')
        and v.u_defplant = lp.loc(+)
        )
        
    group by dmdunit, loc, category, dmdgroup, u_dfu_grp, u_defplant, loc_type, u_stock
    ) f

where f.dmdunit = k.item(+)
and f.loc = k.loc(+) --and f.loc_type not in (2, 4)
and f.category = k.category(+) --and f.loc = '5000686439'
and k.item is null
