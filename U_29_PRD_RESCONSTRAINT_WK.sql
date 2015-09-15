--------------------------------------------------------
--  DDL for Procedure U_29_PRD_RESCONSTRAINT_WK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_29_PRD_RESCONSTRAINT_WK" as


begin

/******************************************************************
** Part 1: Create resource constraints for INS and REP in weekly  * 
**         periods skuconstraint must be populated first          * 
**         and assign maximum capacity constraint                 *
******************************************************************/
delete resconstraint where substr(res, 1, 6) in ('INSCAP', 'REPCAP');  

commit;

insert into igpmgr.intins_resconstraint 
( integration_jobid, eff, policy, qty, dur, category, res, qtyuom, timeuom )

select 'U_29_PRD_RESCONSTR_PART1', u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom  --need to factor not by 5 days per week
from resconstraint c,

        (select f.eff, r.res, r.loc, nvl(u.maxcaphrs, 8) qty, 12 category
        from res r, 
        
            (select distinct eff from skuconstraint where category = 1
            ) f,

            (select distinct productionmethod, loc, max(maxhrsperday) maxcaphrs
            from udt_yield
            where productionmethod in ('INS', 'REP') 
            group by productionmethod, loc
            ) u

        where r.subtype = 1
        and substr(r.res, 1, 6) in ('INSCAP', 'REPCAP')
        and substr(r.res, 1, 3) = u.productionmethod
        and r.loc = u.loc(+)  
        order by f.eff
        ) u
    
where u.res = c.res(+)
and u.eff = c.eff(+)
and u.category = c.category(+)
and c.res is null
order by u.res, u.eff;

commit;

/******************************************************************
** Part 2: Create Resource Penalaty                               * 
******************************************************************/
delete respenalty  where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

insert into igpmgr.intins_respenalty 
( integration_jobid, eff, rate, category, res, currencyuom, qtyuom, timeuom )

select  'U_29_PRD_RESCONSTR_PART2'
        ,v_init_eff_date eff, 900 rate, 112 category, res, 11 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;


/******************************************************************
** Part 3: Assign minimum capacity constraint                     * 
******************************************************************/
insert into igpmgr.intins_resconstraint 
( integration_jobid, eff, policy, qty, dur, category, res, qtyuom, timeuom )

select 'U_29_PRD_RESCONSTR_PART3'
       ,u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category
       ,u.res, 28 qtyuom, 0 timeuom
from resconstraint c,

        (select f.eff, r.res, r.loc, nvl(u.mincaphrs, 9) qty, 11 category
        from res r, 
        
            (select distinct eff from skuconstraint where category = 1
            ) f,

            (select distinct productionmethod, loc, max(minhrsperday) mincaphrs
            from udt_yield
            where productionmethod in ('INS', 'REP') 
            group by productionmethod, loc
            ) u

        where r.subtype = 1
        and substr(r.res, 1, 6)  in ('INSCAP', 'REPCAP')
        and substr(r.res, 1, 3) = u.productionmethod
        and r.loc = u.loc(+)  
        ) u
    
where u.res = c.res(+)
and u.eff = c.eff(+)
and u.category = c.category(+)
and c.res is null
order by u.res, u.eff;

commit;

/******************************************************************
** Part 4: Create Resource Penalty                                * 
******************************************************************/
insert into igpmgr.intins_respenalty 
( integration_jobid, eff, rate, category, res, currencyuom, qtyuom, timeuom )

select  'U_29_PRD_RESCONSTR_PART4'
        ,v_init_eff_date eff, 900 rate, 111 category, res, 11 currencyuom
        ,28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

end;
