with t as (  
select f.dmdunit, f.loc
  , round(sum(f.qty)) as total
from fcstdraft f
  , dfuview dv
  , loc l
where   l.country='US'
    and l.u_area='NA'
    and l.enablesw=1
    and  dv.loc=l.loc
    and  dv.loc=f.loc
    and dv.dmdunit=f.dmdunit
    and dv.dmdgroup=f.dmdgroup
    and dv.u_dfulevel=1
    and f.dmdgroup = 'TPM'
group by f.dmdunit, f.loc
),
c as
(select fc.plant, sum(f.total) coll_total
from (
select f.loc, fc.plant, fc.percen
  , round(sum(f.qty)*fc.percen) as total
from fcstdraft f
  , dfuview dv
  , loc l
  , udt_fixed_coll fc
where l.country='US'
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
) f,
( select fc1.loc
  , fc1.plant, percen
from udt_fixed_coll fc1
  , loc l
where l.loc=fc1.plant
    and l.loc_type=4
    order by loc asc) fc
where f.loc=fc.loc
  and f.plant=fc.plant
group by fc.plant
order by fc.plant asc
)select loc, total tpm_qty, coll_total, (total - nvl(coll_total,0)) as Delta
from t t, c c
where t.loc=c.plant(+)
