select f.dmdgroup
  , f.dmdunit
  , i.u_stock
  , sum(f.qty)
from fcst f
  , loc l
  , item i
  , dfuview dv
where f.loc=l.loc
    and l.u_area='NA'
    and l.country='US'
    and l.enablesw=1
    and f.dmdgroup <> 'ISS'
    and f.dmdunit=i.item
    and dv.dmdunit=f.dmdunit
    and dv.dmdgroup=f.dmdgroup
    and dv.loc=f.loc
    and dv.u_dfulevel=0
group by f.dmdgroup
  , f.dmdunit
  , i.u_stock
order by f.dmdgroup, f.dmdunit, i.u_stock;
    
/* Get distinct dmdgroup, dmdunit, u_stock for coll and tpm */
select distinct dmdgroup
  , dmdunit
  , i.u_stock
from fcst f
  , loc l
  , item i
where f.loc=l.loc
    and l.u_area='NA'
    and l.country='US'
    and l.enablesw=1
    and f.dmdgroup <> 'ISS'
    and f.dmdunit=i.item;