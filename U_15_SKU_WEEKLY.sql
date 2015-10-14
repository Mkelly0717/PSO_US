--------------------------------------------------------
--  DDL for Procedure U_15_SKU_WEEKLY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_15_SKU_WEEKLY" as

begin

/******************************************************************
** Part 1: category 1 totdmd; dfutoskufcst has already been 
**         filtered by startdate, u_area, dmdgroup, etc.
******************************************************************/
execute immediate 'truncate table skuconstraint';

commit;
insert into igpmgr.intins_skuconstraint 
 ( integration_jobid, item, loc, eff, dur, category, policy, qtyuom, qty )

(select 'U_15_SKU_WEEKLY_PART1'
       ,item, loc, eff, 1440*7 dur, category, 1 policy, 18 qtyuom, qty
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
            
/******************************************************************
** Part 2: assign unmet demand penalty for forecast  
******************************************************************/
execute immediate 'truncate table skupenalty';

commit;

insert into igpmgr.intins_skupenalty 
( integration_jobid, eff, rate, category, item, loc, currencyuom, qtyuom )

select 'U_15_SKU_WEEKLY_PART2'
  ,v_init_eff_date eff
  , 190 rate
  , 101 category
  , u.item
  , u.loc
  , 15 currencyuom
  , 18 qtyuom
from
    (select distinct item
      , loc
      , category
    from skuconstraint
    WHERE CATEGORY IN ( 1)
        AND ITEM   IN (  '4055RUSTANDRD'
                        ,'4055RUNEW'
                        ,'4055RUNEWPS'
                      )
    ) u
union
select 'U_15_SKU_WEEKLY_PART2'
  ,v_init_eff_date eff
  , 210 rate
  , 101 category
  , v.item
  , v.loc
  , 15 currencyuom
  , 18 qtyuom
from
    ( select distinct item
      , loc
      , category
    from skuconstraint
    WHERE CATEGORY IN ( 1)
        AND ITEM   IN ( '4055RUPLUS'
                       ,'4055RUCUST'
                       ,'4055RUCUSTPS'
                       ,'4055RUPLUS'
                       ,'4055RUPLUSPS'
                       ,'4055RUPREMIUM'
                       ,'4055RUPREMPS'
                      )
    )v;

commit;

/******************************************************************
** Part 2A : assign safety stock constraints  and unmet penalty
******************************************************************/

insert
into igpmgr.intins_skuconstraint
    (
        integration_jobid
      , item
      , loc
      , eff
      , dur
      , category
      , policy
      , qtyuom
      , qty
    )
select 'U_15_SKU_WEEKLY_PART2A'
  ,item
  , loc
  , scpomgr.u_jan1970 eff
  , 1440*7 dur
  , 5 category
  , 1 policy
  , 18 qtyuom
  , qty
from
    (select s.item
      , s.loc
      , i.u_materialcode
      , i.u_qualitybatch
      , i.u_stock
      , t.calculated_stock qty
    from udt_stock_target t
      , sku s
      , loc l
      , item i
    where t.matcode = i.u_materialcode
        and t.batch = i.u_qualitybatch
        and t.stock = i.u_stock-- and t.loc = 'US1M'
        and i.u_qualitybatch <> 'RUNEW'
        and t.loc = l.loc
        and l.u_area = 'NA'
        and l.loc_type in (2, 4, 5)
        and s.item = i.item
        and s.loc = t.loc
    ) u; 
commit;

/******************************************************************
** Part 3 : 
******************************************************************/

insert
into igpmgr.intins_skupenalty
    (
        integration_jobid
      , eff
      , rate
      , category
      , item
      , loc
      , currencyuom
      , qtyuom
    )
select 'U_15_SKU_WEEKLY_PART3'
  , v_init_eff_date eff
  , 40 rate
  , 105 category
  , u.item
  , u.loc
  , 15 currencyuom
  , 18 qtyuom
from
    (select distinct item
      , loc
      , category
    from skuconstraint
    where category in ( 5)
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

  

/******************************************************************
** Part 4: assign maximum capacity constraint  
**         create resource constraints for INS and REP 
**         in weekly periods
******************************************************************/
delete resconstraint;  --notice this deletes VL/VLL constraints as well since they are not needed in weekly and rebalancing models -- where substr(res, 1, 6) in ('INSCAP', 'REPCAP');

commit;

insert into igpmgr.intins_resconstraint 
( integration_jobid, eff, policy, qty, dur, category, res, qtyuom, timeuom )

select 'U_15_SKU_WEEKLY_PART4'
       ,u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom  --need to factor not by 5 days per week
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

/******************************************************************
** Part 5: Create Resource Penalty Records
******************************************************************/
delete respenalty  where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

insert into igpmgr.intins_respenalty 
( integration_jobid, eff, rate, category, res, currencyuom, qtyuom, timeuom )

select 'U_15_SKU_WEEKLY_PART5' 
       ,v_init_eff_date eff, 330 rate, 112 category, res, 15 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;


/******************************************************************
** Part 6: assign minimum capacity constraint  
******************************************************************/
insert into igpmgr.intins_resconstraint 
( integration_jobid, eff, policy, qty, dur, category, res, qtyuom, timeuom )

select 'U_15_SKU_WEEKLY_PART6'
       ,u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom
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

/******************************************************************
** Part 7: Resource Penalty
******************************************************************/
insert into igpmgr.intins_respenalty 
( integration_jobid, eff, rate, category, res, currencyuom, qtyuom, timeuom )

select  'U_15_SKU_WEEKLY_PART7'
        ,v_init_eff_date eff, 330 rate, 111 category, res, 15 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

end;
