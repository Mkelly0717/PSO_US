--------------------------------------------------------
--  DDL for View U_65_ISSUES_WK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_ISSUES_WK" ("ITEM", "DEST", "MFG", "SC", "BAD_LOC") AS 
  select distinct item, dest, nvl(mfg, 0) mfg, nvl(sc, 0) sc, nvl(bad_loc,  0) bad_loc
from

    (select distinct m.item, m.dest,
        sum (case when m.loc_type = 1 then nvl(m.total, 0) end) mfg,
        sum (case when m.loc_type = 2 then nvl(m.total, 0) end) sc,
        sum (case when m.loc_type = 6 then nvl(m.total, 0) end) bad_loc
    from u_65_sourcingmetric_wk m,

        (select distinct k.item, k.loc
        from skuconstraint k, item i, loc l
        where k.category = 1
        and k.item = i.item
        and i.u_stock = 'C'
        and k.loc = l.loc
        and l.loc_type = 3
        ) k
        
    where m.item = k.item
    and m.dest = k.loc 
    group by m.item, m.dest
    )

order by dest, item
