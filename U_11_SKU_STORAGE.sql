--------------------------------------------------------
--  DDL for Procedure U_11_SKU_STORAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_11_SKU_STORAGE" as

begin

--less than one minute  

insert into res (loc, type,     res,    cal,  cost,     descr,  avgskuchg,   avgfamilychg,  avgskuchgcost,  avgfamilychgcost,     levelloadsw,     
    levelseqnum,  criticalitem, checkmaxcap,  unitpenalty,  adjfactor,  source,  enablesw,  subtype,   qtyuom,   currencyuom,     productionfamilychgoveropt)

select distinct u.loc, 9 type,     u.res,     ' '  cal,     0 cost,     ' '  descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' '  criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,  ' ' source,     1 enablesw,     5 subtype,     18 qtyuom,     15 currencyuom,     0 productionfamilychgoveropt
from res r, 

    (select loc, 'STORAGE@'||loc res from loc where loc_type in (1, 2)
    union
    select distinct skuloc loc, 'STORAGE@'||skuloc res from dfutoskufcst where totfcst > 0 
    union
    select distinct loc, 'STORAGE@'||loc res from skuconstraint --this needs to be changed; skuconstraints not yet created here; maybe place in daily procedure
    ) u

where u.loc = r.loc(+)
and u.res = r.res(+)
and r.res is null;

commit;

insert into storagerequirement (item, loc, res, enablesw)

select s.item, s.loc, r.res, 1 enablesw
from res r, sku s, storagerequirement t
where s.loc = r.loc
and r.subtype = 5
and s.enablesw = 1
and s.item = t.item(+)
and s.loc = t.loc(+)
and t.item is null;
--and substr(s.item, -2) <> 'AI';

commit;

insert into cost (cost,  enablesw,   cumulativesw,  groupedsw,  sharedsw,  qtyuom,  currencyuom,   accumcal,  maxqty,     maxutilization)

select  r.cost,     1 enablesw,     0 cumulativesw,     0 groupedsw,     0 sharedsw,     18 qtyuom,     15 currencyuom,   ' '    accumcal,     0 maxqty,     0 maxutilization
from cost c, 
    (select 'LOCAL:RES:STORAGE@'||loc||'-202' cost from res where subtype = 5
    ) r
where r.cost = c.cost(+)
and c.cost is null;

commit;

insert into costtier (breakqty, category, value, eff, cost)

select distinct 0 breakqty, 303 category,  
    case when length(e.cost) = 26 then 0.001 else 90 end value, to_date('01/01/1970', 'MM/DD/YYYY') eff, e.cost
from costtier t, cost e
where substr(e.cost, 1, 17) = 'LOCAL:RES:STORAGE'
and e.cost = t.cost(+)
and t.cost is null;

commit;

insert into rescost (category, res, localcost, tieredcost)

select 202 category, u.res, u.cost localcost, ' ' tieredcost
from rescost r,

    (select t.cost, substr(t.cost, 11, 12) res
    from costtier t, res r
    where substr(t.cost, 11, 12) = r.res
    ) u

where u.res = r.res(+)
and u.cost = r.localcost(+)
and r.res is null;

commit;

--for loc_type 3 GID SKU

insert into rescost (category, res, localcost, tieredcost)

select 202 category, u.res, u.cost localcost, ' ' tieredcost
from rescost r,

    (select t.cost,  res   
    from costtier t, res r
    where substr(t.cost, 1, 17) = 'LOCAL:RES:STORAGE'
    and length(t.cost) = 32
    and r.res = substr(t.cost, 11, 18)
    ) u

where u.res = r.res(+)
and u.cost = r.localcost(+)
and r.res is null;

commit;

end;

/

