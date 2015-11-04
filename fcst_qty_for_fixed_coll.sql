select f.loc, fc.plant, fc.percen
  , round(sum(f.qty)*fc.percen) as total
from fcstdraft f
  , dfuview dv
  , loc l
  , udt_fixed_coll fc
where l.country='US' and l.loc='4000097899'
    and l.u_area='NA'
    and l.enablesw=1
    and l.loc_type=3
    and dv.loc=l.loc
    and dv.loc=f.loc
    and dv.dmdunit=f.dmdunit
    and dv.dmdgroup=f.dmdgroup
    and dv.u_dfulevel=0
    and dv.dmdgroup = 'COL'
    and dv.dmdunit='4001AI'
    and dv.loc=fc.loc -- only include locs which are in udt_fixed_coll
group by f.loc, fc.plant, fc.percen
order by f.loc asc