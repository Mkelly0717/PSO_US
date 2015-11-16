--------------------------------------------------------
--  DDL for View U_65_SURPLUS_B
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_SURPLUS_B" ("ITEM", "LOC", "ZERO_OOH_DAYS", "LAST_DAY_OOH", "ARSOURCE", "RUSOURCE", "PRODUCTIONMETHOD", "YIELDQTY", "B_ITEM", "B_DEST", "C_ITEM", "C_DEST", "FCST", "MET", "UNMET") AS 
  select u.item, u.loc, u.zero_ooh_days, u.last_day_ooh, u.arsource, u.rusource, u.productionmethod, u.yieldqty, u.b_item, u.b_dest,
    q.c_item, q.c_dest, q.fcst, q.met, q.unmet
from 

(select u.item, u.loc, u.zero_ooh_days, u.last_day_ooh, a.arsource, a.rusource, c.productionmethod, c.yieldqty, c.item b_item, c.dest b_dest 
    from 

        (select c.item, c.dest, c.source, y.productionmethod, y.yieldqty
        from sourcing c, loc l, item i, productionyield y
        where c.dest = l.loc
        and l.loc_type in (2, 4)
        and c.item = i.item
        and c.item = y.outputitem
        and c.source = y.loc
        and i.u_stock = 'B'
        ) c, 
        
        (select distinct loc, 
            sum(case when substr(res, -8) = 'ARSOURCE' then status end) arsource,
            sum(case when substr(res, -8) = 'RUSOURCE' then status end) rusource
        from udt_active_sites
        where substr(res, -6) = 'SOURCE'
        --and loc = 'USBO'
        group by loc
        ) a,

    (select distinct item, matcode, loc, sum(cnt) zero_ooh_days, round(sum(last_day_ooh), 1) last_day_ooh
        from

            (select m.eff, m.item, i.u_materialcode matcode, m.loc, m.dur, m.value,
                case when dur = 262080 and value = 0 then 26
                        when value = 0 then 1 else 0 end cnt,
                case when eff = (select max(eff) from skuconstraint) then value else 0 end last_day_ooh 
            from skumetric m, item i, loc l
            where m.category = 414
            and m.loc = l.loc
            and l.loc_type in (2, 4)
            and m.item = i.item 
            and i.u_stock = 'B' and m.loc in ('USBO')
            )
        
        group by item, loc, matcode
        having sum(last_day_ooh) > 0
        ) u

    where u.loc = c.source(+)
    and u.loc = a.loc(+)
    
 ) u,

(select c.item c_item, b.subord, c.source, s.loc c_dest, s.fcst, s.met, s.unmet
    from sourcing c,  bom b,

        (select u.item, u.loc, u.unmet+nvl(m.met, 0) fcst, nvl(m.met, 0) met, u.unmet
        from

            (select distinct item, loc, sum(total) unmet 
            from u_65_skumetric_wk
            where category = 406
            and total > 0
            group by item, loc
            ) u,

            (select distinct item, loc, sum(total) met 
            from u_65_skumetric_wk
            where category = 405
            group by item, loc
            ) m

        where u.item = m.item(+)
        and u.loc = m.loc(+)                          
        ) s
                        
    where s.item = c.item
    and s.loc = c.dest --and c.source = 'UT50'
   and c.item = b.item
   and c.source = b.loc
   and b.bomnum = 1
   ) q
   
where u.item = q.subord(+)
and u.b_dest = q.source(+) --and q.c_dest = '4000284724'
order by u.loc, q.c_dest, u.b_dest
