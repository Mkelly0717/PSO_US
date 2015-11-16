--------------------------------------------------------
--  DDL for View U_65_FCST_WK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_FCST_WK" ("ITEM", "U_STOCK", "U_QUALITYBATCH", "DMDGROUP", "SOURCING", "LOC", "LOC_TYPE", "QTY") AS 
  select distinct f.item, i.u_stock, i.u_qualitybatch, f.dmdgroup, f.sourcing, f.loc, l.loc_type, round(sum(f.qty), 1) qty
from item i, loc l,

    (select distinct startdate, dmdunit item, dmdgroup, 
        case when dmdgroup in ('ISS', 'CPU') then 'ISS' else 'COL' end sourcing, skuloc loc, round(sum(totfcst), 1) qty  
    from dfutoskufcst
    where dmdgroup in ('COL', 'RET', 'ISS', 'CPU')
    --and startdate between to_date('02/08/2015', 'MM/DD/YYYY') and to_date('08/08/2015', 'MM/DD/YYYY') --and loc = '0100189743' and dmdunit = '16RUSTANDRD'
    group by startdate, dmdunit, dmdgroup, skuloc
    ) f

where f.item = i.item
and i.u_stock in ('A', 'C')
and f.loc = l.loc
and l.loc_type = 3  

group by f.item, f.dmdgroup, f.sourcing, f.loc, i.u_stock, i.u_qualitybatch, l.loc_type

order by f.loc, f.item
