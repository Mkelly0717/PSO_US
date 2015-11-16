--------------------------------------------------------
--  DDL for View U_65_FCST_RB
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_FCST_RB" ("ITEM", "U_STOCK", "U_QUALITYBATCH", "DMDGROUP", "SOURCING", "LOC", "LOC_TYPE", "QTY") AS 
  select distinct f.item, i.u_stock, i.u_qualitybatch, f.dmdgroup, f.sourcing, f.loc, l.loc_type, round(sum(f.qty), 1) qty
from item i, loc l,

    (select distinct eff, item, category dmdgroup, category sourcing, loc, round(sum(qty), 1) qty  
    from skuconstraint
    --where dmdgroup in ('COL', 'RET', 'ISS', 'CPU')
    --and startdate between to_date('02/08/2015', 'MM/DD/YYYY') and to_date('08/08/2015', 'MM/DD/YYYY') --and loc = '0100189743' and dmdunit = '16RUSTANDRD'
    group by eff, item, category, loc
    ) f

where f.item = i.item
and i.u_stock in ('A', 'C')
and f.loc = l.loc
--and l.loc_type = 3  

group by f.item, f.dmdgroup, f.sourcing, f.loc, i.u_stock, i.u_qualitybatch, l.loc_type

order by f.loc, f.item
