--------------------------------------------------------
--  DDL for Procedure U_15_SKU_WEEKLY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_15_SKU_WEEKLY" as

begin

execute immediate 'truncate table skuconstraint';

commit;

--category 1 totdmd; dfutoskufcst has already been filtered by startdate, u_area, dmdgroup, etc.

insert into skuconstraint (item, loc, eff, dur, category, policy, qtyuom, qty)

(select item, loc, eff, 1440*7 dur, category, 1 policy, 18 qtyuom, qty
    from 
            
    (select item, skuloc loc, category, startdate eff, fcst qty
    from

        (select distinct f.item, f.skuloc, 1 category, f.startdate, round(sum(f.totfcst), 1) fcst
        from dfutoskufcst f, item i
        where f.dmdgroup in ('ISS') 
        and f.item = i.item
        and i.u_stock = 'C'
        group by f.item, f.skuloc, f.startdate

        union

        select distinct f.item, f.skuloc, 10 category, f.startdate, round(sum(f.totfcst), 1) fcst
        from dfutoskufcst f, item i
        where f.dmdgroup in ('COL') 
        and f.item = i.item
        and i.u_stock = 'A'
        group by f.item, f.skuloc, f.startdate
        
        union
        
        select distinct f.item, f.skuloc, 10 category, f.startdate, round(sum(f.totfcst), 1) fcst
        from dfutoskufcst f, item i
        where f.dmdgroup in ('TPM') 
        and f.item = i.item
        and i.u_stock in ('A', 'B', 'C')
        group by f.item, f.skuloc, f.startdate
        )
        
    where fcst > 0
    )

);
            
commit;

--assign unmet demand penalty for forecast  

execute immediate 'truncate table skupenalty';

insert into skupenalty (eff, rate, category, item, loc, currencyuom, qtyuom)

select to_date('01/01/1970', 'MM/DD/YYYY') eff, 190 rate,   101 category, u.item, u.loc, 15 currencyuom, 18 qtyuom
from 

    (select distinct item, loc, category from skuconstraint where category in ( 1) 
    ) u;

commit;

--delete loc_type = 3 SKU which no no SKU constraint record, (not simply a 0 qty record) 

--????

--delete sku where item||loc in 
--
--    (select s.item||s.loc
--    from sku s, loc l, skuconstraint k
--    where s.loc = l.loc
--    and l.loc_type = 3
--    and s.item = k.item(+)
--    and s.loc = k.loc(+)
--    and k.item is null
--    );
--
--commit;

--create resource constraints for INS and REP in weekly periods  

delete resconstraint;  --notice this deletes VL/VLL constraints as well since they are not needed in weekly and rebalancing models -- where substr(res, 1, 6) in ('INSCAP', 'REPCAP');

commit;

-- assign maximum capacity constraint  

insert into resconstraint (eff, policy, qty, dur, category, res, qtyuom, timeuom)

select u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom  --need to factor not by 5 days per week
from resconstraint c,

        (select f.eff, r.res, r.loc, nvl(u.maxcaphrs, 8) qty, 12 category
        from res r, 
        
            (select distinct eff from skuconstraint where category = 1
            ) f,

            (select distinct loc, max(maxhrsperday) maxcaphrs
            from udt_yield
            where productionmethod in ('INS', 'REP')
            group by loc
            ) u

        where r.subtype = 1
        and substr(r.res, 1, 6) in ('INSCAP', 'REPCAP')
        and r.loc = u.loc(+)  
        order by f.eff
        ) u
    
where u.res = c.res(+)
and u.eff = c.eff(+)
and u.category = c.category(+)
and c.res is null
order by u.res, u.eff;

commit;

delete respenalty  where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

insert into respenalty (eff, rate, category, res, currencyuom, qtyuom, timeuom)

select  to_date('01/01/1970', 'MM/DD/YYYY') eff, 330 rate, 112 category, res, 15 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

-- assign minimum capacity constraint  

insert into resconstraint (eff, policy, qty, dur, category, res, qtyuom, timeuom)

select u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom
from resconstraint c,

        (select f.eff, r.res, r.loc, nvl(u.mincaphrs, 9) qty, 11 category
        from res r, 
        
            (select distinct eff from skuconstraint where category = 1
            ) f,

            (select distinct loc, max(minhrsperday) mincaphrs
            from udt_yield
            where productionmethod  in ('INS', 'REP')
            group by loc
            ) u

        where r.subtype = 1
        and substr(r.res, 1, 6)  in ('INSCAP', 'REPCAP')
        and r.loc = u.loc(+)  
        ) u
    
where u.res = c.res(+)
and u.eff = c.eff(+)
and u.category = c.category(+)
and c.res is null
order by u.res, u.eff;

commit;

insert into respenalty (eff, rate, category, res, currencyuom, qtyuom, timeuom)

select  to_date('01/01/1970', 'MM/DD/YYYY') eff, 330 rate, 111 category, res, 15 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

end;

/

