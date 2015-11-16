--------------------------------------------------------
--  DDL for View U_64_DMDGROUP_FCST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_64_DMDGROUP_FCST" ("DMDGROUP", "QTY") AS 
  select distinct f.dmdgroup, round(sum(qty), 0) qty
from fcst f, dfuview v, item i, loc l
where f.dmdunit = i.item
and i.u_stock in ('A', 'C')
and f.loc = l.loc
and l.u_area = 'EU'
and f.dmdunit = v.dmdunit
and f.dmdgroup = v.dmdgroup
and f.loc = v.loc
and f.startdate between (select min(startdate) from dfutoskufcst) and (select max(startdate) from dfutoskufcst) 
and v.u_dfulevel = 0
group by f.dmdgroup
order by dmdgroup
