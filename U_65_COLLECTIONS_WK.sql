--------------------------------------------------------
--  DDL for View U_65_COLLECTIONS_WK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_COLLECTIONS_WK" ("ITEM", "DEST", "POSSIBLE_COL", "OPT_COL", "ZERO_OOH_DAYS") AS 
  select distinct q.item , q.dest, sum(q.possible_col) possible_col, sum(q.opt_col) opt_col, ooh.zero_ooh_days
from

    (select c.item , c.dest, c.source, k.qty possible_col, nvl(m.total, 0) opt_col
    from sourcing c, u_65_sourcingmetric_wk m, 

        (select distinct k.item, k.loc, sum(qty) qty
        from skuconstraint k, item i, loc l
        where k.category = 10
        and k.item = i.item
        and k.loc = l.loc
        and l.loc_type = 3               
        and i.u_stock = 'A'
        group by k.item, k.loc
        ) k

    where k.item = c.item
    and k.loc = c.source
    and c.item = m.item(+)
    and c.dest = m.dest(+)
    and c.source = m.source(+) 
    ) q,
    
    (select distinct item, loc, sum(cnt) zero_ooh_days
    from

        (select m.item,  m.loc, m.eff, m.value,
            case when m.value = 0 then 1 else 0 end cnt
        from skumetric m, item i, loc l
        where m.category = 414
        and m.item = i.item 
        and i.u_stock = 'A'
        and m.loc = l.loc
        and l.loc_type = 2
        )

    group by item,  loc
    ) ooh
 
where q.item = ooh.item(+)
and q.dest = ooh.loc(+) --and q.dest = 'ES30' --and q.item = '8AI'
group by q.item , q.dest, ooh.zero_ooh_days
