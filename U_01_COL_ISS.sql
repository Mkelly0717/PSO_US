--------------------------------------------------------
--  DDL for View U_01_COL_ISS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_COL_ISS" ("MATCODE", "SOURCE", "ISS", "COL", "DIFF") AS 
  select i.matcode, i.source, i.iss, c.col, c.col-i.iss diff
from

    (select distinct f.matcode,  c.dest, sum(f.col) col
    from sourcing c,
            (select distinct substr(item, 1, 5) matcode, loc, sum(qty) col from skuconstraint where category = 10 group by substr(item, 1, 5), loc) f
    where f.loc = c.source --and c.dest = 'ES1J'-- and f.matcode = '00003'
    and f.matcode = substr(c.item, 1, 5)
    group by f.matcode,  c.dest) c,

    (select distinct f.matcode, c.source, sum(f.iss) iss
    from sourcing c,
            (select distinct substr(item, 1, 5) matcode, loc, sum(qty) iss from skuconstraint where category = 1 group by substr(item, 1, 5), loc) f
    where f.loc = c.dest --and c.source = 'ES1J' --and f.matcode = '00003'
    and f.matcode = substr(c.item, 1, 5)
    group by f.matcode, c.source) i
    
where c.matcode = i.matcode
and i.source = c.dest
