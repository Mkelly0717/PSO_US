--------------------------------------------------------
--  DDL for View U_99_REDUCE_SOURCING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_99_REDUCE_SOURCING" ("DMDUNIT", "LOC", "CNT", "CPU", "ISS", "DEL_ISS", "COL", "RET", "DEL_COL") AS 
  select b.dmdunit, b.loc, 
    case when b.dmdunit is null then  0 else 1 end cnt,
    case when c.dmdgroup is null then  0 else 1 end cpu,
    case when i.dmdgroup is null then  0 else 1 end iss,
    case when i.dmdgroup is null and c.dmdgroup is not null then  1 else 0 end del_iss, 
    case when col.dmdgroup is null then  0 else 1 end col,
    case when ret.dmdgroup is null then  0 else 1 end ret,
    case when col.dmdgroup is null and ret.dmdgroup is not null then  1 else 0 end del_col    
from
--delete sourcing where del_iss = 1 or del_col = 1
    (select DISTINCT f.dmdunit, f.loc
    from fcstdraft f, loc l
    where f.loc = l.loc
    and l.loc_type = 3
    and f.dmdgroup in ( 'CPU', 'ISS', 'RET', 'COL')
    and f.qty > 0    
    and substr(f.dmdunit, 11, 2) in ( 'RU', 'AI') 
    group by f.dmdunit, f.loc) b, 

    (select DISTINCT f.dmdunit, f.loc, f.dmdgroup
    from fcstdraft f, loc l
    where f.loc = l.loc
    and l.loc_type = 3
    and f.dmdgroup in ( 'CPU')
    and f.qty > 0    
    and substr(f.dmdunit, 11, 2) = 'RU' 
    group by f.dmdunit, f.loc, f.dmdgroup) c, 

    (select DISTINCT f.dmdunit, f.loc, f.dmdgroup
    from fcstdraft f, loc l
    where f.loc = l.loc
    and l.loc_type = 3
    and f.dmdgroup in ('ISS')
    and f.qty > 0    
    and substr(f.dmdunit, 11, 2) = 'RU' 
    group by f.dmdunit, f.loc, f.dmdgroup) i,
    
    (select DISTINCT f.dmdunit, f.loc, f.dmdgroup
    from fcstdraft f, loc l
    where f.loc = l.loc
    and l.loc_type = 3
    and f.dmdgroup in ( 'COL')
    and f.qty > 0    
    and substr(f.dmdunit, 11, 2) = 'AI' 
    group by f.dmdunit, f.loc, f.dmdgroup) col, 

    (select DISTINCT f.dmdunit, f.loc, f.dmdgroup
    from fcstdraft f, loc l
    where f.loc = l.loc
    and l.loc_type = 3
    and f.dmdgroup in ('RET')
    and f.qty > 0    
    and substr(f.dmdunit, 11, 2) = 'AI' 
    group by f.dmdunit, f.loc, f.dmdgroup) ret
    
where b.dmdunit = c.dmdunit(+)
and b.loc = c.loc(+)
and b.dmdunit = i.dmdunit(+)
and b.loc = i.loc(+)
and b.dmdunit = col.dmdunit(+)
and b.loc = col.loc(+)
and b.dmdunit = ret.dmdunit(+)
and b.loc = ret.loc(+)
--and i.dmdgroup is null and c.dmdgroup is not null
--and col.dmdgroup is null and ret.dmdgroup is not null
