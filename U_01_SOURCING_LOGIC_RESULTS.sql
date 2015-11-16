--------------------------------------------------------
--  DDL for View U_01_SOURCING_LOGIC_RESULTS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_SOURCING_LOGIC_RESULTS" ("ITEM", "DEST", "GID_TYPE", "DESCR", "COUNTRY", "POSTALCODE", "SOURCE", "PLANT_TYPE", "DESCR_SRC", "COUNTRY_SRC", "POSTALCODE_SRC", "DISTANCE", "DEFPLANT", "USE_DEFPLT", "YIELD_EXISTS") AS 
  select u.item, u.dest, u.gid_type, u.descr, u.country, u.postalcode, u.source,  u.plant_type, u.descr_src, u.country_src, u.postalcode_src, u.distance, v.source defplant,
    case when u.source = v.source then 1 else 0 end use_defplt,
    case when y.item is null then 0 else 1 end yield_exists
from

(select c.item, c.dest, ld.type, 
    case when ld.type = 1 then 'AGG GID' else 'DIR GID' end gid_type, ld.descr, ld.country, ld.postalcode, c.source,  
    case when l.loc_type = 1 then 'MFG' 
            when l.loc_type = 2 then 'SC' else 'GID' end plant_type, l.descr descr_src, l.country country_src, l.postalcode postalcode_src, 
    nvl(d.distance, -1) distance 
from sourcing c, tmp_distance d, loc l, loc ld
where c.source = l.loc
and c.dest = ld.loc and c.dest in ( '0100605910', '0010028982')
and l.loc_type in (1, 2)
and c.source = d.from_loc(+)
and c.dest = d.to_loc(+) and ld.type in (0,  1)) u,


(select distinct substr(v.dmdunit, 6, 5)||q.sup_qb item, v.loc dest, v.u_defplant source, v.u_dfu_grp
        from dfuview v, loc l, tmp_qb q
        where l.loc = v.loc
        and l.loc_type = 3 
        and substr(v.dmdunit, 11, 55) = q.dmd_qb --and v.loc = '0010028982'
        --and (l.type = 1 and v.u_dfu_grp = 1)
        and v.dmdgroup in ('ISS', 'CPU')) v,
        
    (select item, loc
    from tmp_yield
    where perceninsp + percenrepair > 0) y

where u.item = v.item(+)
and u.dest = v.dest(+)
and u.item = y.item(+)
and u.source = y.loc(+)
order by u.dest, u.item, u.plant_type, u.source
