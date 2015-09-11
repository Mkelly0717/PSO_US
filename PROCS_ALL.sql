--------------------------------------------------------
--  File created - Friday-September-11-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure MAK_RANK_SM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."MAK_RANK_SM" as
    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,round(sum(value),0) qty
      ,rank() over ( partition by sourcing, item, dest order by sum(value)desc ) as rank
    from sourcingmetric sm
      , loc l
    where sm.category=418
        and sm.dest=l.loc
        and loc='null'
        and l.loc_type=3
    group by sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
    order by sourcing
      , item
      , dest
      , rank asc;

/

--------------------------------------------------------
--  DDL for Procedure U_10_SKU_BASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_10_SKU_BASE" as
begin
/******************************************************************
** Part 1: create Items                                           * 
******************************************************************/
insert into igpmgr.intins_item 
(integration_jobid, item, descr, uom, defaultuom, u_materialcode
    , u_qualitybatch, u_stock
)
select 'U_10_SKU_BASE_PART1' 
    ,y.item, ' ' descr, ' ' uom, 18 defaultuom, substr(y.item, 1, 5) u_materialcode, substr(y.item, 5, 55) u_qualitybatch, 
    case when substr(y.item, -2) = 'AR' then 'B'
            when substr(y.item, -2) = 'AI' then 'A' else 'C' end u_stock
from item i, 

(select distinct item from udt_yield
 where maxcap > 0
   and yield > 0
union
select '4001AI' item from dual 
) y

where y.item = i.item(+)
and i.item is null;

commit;


/******************************************************************
** Part 2: create SKU for service centers, TPM
******************************************************************/
insert into igpmgr.intins_sku 
(integration_jobid, item, loc, oh, replentype, netchgsw, ohpost
    ,planlevel, sourcinggroup, qtyuom, currencyuom, storablesw
    ,enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw
    ,minohcovrule, targetohcovrule, ltdgroup, infinitesupplysw
    , mpbatchnum, seqintenablesw, itemstoregrade, rpbatchnum
)
select 'U_10_SKU_BASE_PART2'
   ,u.item, u.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
   ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom
   ,1 storablesw, 1 enablesw, 35 timeuom, ''  ff_trigger_control
   ,0 infcarryfwdsw, 1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup
   ,0 infinitesupplysw, 0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade
   , 0 rpbatchnum
from sku s, loc l, item i, 

    (select distinct item, loc
    from udt_yield
    where maxcap > 0
      and yield > 0
    ) u
    
where u.loc = l.loc
and u.item = i.item
and l.loc_type in ( 2, 4)
and i.enablesw = 1
and l.enablesw = 1
and i.u_stock in ('A', 'B', 'C')
and u.item = s.item(+)
and u.loc = s.loc(+)
and s.item is null;

commit;

/******************************************************************
** Part 3: temporary step to create SKU for MFG locationso
** 08282015 - added other skus at mfg so can create production 
**            methods to convert to RUNEW 
******************************************************************/
insert into igpmgr.intins_sku 
(integration_jobid, item, loc, oh, replentype, netchgsw, ohpost
    ,planlevel, sourcinggroup, qtyuom, currencyuom, storablesw
    ,enablesw, timeuom, ff_trigger_control, infcarryfwdsw
    ,minohcovrule, targetohcovrule, ltdgroup, infinitesupplysw
    ,mpbatchnum, seqintenablesw, itemstoregrade, rpbatchnum
)
select 'U_10_SKU_BASE_PART3'
  ,i.item , l.loc , 0 oh , 5 replentype , 1 netchgsw , v_init_eff_date ohpost
  ,-1 planlevel , ' ' sourcinggroup , 18 qtyuom , 15 currencyuom 
  ,1 storablesw , 1 enablesw , 35 timeuom , '' ff_trigger_control 
  ,0 infcarryfwdsw , 1 minohcovrule , 1 targetohcovrule , ' ' ltdgroup 
  ,0 infinitesupplysw , 0 mpbatchnum , 0 seqintenablesw , -1 itemstoregrade 
  ,0 rpbatchnum
from loc l
  , item i
where i.item in ( '4055RUNEW' 
                 ,'4055RUPLUS' 
                 ,'4055RUCUST' 
                 ,'4055RUPREMIUM' 
                )
    and l.loc_type = '1'
    and not exists
    ( select 1 from sku sku where sku.loc=l.loc and sku.item=i.item
    ); -- 0827 Changed from max src check. 
--and l.u_max_src = 1;  --need identfier 

commit;

--SKU for potential parent items from a substitution production method, (SKU not an output of INS or REP PM from above must be created) 

--insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
--    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
--    itemstoregrade,     rpbatchnum)
--
--select u.item, u.loc, 0 oh,     5 replentype,     1 netchgsw,     to_date('01/01/1970', 'MM/DD/YYYY') ohpost,     -1 planlevel,     ' ' sourcinggroup,     18 qtyuom,    15 currencyuom,     1 storablesw,     
--    1 enablesw,     35 timeuom,    ''  ff_trigger_control,     0 infcarryfwdsw,     1 minohcovrule,     1 targetohcovrule,     ' ' ltdgroup,     0 infinitesupplysw,     0 mpbatchnum,     0 seqintenablesw,     
--    -1 itemstoregrade,     0 rpbatchnum
--from
--    (select distinct u.parent item, u.loc
--    from sku s, loc l, 
--
--        (select y.loc, y.item, s.subord, y.matcode||s.parent parent
--        from udt_yield y, udt_substitute s, item i, item ip
--        where y.item = i.item 
--        and i.u_qualitybatch = s.subord
--        and y.matcode||s.parent = ip.item 
--        ) u
--
--    where u.loc = l.loc
--    and l.loc_type = 2
--    and u.parent = s.item(+)
--    and u.loc = s.loc(+)
--    and s.loc is null
--    ) u;
--    
--commit;

--create SKU for u_defplant for aggregate GID locations (u_dfu_grp = 1) if it does not exist  
--u_26_prd_defplant creates placeholder productionmethods 
-- or create EU99 for unmatched sourcing within u_max_dist where u_dfu_grp = 0

--insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
--    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
--    itemstoregrade,     rpbatchnum)
--
--select u.item, u.loc, 0 oh,     5 replentype,     1 netchgsw,     to_date('01/01/1970', 'MM/DD/YYYY') ohpost,     -1 planlevel,     ' ' sourcinggroup,     18 qtyuom,    15 currencyuom,     1 storablesw,     
--    1 enablesw,     35 timeuom,    ''  ff_trigger_control,     0 infcarryfwdsw,     1 minohcovrule,     1 targetohcovrule,     ' ' ltdgroup,     0 infinitesupplysw,     0 mpbatchnum,     0 seqintenablesw,     
--    -1 itemstoregrade,     0 rpbatchnum
--from 
--    (select distinct v.item, v.u_defplant loc
--    from sku s, loc l, item i,
--
--        (select distinct v.dmdunit item, v.loc dest, v.u_defplant, v.u_dfu_grp
--                from dfuview v, loc l, item i
--        where l.loc = v.loc
--        and l.loc_type = 3 
--        and v.u_dfu_grp = 1
--        and v.dmdunit = i.item
--        and v.u_defplant <> ' '
--        and v.dmdgroup in ('ISS', 'CPU', 'COL', 'RET')
--        ) v
--            
--    where v.u_defplant = l.loc
--    --and l.loc_type in (1, 2)  --allowed loc_type 6 for DEF PM - temporary until corrected 
--    and v.item = i.item
--    and i.u_stock in ('A', 'C')
--    and v.item = s.item(+) 
--    and v.u_defplant = s.loc(+)
--    and s.item is null
--    
--    union 
--    
--    select u.item, u.loc
--    from sku s,
--    
--        (select i.item, l.loc
--        from item i, loc l, sku s
--        where u_stock in ('A', 'C')
--        and l.loc = 'EU99'
--        ) u
--        
--    where u.item = s.item(+)
--    and u.loc = s.loc(+)
--    and s.item is null        
--    ) u;
--    
--commit;

/******************************************************************
** Part 4: SKU for AI at service centers; if an RU exists at SC 
**         then an AI should as well RU could be created at service 
**         from udt_yield or dfuview def_plant AR SKU should be 
**         created if percenrepair > 0 
******************************************************************/
insert into igpmgr.intins_sku 
(integration_jobid, item, loc, oh, replentype, netchgsw, ohpost
    ,planlevel, sourcinggroup, qtyuom, currencyuom, storablesw
    ,enablesw, timeuom, ff_trigger_control, infcarryfwdsw, minohcovrule
    ,targetohcovrule, ltdgroup, infinitesupplysw, mpbatchnum
    ,seqintenablesw, itemstoregrade, rpbatchnum
)
select 'U_10_SKU_BASE_PART4'
   ,u.item, u.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
   ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom, 1 storablesw
   ,1 enablesw, 35 timeuom, ''  ff_trigger_control, 0 infcarryfwdsw
   ,1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup, 0 infinitesupplysw
   , 0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade, 0 rpbatchnum
from sku s, loc l, item i, 

    (select distinct matcode||'AI' item, loc 
    from udt_yield
    
    union
    
    select distinct matcode||'AR' item, loc
    from udt_yield
    where productionmethod = 'REP'
      and maxcap > 0                      -- Added by MAK
      and yield > 0                       -- Added by MAK
    ) u
    
where u.loc = l.loc
and u.item = i.item
and l.loc_type in (2, 4)
and i.enablesw = 1
and l.enablesw = 1 
and u.item = s.item(+)
and u.loc = s.loc(+)
and s.item is null;

commit;

/******************************************************************
** Part 5: loc_type 3 SKU for NA ==> Infinit Carry Switch to 0 
**         for WEEEKLY VERSION
******************************************************************/
insert into igpmgr.intins_sku 
( integration_jobid, item, loc, oh, replentype, netchgsw, ohpost
    ,planlevel, sourcinggroup, qtyuom, currencyuom, storablesw
    ,enablesw, timeuom, ff_trigger_control, infcarryfwdsw, minohcovrule
    ,targetohcovrule, ltdgroup, infinitesupplysw, mpbatchnum, seqintenablesw
    ,itemstoregrade, rpbatchnum
)
select 'U_10_SKU_BASE_PART5'
    , u.item, u.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
    ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom, 1 storablesw
    ,1 enablesw, 35 timeuom, ''  ff_trigger_control, u.infcarryfwdsw
    ,1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup, 0 infinitesupplysw
    ,0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade, 0 rpbatchnum
from 

    (select f.item, f.loc, f.infcarryfwdsw
    from sku s, 

        (select  distinct f.dmdunit item, f.loc, 
            0 infcarryfwdsw
--           case when i.u_stock = 'C' then 1 else 0 end infcarryfwdsw
        from fcst f, loc l, item i, dfuview v
        where f.startdate between to_date('07/05/2015', 'MM/DD/YYYY') and to_date('01/03/2016', 'MM/DD/YYYY')   
        and f.loc = l.loc  
        and f.dmdunit = i.item 
        and f.dmdgroup in ('ISS', 'COL')
        and i.u_stock in ('A', 'C')
        and l.loc_type = 3 
        and f.dmdunit = v.dmdunit
        and f.dmdgroup = v.dmdgroup
        and f.loc = v.loc
        and v.u_dfulevel = 0
        and l.u_area = 'NA'
        ) f
        
    where f.item = s.item(+)
    and f.loc = s.loc(+)
    and s.item is null
) u;

commit;



--once above sku are created now dts records can be created -- 

--insert into dfutosku (dmdunit, dmdgroup, dfuloc, item, skuloc, allocfactor, convfactor, eff, disc,
--    fcsttype, histtype, model, supersedesw, ff_trigger_control)
--
--    (select f.dmdunit, f.dmdgroup, f.loc dfuloc, f.item, f.skuloc, 1 allocfactor, 1 convfactor, to_date('01/01/1970', 'MM/DD/YYYY') eff, to_date('01/01/1970', 'MM/DD/YYYY') disc,
--        1 fcsttype, 1 histtype, f.model, 0 supersedesw, '' ff_trigger_control 
--    from dfutosku d,
--
--        (select s.item, s.loc skuloc, f.dmdunit, f.dmdgroup, f.model , f.loc
--        from sku s,
--
--            (select distinct f.dmdunit item, f.loc, f.dmdunit, f.dmdgroup, f.model
--            from fcst f, loc l
--            where f.loc = l.loc 
--            and l.loc_type = 3
--            ) f
--
--        where f.item = s.item
--        and f.loc = s.loc
--        ) f
--
--        where f.dmdunit = d.dmdunit(+)
--        and f.dmdgroup = d.dmdgroup(+)
--        and f.loc = d.dfuloc(+)
--        and f.item = d.item(+)
--        and f.skuloc = d.skuloc(+)
--        and f.model = d.model(+)
--        and d.item is null
--    );
--
--commit;

--rather than running transfer forecast could use below insert statement....

/******************************************************************
** Part 6: truncate and re-create dfutoskufcst 
******************************************************************/
execute immediate 'truncate table dfutoskufcst';

insert into igpmgr.intins_dfutoskufcst 
( integration_jobid, dmdunit, item, dmdgroup, dfuloc, skuloc
    ,startdate, dur, type, supersedesw, ff_trigger_control, totfcst
)
select distinct 'U_10_SKU_BASE_PART6'
        ,f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate
        ,f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
from sku s, item i, loc l, 

    (select distinct f.dmdunit, f.dmdunit item, f.dmdgroup, f.loc dfuloc, f.loc skuloc, startdate, dur, 1 type, 0 supersedesw, ''  ff_trigger_control, sum(qty) totfcst
    from fcst f, dfuview v
    where f.startdate between to_date('07/05/2015', 'MM/DD/YYYY') and to_date('01/03/2016', 'MM/DD/YYYY')   
    and f.dmdgroup in ('ISS', 'COL')
    and f.dmdunit = v.dmdunit
    and f.dmdgroup = v.dmdgroup
    and f.loc = v.loc
    and v.u_dfulevel = 0
    and f.dmdunit <> '4055RUNEW'
    group by f.dmdunit, f.dmdgroup, f.loc,  f.startdate, dur, 1, 0
    ) f
        
where f.item = s.item
and f.skuloc = s.loc
and f.item = i.item
and i.u_stock in ('A', 'C')
and f.skuloc = l.loc
and l.loc_type = 3
and l.u_area = 'NA';

commit;


/******************************************************************
** Part 7: create forecast records for RUNEW only where permitted
**         ,LOC:U_RUNEW_CUST = 1 truncate and re-create dfutoskufcst 
******************************************************************/
insert into igpmgr.intins_dfutoskufcst 
( integration_jobid, dmdunit, item, dmdgroup, dfuloc, skuloc, startdate
    ,dur, type , supersedesw, ff_trigger_control, totfcst
)
 
select distinct 'U_10_SKU_BASE_PART7'
    ,f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate
    ,f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
from sku s, item i,  

    (select distinct f.dmdunit, f.dmdunit item, f.dmdgroup, f.loc dfuloc, f.loc skuloc, startdate, dur, 1 type, 0 supersedesw, ''  ff_trigger_control, sum(qty) totfcst
    from fcst f, dfuview v, loc l
    where f.startdate between to_date('07/05/2015', 'MM/DD/YYYY') and to_date('01/03/2016', 'MM/DD/YYYY')   
    and f.dmdgroup in ('ISS')
    and f.dmdunit = v.dmdunit
    and f.dmdgroup = v.dmdgroup
    and f.loc = v.loc
    and v.u_dfulevel = 0
    and f.loc = l.loc
    and l.u_runew_cust = 1
    and f.dmdunit = '4055RUNEW'
    and l.loc_type = 3
    and l.u_area = 'NA'
    group by f.dmdunit, f.dmdgroup, f.loc,  f.startdate, dur, 1, 0
    ) f
        
where f.item = s.item
and f.skuloc = s.loc
and f.item = i.item
and i.u_stock in ('C');

commit;

/******************************************************************
** Part 8: create forecast records at LOC_TYPE 2 locations for 
**         supply of TPM; A, B and C stock are all supply 
**        (CAT10 SKU constraints) 
******************************************************************/
insert into igpmgr.intins_dfutoskufcst 
( integration_jobid, dmdunit, item, dmdgroup, dfuloc, skuloc
    ,startdate, dur, type, supersedesw, ff_trigger_control, totfcst
)
select distinct 'U_10_SKU_BASE_PART8'
    ,f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate
    ,f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
from sku s, item i, loc l, 

    (select distinct f.dmdunit, f.dmdunit item, f.dmdgroup, f.loc dfuloc
              ,f.loc skuloc , startdate, dur, 1 type, 0 supersedesw
              ,''  ff_trigger_control, sum(qty) totfcst
    from fcst f, dfuview v
    where f.startdate between to_date('07/05/2015', 'MM/DD/YYYY') and to_date('01/03/2016', 'MM/DD/YYYY')   
    and f.dmdgroup in ('TPM')
    and f.dmdunit = v.dmdunit
    and f.dmdgroup = v.dmdgroup
    and f.loc = v.loc
    and v.u_dfulevel = 0
    and f.dmdunit <> '4055RUNEW'
    group by f.dmdunit, f.dmdgroup, f.loc,  f.startdate, dur, 1, 0
    ) f
        
where f.item = s.item
and f.skuloc = s.loc
and f.item = i.item
and i.u_stock in ('A', 'B', 'C')
and f.skuloc = l.loc
and l.loc_type in (2, 4)
and l.u_area = 'NA';

commit;

/******************************************************************
** Part 9: Create Cal Records
******************************************************************/
insert into igpmgr.intins_cal 
( 
   integration_jobid, cal, descr, type, master, numfcstper, rollingsw
)

select 'U_10_SKU_BASE_PART9'
        ,s.loc||'_'||s.item cal, 'Allocation Calendar' descr
        ,7 type, ' ' master, 0 numfcstper, 0 rollingsw 
from sku s,

    (select cal, substr(cal, 1, instr(cal, '_')-1) loc, substr(cal, instr(cal, '_')+1, 55) item
    from cal
    where type =  7
    and cal <> ' '
    and instr(cal, '_') <> 0) c

where s.item = c.item(+)
and s.loc = c.loc(+)
and c.item is null;

commit;

/******************************************************************
** Part 10: Create Caldata Records
******************************************************************/
insert into igpmgr.intins_caldata
(
  integration_jobid, cal, altcal, eff, opt, repeat, avail, descr
   ,perwgt, allocwgt, covdur
)
select 'U_10_SKU_BASE_PART10'
       ,c.cal, ' ' altcal, 23319360 eff, 6 opt, 0 repeat, 0 avail
       ,'Allocation Calendar' descr, 0 perwgt, 1/7 allocwgt, 0 covdur 
from cal c, caldata cd, sku s
where substr(c.cal, 1, instr(c.cal, '_')-1) = s.loc
and substr(c.cal, instr(c.cal, '_')+1, 55) = s.item
and c.type = 7 
and c.cal = cd.cal(+)
and cd.cal is null;

commit;

/******************************************************************
** Part 11: Create the SKU demand paramters 
******************************************************************/
insert into igpmgr.intins_skudemandparam 
( 
   integration_jobid, item, loc, custorderdur, dmdtodate, fcstadjrule
     ,maxcustordersysdur, proratesw, prorationdur, dmdredid, ccpsw
     ,custorderpriority, fcstmeetearlydur, fcstpriority, fcstmeetlatedur
     ,alloccal, inddmdunitcost, inddmdunitmargin, unitcarcost
     ,ff_trigger_control, fcstconsumptionrule, fcstprimconsdur
     ,fcstsecconsdur, proratebytypesw, alloccalgroup, mastercal, weeklyavghist
)
select 'U_10_SKU_BASE_PART11'
       ,s.item, s.loc, 
    case when l.loc_type = 3 then 1440*1 else 1440*365 end custorderdur, 0 dmdtodate,     
    case when l.loc_type = 3 then 6 else 2 end fcstadjrule, 
    case when l.loc_type = 3 then 1440*13 else 0 end maxcustordersysdur, 0 proratesw
      ,0 prorationdur, ' ' dmdredid, 0 ccpsw, -1 custorderpriority, 0 fcstmeetearlydur
      ,-1 fcstpriority , 0 fcstmeetlatedur, s.loc||'_'||s.item alloccal
      ,0 inddmdunitcost, 0 inddmdunitmargin, 0 unitcarcost, ''  ff_trigger_control
      ,0 fcstconsumptionrule, 0 fcstprimconsdur, 0 fcstsecconsdur
      ,0 proratebytypesw, ' ' alloccalgroup, ' ' mastercal, 0 weeklyavghist
from skudemandparam p, sku s, loc l
where s.enablesw = 1
and s.loc = l.loc
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;
/******************************************************************
** Part 12: SKU deployment paramters
******************************************************************/
insert into igpmgr.intins_skudeployparam 
(
  integration_jobid, item, loc, allocstratid, constrrecshipsw
  ,locpriority, minallocdur, pushopt, recshippushopt, recshipsupplyrule
  ,rsallocrule, stockavaildur, dyndepldur, incstkoutcost, initstkoutcost
  ,shortagessfactor, surplusrestockcost, surplusssfactor, shortagedur
  ,unitstocklowcost, unitstockoutcost, enablesubsw, meetprisssw
  ,usesubstsssw, recshipcal, ff_trigger_control, deploydetaillevel
  ,holdbackqty, maxbucketdur, skupriority, secrsallocrule
  ,recshipdur, sourcessrule
)
select 'U_10_SKU_BASE_PART12'
       ,s.item, s.loc, ' ' allocstratid, 0 constrrecshipsw, 1 locpriority
       ,0 minallocdur, 0 pushopt, 1 recshippushopt, 1 recshipsupplyrule
       ,1 rsallocrule, 0 stockavaildur, 0 dyndepldur, 0 incstkoutcost
       ,0 initstkoutcost, 1 shortagessfactor, 0 surplusrestockcost
       ,0 surplusssfactor, 0 shortagedur, 0 unitstocklowcost
       ,0 unitstockoutcost, 0 enablesubsw, 0 meetprisssw, 0 usesubstsssw
       ,' ' recshipcal, ''  ff_trigger_control, 1 deploydetaillevel, 0 holdbackqty
       ,0 maxbucketdur, 0 skupriority, 1 secrsallocrule, 0 recshipdur, 3 sourcessrule
from skudeploymentparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;
/******************************************************************
** Part 13: SKU planning Param
******************************************************************/
insert into igpmgr.intins_skuplannparam 
(
    integration_jobid, item, loc, atpdur, depdmdopt, externalskusw
    ,firstreplendate, lastfrzstart, lastplanstart, plandur, planleadtime
    ,planleadtimerule, planshipfrzdur, restrictdur, allocbatchsw
    ,cmpfirmdur, custservicelevel, maxchangefactor, mfgleadtime
    ,recschedrcptsdur, cpppriority, cpplocksw, criticalmaterialsw
    ,aggexcesssupplyrule, aggundersupplyrule, bufferleadtime, maxoh
    ,maxcovdur, drpcovdur, drpfrzdur, drprule, drptimefencedate
    ,drptimefencedur, incdrpqty, mindrpqty, mpscovdur, mfgfrzdur
    ,mpsrule, mpstimefencedate, mpstimefencedur, incmpsqty, minmpsqty
    ,shrinkagefactor, expdate, atprule, prodcal, prodstartdate
    ,prodstopdate, orderingcost, holdingcost, eoq, ff_trigger_control
    ,workingcal, lookaheaddur, orderpointrule, orderskudetailsw
    ,supsdmindmdcovdur,  orderpointminrule, orderpointminqty
    ,orderpointmindur, orderuptolevelmaxrule, orderuptolevelmaxqty
    ,orderuptolevelmaxdur, aggskurule, fwdbuymaxdur, costuom
    ,cumleadtimedur, cumleadtimeadjdur, cumleadtimerule, roundingfactor
    ,limitplanarrivpublishsw, limitplanarrivpublishdur, maxohrule
)

select 'U_10_SKU_BASE_PART13'
    ,s.item, s.loc, 0 atpdur, 3 depdmdopt, 0 externalskusw
    ,v_init_eff_date firstreplendate, v_init_eff_date lastfrzstart
    ,v_init_eff_date lastplanstart, 524160 plandur, 0 planleadtime
    ,2 planleadtimerule, 0 planshipfrzdur, 0 restrictdur, 0 allocbatchsw
    ,0 cmpfirmdur, 0.9 custservicelevel, 1 maxchangefactor, 0 mfgleadtime
    ,0 recschedrcptsdur, 1 cpppriority, 0 cpplocksw, 1 criticalmaterialsw
    ,2 aggexcesssupplyrule, 1 aggundersupplyrule, 0 bufferleadtime
    ,999999999 maxoh, 1048320 maxcovdur, 10080 drpcovdur, 0 drpfrzdur
    ,1 drprule, v_init_eff_date drptimefencedate, 0 drptimefencedur
    ,1 incdrpqty, 0 mindrpqty, 10080 mpscovdur, 0 mfgfrzdur, 1 mpsrule
    ,v_init_eff_date mpstimefencedate, 0 mpstimefencedur, 1 incmpsqty
    ,0 minmpsqty, 0 shrinkagefactor, v_init_eff_date expdate, 1 atprule
    ,' ' prodcal, TO_DATE('01/01/1970', 'MM/DD/YYYY') prodstartdate
    ,v_init_eff_date prodstopdate, 1 orderingcost, 1 holdingcost
    ,1 eoq, ''  ff_trigger_control, ' ' workingcal, 0 lookaheaddur
    ,2 orderpointrule, 0 orderskudetailsw, 1048320 supsdmindmdcovdur
    ,1 orderpointminrule, 0 orderpointminqty, 0 orderpointmindur
    ,1 orderuptolevelmaxrule, 0 orderuptolevelmaxqty
    ,0 orderuptolevelmaxdur, 0 aggskurule, 0 fwdbuymaxdur, 0 costuom
    ,0 cumleadtimedur, 0 cumleadtimeadjdur, 1 cumleadtimerule
    ,0 roundingfactor, 0 limitplanarrivpublishsw
    ,0 limitplanarrivpublishdur, 1 maxohrule
from skuplanningparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;
/******************************************************************
** Part 14: SKU safteystock parameters
******************************************************************/

insert into igpmgr.intins_skussparam 
(
    integration_jobid, item, loc, avgleadtime, avgnumlines, leadtimesd
    ,maxss, minss, mfgleadtimerule, mselag, mseper, netfcstmsesmconst
    ,numreplenyr, statssadjopt, sscov, ssrule, statsscsl, ssmeetearlydur
    ,sspriority, tohrule, sstemplate, dmddisttype, cslmetric
    ,calcstatssrule, avgdmdcal, avgdmdlookbwddur, avgdmdlookfwddur
    ,calcmserule, dmdcal, dmdpostdate, fcstdur, ff_trigger_control
    ,statsscovlimitdur, supersedesssw, msemaskopt, msemaskminval
    ,msemaskmaxval, dmdcorrelationfactor, accumdur, mseabstolerancelimit
    ,dmdalloccal, sspresentationopt, maxsscovskipdur, maxssfactor
    ,msemodelopt, sscovusebaseonlysw, arrivalpostdate, shipdatadur
    ,shiplag, orderlag, orderpostdate, orderdatadur, allowearlyarrivsw
    ,allowearlyordersw, csltemplate
)
select 'U_10_SKU_BASE_PART14'
    ,s.item, s.loc, 0 avgleadtime, 0 avgnumlines, 0 leadtimesd
    ,999999999 maxss, 0 minss, 1 mfgleadtimerule, 0 mselag, 0 mseper
    ,0 netfcstmsesmconst, 12 numreplenyr, 1 statssadjopt, 0 sscov
    ,1 ssrule, 0 statsscsl, 0 ssmeetearlydur, -1 sspriority, 3 tohrule
    ,' ' sstemplate, 1 dmddisttype, 2 cslmetric, 1 calcstatssrule
    ,' ' avgdmdcal, 0 avgdmdlookbwddur, 525600 avgdmdlookfwddur
    ,1 calcmserule, ' ' dmdcal, v_init_eff_date dmdpostdate
    ,10080 fcstdur, ''  ff_trigger_control, 0 statsscovlimitdur
    ,1 supersedesssw, 0 msemaskopt, 0 msemaskminval, 100 msemaskmaxval
    ,1 dmdcorrelationfactor, 1440 accumdur, 0 mseabstolerancelimit
    ,' ' dmdalloccal, 1 sspresentationopt, 0 maxsscovskipdur
    ,0 maxssfactor, 1 msemodelopt, 0 sscovusebaseonlysw
    ,v_init_eff_date arrivalpostdate, 0 shipdatadur, 0 shiplag
    ,0 orderlag, v_init_eff_date orderpostdate, 0 orderdatadur
    ,1 allowearlyarrivsw, 1 allowearlyordersw, '' csltemplate
from skusafetystockparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;

/******************************************************************
** Part 15: Update OnHand Post
******************************************************************/
update sku set ohpost = (select min(startdate) from dfutoskufcst);

commit;

end;

/

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

--------------------------------------------------------
--  DDL for Procedure U_20_PRD_BUY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_20_PRD_BUY" as

begin

/*
less than one minute -- (06/23/105)
*/

delete res where res like 'BUY%';

commit;

delete productionmethod where productionmethod = 'BUY' and item||loc in 

    (select item||loc
    from udt_yield y
    where productionmethod = 'BUY' 
    and dnd = 0
    );
    
commit;

delete bom where subord like '%RUNEW';

commit;

insert into res (res, loc, type, cal, cost,   descr,  avgskuchg,   avgfamilychg, avgskuchgcost,   avgfamilychgcost,  levelloadsw,     
    levelseqnum,    criticalitem,  checkmaxcap,  unitpenalty,  adjfactor, source,  enablesw, subtype, qtyuom,  currencyuom,  productionfamilychgoveropt)

select u.res, u.loc, u.type, ' ' cal, 0 cost,     ' ' descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' ' criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,     ' ' source,     1 enablesw,     u.subtype,     28 qtyuom,     11 currencyuom,     0 productionfamilychgoveropt
from res r, 

    (select distinct s.loc, 'BUY'||i.u_qualitybatch||'@'||s.loc res, 4 type, 1 subtype
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) u
    
where u.loc = r.loc(+)
and u.res = r.res(+)
and r.res is null;

commit;

insert into productionmethod (item, loc, productionmethod,     descr,     eff,     priority,     minqty,     incqty,     disc,     leadtime,     maxqty,     offsettype,     loadopt,     maxstartdur,     
    maxfindur,     splitordersw,     bomnum,     enablesw,     minleadtime,     maxleadtime,     yieldqty,     splitfactor,     nonewsupplydate,     finishcal,     leadtimecal,     workscope,     lotsizesenabledsw)

select u.item, u.loc, u.productionmethod, ' ' descr,  scpomgr.u_jan1970 eff,     1 priority,     0 minqty,     0 incqty,    scpomgr.u_jan1970 disc,     0 leadtime,     0 maxqty,     
    1 offsettype,     1 loadopt,     0 maxstartdur,     0 maxfindur,     0 splitordersw,     0 bomnum,     1 enablesw,     0 minleadtime,     1440 * 365 * 100 maxleadtime,     0 yieldqty,     1 splitfactor,     
    scpomgr.u_jan1970 nonewsupplydate,     ' ' finishcal,     ' ' leadtimecal,     ' ' workscope,     0 lotsizesenabledsw
from productionmethod p,

    (select s.item, s.loc, 'BUY' productionmethod
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.enablesw = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) u

where u.item = p.item(+)
and u.loc = p.loc(+) 
and u.productionmethod = p.productionmethod(+)
and p.item is null;

commit;

insert into productionstep (item, loc, productionmethod, stepnum,     nextsteptiming,     fixedresreq,     prodrate,     proddur,     prodoffset,     enablesw,     spread,     maxstartdur,     
  eff,     res,     descr,     loadoffsetdur,     prodcost,     qtyuom,     setup,     inusebeforesw,     prodfamily)

select pm.item, pm.loc, pm.productionmethod, 1 stepnum,     3 nextsteptiming,     0 fixedresreq,     1 prodrate,     0 proddur,     0 prodoffset,     1 enablesw,     0 spread,     0 maxstartdur,     
    scpomgr.u_jan1970 eff,     r.res,     ' ' descr,     0 loadoffsetdur,     0 prodcost,     28 qtyuom,     ' ' setup,     0 inusebeforesw,     ' ' prodfamily 
from productionmethod pm, productionstep ps, res r, loc l, item i
where r.loc = pm.loc
and 'BUY'||i.u_qualitybatch||'@'||pm.loc = r.res
and pm.loc = l.loc
and l.loc_type = 1
and r.enablesw = 1
and pm.enablesw = 1 
and pm.item = i.item
and pm.productionmethod = 'BUY' 
and pm.item = ps.item(+)
and pm.loc = ps.loc(+)
and pm.productionmethod = ps.productionmethod(+)
and ps.item is null;

commit;

-- now need to create production methods, unconstrained, no cost, to consume RUNEW into RUSTD....

insert into bom (item, loc, bomnum,     subord,     drawqty,     eff,     disc,     offset,     mixfactor,     yieldfactor,     shrinkagefactor,     drawtype,     explodesw,     unitconvfactor,     enablesw,     
    ecn,     supersedesw,     ff_trigger_control,     qtyuom,     qtyperassembly)

select u.item, u.loc, u.bomnum,     u.subord,     u.drawqty,     scpomgr.u_jan1970 eff,     scpomgr.u_jan1970 disc,     0 offset,     100 mixfactor,     100 yieldfactor,     
    0 shrinkagefactor,     2 drawtype,     0 explodesw,     0 unitconvfactor,     1 enablesw,     ' ' ecn,     0 supersedesw,   '' ff_trigger_control,     18 qtyuom,     0 qtyperassembly
from bom b, sku s, sku ss,

    (select s.item, i.u_materialcode||'RUNEW' subord, s.loc, 1 bomnum, 1 drawqty
    from sku s, loc l, item i, udt_cost_unit u
    where s.loc = l.loc
    and l.loc_type = 1
    and s.item = i.item
    and s.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch <> 'RUNEW'
    and i.u_stock = 'C'
    and l.loc <> ' '
    ) u

where u.item = s.item
and u.loc = s.loc
and u.subord = ss.item
and u.loc = ss.loc
and s.enablesw = 1
and ss.enablesw = 1
and u.item = b.item(+)
and u.loc = b.loc(+)
and u.subord = b.subord(+)
and u.bomnum = b.bomnum(+)
and b.item is null;

commit;

insert into productionmethod (item, loc, productionmethod,     descr,     eff,     priority,     minqty,     incqty,     disc,     leadtime,     maxqty,     offsettype,     loadopt,     maxstartdur,     
    maxfindur,     splitordersw,     bomnum,     enablesw,     minleadtime,     maxleadtime,     yieldqty,     splitfactor,     nonewsupplydate,     finishcal,     leadtimecal,     workscope,     lotsizesenabledsw)

select t.item, t.loc, t.productionmethod, ' ' descr,  scpomgr.u_jan1970 eff,     1 priority,     0 minqty,     0 incqty,     scpomgr.u_jan1970 disc,     0 leadtime,     0 maxqty,     
    1 offsettype,     1 loadopt,     0 maxstartdur,     0 maxfindur,     0 splitordersw,     t.bomnum,     1 enablesw,     0 minleadtime,     1440 * 365 * 100 maxleadtime,     0 yieldqty,     1 splitfactor,     
    scpomgr.u_jan1970 nonewsupplydate,     ' ' finishcal,     ' ' leadtimecal,     ' ' workscope,     0 lotsizesenabledsw
from productionmethod p, 

    (select b.item, b.loc, 'BUY' productionmethod, b.bomnum
    from bom b, loc l, item i, udt_cost_unit u
    where b.loc = l.loc
    and l.loc_type = 1
    and b.subord = i.item
    and b.loc = u.loc
    and i.u_materialcode= u.matcode
    and i.u_qualitybatch = 'RUNEW'
    and l.loc <> ' '
    ) t

where  t.item = p.item(+)
and t.loc = p.loc(+)
and t.bomnum = p.bomnum(+)
and t.productionmethod = p.productionmethod(+)
and p.item is null;

commit;

--is a productionstep record necessary ??
--removed 08/18

insert into productionyield (item, loc, productionmethod, eff, qtyuom, outputitem, yieldqty)

select p.item, p.loc, p.productionmethod, scpomgr.u_jan1970 eff, 18 qtyuom, p.item outputitem, 1 yieldqty 
from productionyield y, productionmethod p
where p.item = y.item(+)
and p.loc = y.loc(+)
and p.productionmethod = y.productionmethod(+)
and y.item is null;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_22_PRD_INSPECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_22_PRD_INSPECT" as

begin

-- create production methods, BOM's resources and constraints for inspection processes
--less than one minute

delete productionmethod where productionmethod = 'INS' and item||loc in 

    (select item||loc
    from udt_yield y
    where productionmethod = 'INS' 
    and dnd = 0
    );
    
commit;

delete bom where bomnum = 1
and item||subord||loc in 

    (select b.item||b.subord||b.loc
    from bom b, item i,

        (select item, loc, bomnum from productionmethod
        ) p

    where b.bomnum = 1
    and b.subord = i.item
    and i.u_stock = 'A'
    and b.item = p.item(+)
    and b.loc = p.loc(+)
    and b.bomnum = p.bomnum(+)
    and p.item is null
    );
    
commit;

delete res where res||loc in

    (select r.res||r.loc
    from res r,

        (select res, loc from productionstep
        ) p

    where substr(r.res, 1, 3) = 'INS'
    and r.res = p.res(+)
    and r.loc = p.loc(+)
    and p.res is null
    );
    
commit;

insert into bom (item, loc, bomnum,     subord,     drawqty,     eff,     disc,     offset,     mixfactor,     yieldfactor,     shrinkagefactor,     drawtype,     explodesw,     unitconvfactor,     enablesw,     
  ecn,     supersedesw,     ff_trigger_control,     qtyuom,     qtyperassembly)

select u.item, u.loc, u.bomnum,     u.subord,     u.drawqty,     TO_DATE('01/01/1970 00:00','MM/DD/YYYY HH24:MI') eff,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     0 offset,     100 mixfactor,     100 yieldfactor,     
    0 shrinkagefactor,     2 drawtype,     0 explodesw,     0 unitconvfactor,     1 enablesw,     ' ' ecn,     0 supersedesw,   '' ff_trigger_control,     18 qtyuom,     0 qtyperassembly
from bom b, sku s, sku ss, loc l,

    (select loc, item, matcode||'AI' subord, 1 bomnum, 1 drawqty
    from udt_yield
    where productionmethod = 'INS'
    and qb = 'AR'
    and maxcap > 0
    and yield > 0

    union

    select y.loc, y.item, matcode||'AI' subord, 1 bomnum, 1 drawqty
    from udt_yield y, item i
    where y.item = i.item
    and i.u_stock = 'C'
    and y.productionmethod = 'INS'
    and y.maxcap > 0
    and y.yield > 0
    and y.matcode||y.loc not in (select distinct matcode||loc from udt_yield where qb = 'AR' and productionmethod = 'INS' and maxcap > 0 and yield > 0)  -- this 2nd part of union is for INS production method which has no B stock yield; only C stock
    ) u

where u.loc = l.loc
and l.loc_type in (2, 4)
and u.item = s.item
and u.loc = s.loc
and u.subord = ss.item
and u.loc = ss.loc
and s.enablesw = 1
and ss.enablesw = 1
and u.item <> u.subord
and u.item = b.item(+)
and u.loc = b.loc(+)
and u.subord = b.subord(+)
and u.bomnum = b.bomnum(+)      
and b.item is null;

commit;

insert into productionmethod (item, loc, productionmethod,     descr,     eff,     priority,     minqty,     incqty,     disc,     leadtime,     maxqty,     offsettype,     loadopt,     maxstartdur,     
    maxfindur,     splitordersw,     bomnum,     enablesw,     minleadtime,     maxleadtime,     yieldqty,     splitfactor,     nonewsupplydate,     finishcal,     leadtimecal,     workscope,     lotsizesenabledsw)

select b.item, b.loc, 'INS' productionmethod, ' ' descr,  to_date('01/01/1970', 'MM/DD/YYYY') eff,     1 priority,     0 minqty,     0 incqty,     to_date('01/01/1970', 'MM/DD/YYYY') disc,     0 leadtime,     0 maxqty,     
    1 offsettype,     1 loadopt,     0 maxstartdur,     0 maxfindur,     0 splitordersw,     nvl(b.bomnum, 0) bomnum,     1 enablesw,     0 minleadtime,     1440 * 365 * 100 maxleadtime,     0 yieldqty,     1 splitfactor,     
    TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' finishcal,     ' ' leadtimecal,     ' ' workscope,     0 lotsizesenabledsw
from sku s, bom b, loc l, item i,

    (select item, loc, productionmethod, bomnum from productionmethod where productionmethod = 'INS'
    ) p
    
where s.loc = l.loc
and l.loc_type in ( 2, 4)
and s.enablesw = 1 
and b.subord = i.item
and i.u_stock = 'A'
and b.bomnum = 1
and b.item = s.item
and b.loc = s.loc
and b.item = p.item(+)
and b.loc = p.loc(+)
and b.bomnum = p.bomnum(+)
and p.item is null;

commit;

insert into res (res, loc, type, cal, cost,   descr,  avgskuchg,   avgfamilychg, avgskuchgcost,   avgfamilychgcost,  levelloadsw,     
    levelseqnum,    criticalitem,  checkmaxcap,  unitpenalty,  adjfactor, source,  enablesw, subtype, qtyuom,  currencyuom,  productionfamilychgoveropt)

select u.res, u.loc, u.type, ' ' cal, 0 cost,     ' ' descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' ' criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,     ' ' source,     1 enablesw,     1 subtype,     u.qtyuom,     15 currencyuom,     0 productionfamilychgoveropt
from res r, 

    (select distinct 'INSCAP'||'@'||s.loc res, s.loc, 4 type, 28 qtyuom
    from sku s, loc l, item i
    where s.loc = l.loc
    and l.loc_type in ( 2, 4)
    and l.enablesw = 1
    and s.enablesw = 1
    and s.item = i.item
    and i.u_stock <> 'A'
    
    union
    
    select distinct 'INSCST'||'@'||lpad(i.u_materialcode, 2, '0')||s.loc res, s.loc, 4 type, 18 qtyuom
    from sku s, loc l, item i
    where s.loc = l.loc
    and l.loc_type in ( 2, 4)
    and l.enablesw = 1
    and s.enablesw = 1
    and s.item = i.item
    and i.u_stock <> 'A'
    ) u
    
where u.loc = r.loc(+)
and u.res = r.res(+)
and r.res is null;

commit;

--create 2 production steps & resources; 1 for capacity and 2 for cost

insert into productionstep (item, loc, productionmethod, stepnum,     nextsteptiming,     fixedresreq,     prodrate,     proddur,     prodoffset,     enablesw,     spread,     maxstartdur,     
    eff,     res,     descr,     loadoffsetdur,     prodcost,     qtyuom,     setup,     inusebeforesw,     prodfamily)

select pm.item, pm.loc, pm.productionmethod, 
    case when substr(r.res, 1, 6) = 'INSCAP' then 1 else 2 end stepnum,     3 nextsteptiming,     0 fixedresreq,     
        case when u.rate = 0 then 1 else u.rate end prodrate,     0 proddur,     0 prodoffset,     1 enablesw,     0 spread,     0 maxstartdur,     
    TO_DATE('01/01/1970','MM/DD/YYYY') eff,     r.res,     ' ' descr,     0 loadoffsetdur,     0 prodcost,     
    case when substr(r.res, 1, 6) = 'INSCAP' then 28 else 18 end qtyuom,     ' ' setup,     0 inusebeforesw,     ' ' prodfamily 
from productionmethod pm, productionstep ps, res r, loc l, item i,

        (select item, loc, round(((maxcap/efficiency)/maxdaysperwk)/maxhrsperday, 0) rate
        from udt_yield
        where productionmethod = 'INS'
        and maxcap > 0
        and yield > 0
        ) u

where pm.loc = l.loc
and l.loc_type in (2, 4)
and (r.res = 'INSCST'||'@'||lpad(i.u_materialcode, 2, '0')||pm.loc  or r.res = 'INSCAP'||'@'||lpad(i.u_materialcode, 2, '0')||pm.loc)
and r.loc = pm.loc
and r.enablesw = 1
and pm.enablesw = 1
and pm.item = u.item
and pm.loc = u.loc
and pm.item = i.item
and pm.productionmethod = 'INS'
and pm.item = ps.item(+)
and pm.loc = ps.loc(+)
and pm.productionmethod = ps.productionmethod(+)
and ps.item is null;

commit;

insert into productionyield (item, loc, productionmethod, eff, qtyuom, outputitem, yieldqty)

select p.item, p.loc, p.productionmethod, to_date('01/01/1970', 'MM/DD/YYYY') eff, 18 qtyuom, p.outputitem, p.yield yieldqty 
from productionyield y, sku so, loc l,

    (select distinct pm.item, u.item outputitem, pm.loc, pm.productionmethod, u.yield
    from bom b, productionmethod pm, item i,

        (select b.item, b.loc, p.yield, p.matcode
        from bom b, udt_yield p
        where b.item = p.item
        and b.loc = p.loc
        and b.bomnum = 1
        and p.productionmethod = 'INS'
        and p.maxcap > 0
        and p.yield > 0
        
        union
        
        select y.item, y.loc, y.yield, y.matcode
        from udt_yield y, item i
        where y.item = i.item
        and y.productionmethod = 'INS'
        and i.u_stock in ('B', 'C')
        and y.maxcap > 0
        and y.yield > 0
        and y.item||y.loc not in (select item||loc from bom where bomnum = 1)
        ) u

    where b.item = i.item
    and i.u_materialcode = u.matcode 
    and b.loc = u.loc
    and b.bomnum = 1
    and b.item = pm.item
    and b.loc = pm.loc
    and pm.productionmethod = 'INS'
     )p

where p.loc = l.loc
and l.loc_type in ( 2, 4)
and so.item = p.outputitem
and so.loc = p.loc
and p.item = y.item(+)
and p.loc = y.loc(+)
and p.productionmethod = y.productionmethod(+)
and y.item is null;

commit;

insert into cost (cost,  enablesw,   cumulativesw,  groupedsw,  sharedsw,  qtyuom,  currencyuom,   accumcal,  maxqty,     maxutilization)

select distinct 'LOCAL:RES:'||u.res||'-202' cost,     1 enablesw,     0 cumulativesw,     0 groupedsw,     0 sharedsw,     18 qtyuom,     15 currencyuom,    ' '   accumcal,     0 maxqty,     0 maxutilization
from cost c, 

    (select r.res, 'LOCAL:RES:'||r.res||'-202' cost
    from res r
    where r.subtype = 1
    and substr(r.res, 1, 6) = 'INSCST'
    ) u
    
where u.cost = c.cost(+)
and c.cost is null;

commit;

insert into costtier (breakqty, category, value, eff, cost)

select distinct 0 breakqty, 303 category, nvl(q.unit_cost, 99) value , to_date('01/01/1970', 'MM/DD/YYYY') eff, c.cost  
  
from cost c, costtier t, 

    (select s.item, s.matcode, s.loc, s.productionmethod, s.stepnum, s.res, s.cost, nvl(u.unit_cost, 99) unit_cost
    from

        (select s.item, i.u_materialcode matcode, s.loc, s.productionmethod, s.stepnum, s.res, 'LOCAL:RES:REPCST@'||s.loc||'-202' cost
        from productionstep s, item i
        where s.productionmethod = 'INS'
        and s.stepnum = 2
        and s.item = i.item
        ) s,

        (select loc, matcode, process productionmethod, unit_cost
        from udt_cost_unit
        where process = 'INS'
        ) u
        
    where s.matcode = u.matcode(+)
    and s.loc = u.loc(+)
    and s.productionmethod = u.productionmethod(+)
    ) q

where c.cost = q.cost
and c.cost = t.cost(+)
and t.cost is null;

commit;

insert into rescost (category, res, localcost, tieredcost)

select distinct 202 category, u.res, t.cost localcost, ' ' tieredcost
from rescost r, costtier t, 

    (select r.res, 'LOCAL:RES:'||r.res||'-202' cost
    from res r
    where r.subtype = 1
    ) u

where t.cost = u.cost
and u.cost = r.localcost(+)
and r.localcost is null;

commit;

--must run u_29_prd_resconstraint or _wk

end;

/

--------------------------------------------------------
--  DDL for Procedure U_23_PRD_REPAIR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_23_PRD_REPAIR" as

begin

/*************************************************************
** Part 1: Delete production methods for Repair
*************************************************************/

delete productionmethod where productionmethod = 'REP' and item||loc in 

    (select item||loc
    from udt_yield y
    where productionmethod = 'REP' 
    and dnd = 0
    );
    
commit;

/*************************************************************
** Part 2: Delete BOM's for A stock.
*************************************************************/

delete bom where bomnum = 1
and item||subord||loc in 

    (select b.item||b.subord||b.loc
    from bom b, item i,

        (select item, loc, bomnum from productionmethod
        ) p

    where b.bomnum = 1
    and b.subord = i.item
    and i.u_stock <> 'A'
    and b.item = p.item(+)
    and b.loc = p.loc(+)
    and b.bomnum = p.bomnum(+)
    and p.item is null
    );
    
commit;

/*************************************************************
** Part 3: Delete Repair resources
*************************************************************/

delete res where res||loc in

    (select r.res||r.loc
    from res r,

        (select res, loc from productionstep
        ) p

    where substr(r.res, 1, 3) = 'REP'
    and r.res = p.res(+)
    and r.loc = p.loc(+)
    and p.res is null
    );

commit;

/*************************************************************
** Part 4: create BOM's for Repair Processes
*************************************************************/

insert into igpmgr.intins_bom 
(integration_jobid, item, loc, bomnum, subord, drawqty, eff
  ,disc, offset, mixfactor, yieldfactor, shrinkagefactor
  ,drawtype, explodesw, unitconvfactor, enablesw
  ,ecn, supersedesw, ff_trigger_control, qtyuom, qtyperassembly
)

select 'U_23_PRD_REPAIR_PART4' 
     ,u.item, u.loc, u.bomnum, u.subord, u.drawqty
     ,TO_DATE('01/01/197000:00','MM/DD/YYYYHH24:MI') eff
     ,TO_DATE('01/01/1970','MM/DD/YYYY') disc, 0 offset
     ,100 mixfactor, 100 yieldfactor, 0 shrinkagefactor, 2 drawtype
     ,0 explodesw, 0 unitconvfactor, 1 enablesw, '' ecn, 0 supersedesw
     ,''ff_trigger_control, 18 qtyuom, 0 qtyperassembly
from bom b, sku s, sku ss, 

    (select y.item, i.u_materialcode||'AR' subord, y.loc, 1 bomnum, 1 drawqty
    from udt_yield y, item i, udt_plant_status ps
    where y.productionmethod = 'REP'
    and y.item = i.item 
    and i.u_stock = 'C' 
    and y.maxcap > 0
    and y.yield > 0
    and y.loc=ps.loc
    and ps.res='REPAIR'
    and ps.status=1
    ) u

where u.item = s.item
and u.loc = s.loc
and u.subord = ss.item
and u.loc = ss.loc
and s.enablesw = 1
and ss.enablesw = 1
and u.item <> u.subord
and u.item = b.item(+)
and u.loc = b.loc(+)
and u.subord = b.subord(+)
and u.bomnum = b.bomnum(+)      
and b.item is null;

commit;

/*************************************************************
** Part 5: Create Resource Records
*************************************************************/

insert into igpmgr.intins_res 
(integration_jobid, res, loc, type, cal, cost, descr, avgskuchg
   ,avgfamilychg, avgskuchgcost, avgfamilychgcost, levelloadsw
   ,levelseqnum, criticalitem, checkmaxcap, unitpenalty, adjfactor
   ,source, enablesw, subtype, qtyuom, currencyuom
   , productionfamilychgoveropt
)
select 'U_23_PRD_REPAIR_PART5'
       ,u.res, u.loc, u.type, ' ' cal, 0 cost, ' ' descr
       ,0 avgskuchg, 0 avgfamilychg, 0 avgskuchgcost
       ,0 avgfamilychgcost, 0 levelloadsw, 1 levelseqnum
       ,' ' criticalitem, 1 checkmaxcap, 0 unitpenalty
       ,1 adjfactor, ' ' source, 1 enablesw, 1 subtype
       ,u.qtyuom, 11 currencyuom, 0 productionfamilychgoveropt
from res r, 

    (select distinct 'REPCAP'||'@'||s.loc res, s.loc, 4 type, 28 qtyuom
    from sku s, loc l, item i,
    
        (select distinct y.loc
        from udt_yield y, udt_plant_status ps
        where y.productionmethod = 'REP'
        and y.maxcap > 0
        and y.yield > 0
        and y.loc=ps.loc
        and ps.res='REPAIR'
        and ps.status=1
        ) q
    
    where s.loc = l.loc
    and l.loc_type in ( 2, 4)
    and l.enablesw = 1
    and s.enablesw = 1
    and s.item = i.item
    and s.loc = q.loc
    and i.u_stock <> 'A'
    
    union
    
    select distinct 'REPCST'||'@'||s.loc res, s.loc, 4 type, 18 qtyuom
    from sku s, loc l, item i,
    
        (select distinct y.matcode, y.loc
           from udt_yield y, udt_plant_status ps
          where y.productionmethod = 'REP'
            and y.maxcap > 0
            and y.yield > 0   
            and y.loc=ps.loc
            and ps.res='REPAIR'
            and ps.status=1
        ) q
    
    where s.loc = l.loc
    and l.loc_type in ( 2, 4)
    and l.enablesw = 1
    and s.enablesw = 1
    and s.item = i.item
    and s.loc = q.loc
    and i.u_stock <> 'A'
    and q.matcode <> '16' -- matcode 16 is not REP but WAS
    ) u
    
where u.loc = r.loc(+)
and u.res = r.res(+)
and r.res is null;

commit;

/*************************************************************
** Part 6: Create Production Methods
*************************************************************/

insert into igpmgr.intins_prodmethod 
(  integration_jobid, item, loc, productionmethod, descr, eff
  ,priority, minqty, incqty, disc, leadtime, maxqty, offsettype
  ,loadopt, maxstartdur, maxfindur, splitordersw, bomnum, enablesw
  ,minleadtime, maxleadtime, yieldqty, splitfactor, nonewsupplydate
  ,finishcal, leadtimecal, workscope, lotsizesenabledsw
)
select 'U_23_PRD_REPAIR_PART6'
       , b.item, b.loc, t.productionmethod, ' ' descr, v_init_eff_date eff
       ,1 priority, 0 minqty, 0 incqty, v_init_eff_date disc, 0 leadtime
       ,0 maxqty, 1 offsettype, 1 loadopt, 0 maxstartdur, 0 maxfindur
       ,0 splitordersw, nvl(b.bomnum, 0) bomnum, 1 enablesw, 0 minleadtime
       ,1440 * 365 * 100 maxleadtime, 0 yieldqty, 1 splitfactor
       ,v_init_eff_date nonewsupplydate, ' ' finishcal, ' ' leadtimecal
       ,' ' workscope, 0 lotsizesenabledsw
from sku s, bom b, loc l, item i, udt_plant_status ps,
    (select item, loc, productionmethod 
       from productionmethod 
      where productionmethod = 'REP'
    ) p,
    (select item, loc, 'REP' productionmethod, yield 
       from udt_yield 
      where productionmethod = 'REP' and maxcap > 0 and yield > 0
    ) t
where s.loc = l.loc
and l.loc_type in ( 2, 4)
and ps.loc=l.loc
and ps.res='REPAIR'
and ps.status=1
and s.enablesw = 1 
and b.subord = i.item
and i.u_stock = 'B'
and b.bomnum = 1
and b.item = t.item
and b.loc = t.loc
and b.item = s.item
and b.loc = s.loc 
and b.item = p.item(+)
and b.loc = p.loc(+)
and p.item is null;

commit;

/*************************************************************
** Part 7: Create Production Step Records
*************************************************************/

insert into igpmgr.intins_productionstep 
(  integration_jobid, item, loc, productionmethod, stepnum, nextsteptiming
   ,fixedresreq, prodrate, proddur, prodoffset, enablesw, spread, maxstartdur
   ,eff, res, descr, loadoffsetdur, prodcost, qtyuom, setup, inusebeforesw
   ,prodfamily
)
select 'U_23_PRD_REPAIR_PART7'
       ,pm.item, pm.loc, pm.productionmethod
       , case 
           when substr(r.res, 1, 6) = 'REPCAP' then 1 
           else 2 
        end stepnum
       ,3 nextsteptiming, 0 fixedresreq, u.rate prodrate, 0 proddur
       ,0 prodoffset, 1 enablesw, 0 spread, 0 maxstartdur
       ,v_init_eff_date eff, r.res, ' ' descr, 0 loadoffsetdur ,0 prodcost
       , case 
           when substr(r.res, 1, 6) = 'REPCAP' then 28 
           else 18 
         end qtyuom
       ,' ' setup, 0 inusebeforesw, ' ' prodfamily 
from productionmethod pm
    ,productionstep ps
    ,res r
    ,item i
    ,udt_plant_status pstatus,

        (select item, loc, round(((maxcap/efficiency)/maxdaysperwk)/maxhrsperday, 0) rate
        from udt_yield
        where productionmethod = 'REP'
        and maxcap > 0
        and yield > 0) u

where pm.item = i.item
and (r.res = 'REPCST'||'@'||pm.loc  or r.res = 'REPCAP'||'@'||pm.loc)
and r.loc = pm.loc
and r.loc=pstatus.loc
and pstatus.res='REPAIR'
and pstatus.status=1
and r.enablesw = 1
and pm.enablesw = 1
and pm.item = u.item
and pm.loc = u.loc
and pm.item = ps.item(+)
and pm.loc = ps.loc(+)
and pm.productionmethod = ps.productionmethod(+)
and ps.item is null;

commit;

/*************************************************************
** Part 8: Create Production Yield Records
*************************************************************/

insert into igpmgr.intins_prodyield 
(integration_jobid, item, loc, productionmethod, eff, qtyuom, outputitem, yieldqty)
select 'U_23_PRD_REPAIR_PART8'
       ,p.item, p.loc, p.productionmethod, v_init_eff_date eff
       ,18 qtyuom, p.item outputitem, 1 yieldqty 
from productionyield y, productionmethod p
where p.item = y.item(+)
and p.loc = y.loc(+)
and p.productionmethod = y.productionmethod(+)
and y.item is null;

commit;

/*************************************************************
** Part 9: Create Cost records for Repair
*************************************************************/

insert into igpmgr.intins_cost 
( integration_jobid, cost, enablesw, cumulativesw, groupedsw
  , sharedsw, qtyuom, currencyuom, accumcal, maxqty
  , maxutilization
)
select distinct 'U_23_PRD_REPAIR_PART9'
    ,u.cost, 1 enablesw, 0 cumulativesw, 0 groupedsw, 0 sharedsw
    ,18 qtyuom, 11 currencyuom, ' '   accumcal, 0 maxqty, 0 maxutilization
from cost c, 

    (select 'LOCAL:RES:'||res||'-202' cost
    from res
    where subtype = 1
    and substr(res, 1, 6) = 'REPCST') u
    
where u.cost = c.cost(+)
and c.cost is null;

commit;

/*************************************************************
** Part 10: Create Production CostTier Records for Repair
*************************************************************/

insert into igpmgr.intins_costtier (integration_jobid, breakqty, category, value, eff, cost)

select distinct 'U_23_PRD_REPAIR_PART10', 
                0 breakqty, 303 category, q.unit_cost value , v_init_eff_date eff, c.cost  
from cost c, costtier t, 

    (select s.item, s.matcode, s.loc, s.productionmethod, s.stepnum, s.res, s.cost, nvl(u.unit_cost, 99) unit_cost
    from

        (select s.item, i.u_materialcode matcode, s.loc, s.productionmethod, s.stepnum, s.res, 'LOCAL:RES:REPCST@'||s.loc||'-202' cost
        from productionstep s, item i
        where s.productionmethod = 'REP'
        and s.stepnum = 2
        and s.item = i.item
        ) s,

        (select loc, matcode, process productionmethod, unit_cost
        from udt_cost_unit
        where process = 'REP'
        ) u
        
    where s.matcode = u.matcode(+)
    and s.loc = u.loc(+)
    and s.productionmethod = u.productionmethod(+)
    ) q

where c.cost = q.cost
and c.cost = t.cost(+)
and t.cost is null;

commit;

/*************************************************************
** Part 11: Create Production  ResCost Records for Repair
*************************************************************/

insert into igpmgr.intins_rescost 
  (integration_jobid, category, res, localcost, tieredcost)
select distinct  'U_23_PRD_REPAIR_PART11'
                 ,202 category, u.res, t.cost localcost, ' ' tieredcost
from rescost r, costtier t, 

    (select r.res, 'LOCAL:RES:'||r.res||'-202' cost
    from res r
    where r.subtype = 1) u

where t.cost = u.cost
and u.cost = r.localcost(+)
and r.localcost is null;

commit;

--must run u_29_prd_resconstraint or _wk

end;

/

--------------------------------------------------------
--  DDL for Procedure U_29_PRD_RESCONSTRAINT_WK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_29_PRD_RESCONSTRAINT_WK" as


begin

--create resource constraints for INS and REP in weekly periods  
--skuconstraint must be populated first

delete resconstraint where substr(res, 1, 6) in ('INSCAP', 'REPCAP');  

commit;

-- assign maximum capacity constraint  

insert into resconstraint (eff, policy, qty, dur, category, res, qtyuom, timeuom)

select u.eff, 1 policy, u.qty*5*1 qty, 1440*7*1 dur, u.category, u.res, 28 qtyuom, 0 timeuom  --need to factor not by 5 days per week
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

delete respenalty  where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

insert into respenalty (eff, rate, category, res, currencyuom, qtyuom, timeuom)

select  to_date('01/01/1970', 'MM/DD/YYYY') eff, 900 rate, 112 category, res, 11 currencyuom, 28 qtyuom, 0 timeuom
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

insert into respenalty (eff, rate, category, res, currencyuom, qtyuom, timeuom)

select  to_date('01/01/1970', 'MM/DD/YYYY') eff, 900 rate, 111 category, res, 11 currencyuom, 28 qtyuom, 0 timeuom
from res
where substr(res, 1, 6)  in ('INSCAP', 'REPCAP');

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_30_SRC_DAILY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_30_SRC_DAILY" as

begin

--sourcing for issues

scpomgr.u_8d_sourcing;

/******************************************************************
** Part 1: create one sourcing record for each exclusive TPM SKU  * 
*******************************************************************/
insert into intups_sourcing ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw, yieldfactor
                      ,supplyleadtime, costpercentage, supplytransfercost
                      ,nonewsupplydate, shipcal, ff_trigger_control
                      ,pullforwarddur, splitqty, loaddur, unloaddur, reviewcal
                      ,uselookaheadsw, convenientshipqty, convenientadjuppct
                      ,convenientoverridethreshold, roundingfactor, ordergroup
                      ,ordergroupmember, lotsizesenabledsw
                      ,convenientadjdownpct
                      )
select distinct 'U_30_SRC_DAILY_PART1', u.item, u.dest, u.source
      , 'TRUCK' transmode, v_init_eff_date eff
      ,1 factor, ' ' arrivcal, 0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw
      ,0 shrinkagefactor, 0 maxshipqty, ' ' abbr, 'ISS1EXCL' sourcing
      ,v_init_eff_date disc, 1440 * 365 * 100 maxleadtime, 0 minleadtime
      ,1 priority, 1 enablesw, 100 yieldfactor, 0 supplyleadtime
      ,100 costpercentage, 0 supplytransfercost, v_init_eff_date nonewsupplydate
      ,' ' shipcal, ''  ff_trigger_control, 0 pullforwarddur, 0 splitqty
      ,0 loaddur, 0 unloaddur, ' ' reviewcal, 1 uselookaheadsw
      ,0 convenientshipqty, 0 convenientadjuppct, 0 convenientoverridethreshold
      ,0 roundingfactor, ' ' ordergroup, ' ' ordergroupmember
      ,0 lotsizesenabledsw, 0 convenientadjdownpct
from sourcing c, sku ss, sku sd, 

            (select distinct g.item, g.loc dest, g.exclusive_loc source
            from udt_gidlimits_na g, loc l
            where g.exclusive_loc = l.loc
            and l.loc_type = 4
            and g.exclusive_loc is not null
            and g.de = 'E'
            
            union
            
            select distinct g.item, g.loc, g.mandatory_loc 
            from udt_gidlimits_na g, loc l
            where g.mandatory_loc = l.loc
            and l.loc_type = 2
            and g.mandatory_loc is not null
            ) u
    
where u.item = ss.item
and u.source = ss.loc
and u.item = sd.item
and u.dest = sd.loc
and u.item = c.item(+)
and u.dest = c.dest(+)
and c.item is null;

commit;

/*******************************************************************************
** Part 2: Find all possible sources within loc.u_max_dist nullu_max_srcs 
**         where udt_cost_transit matches source_pc and dest_pc
**     ==> This should Exclude exclusive TPM SKU's which where handled in Part 1.
**         Make sure that: Get all possible matches of Source Plants to each GLID
**           1) where it is not an exclusive or forbidded lanes
**           2) udt_cost_transist.distance <- loc.u_max_dist 
**           3) Number of sources ranked by cost < loc.u_max_src
*******************************************************************************/
--  First do the 5digit zip to 5 digit zip. because union takes too long
insert into igpmgr.intins_sourcing 
                    ( integration_jobid
                      ,item, dest, source, transmode, eff,     factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw,shrinkagefactor
                      ,maxshipqty, abbr, sourcing, disc, maxleadtime, minleadtime
                      ,priority, enablesw, yieldfactor, supplyleadtime
                      ,costpercentage, supplytransfercost, nonewsupplydate
                      ,shipcal, ff_trigger_control, pullforwarddur, splitqty
                      ,loaddur, unloaddur, reviewcal, uselookaheadsw
                      ,convenientshipqty, convenientadjuppct
                      ,convenientoverridethreshold, roundingfactor, ordergroup
                      ,ordergroupmember, lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART2'
      ,ranked_lanes.item, ranked_lanes.dest,ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      , 1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      , ''  ff_trigger_control, 0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /******************************************************************** 
     ** Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc
     ** ,max_dist, max_src, distance, rownum 
     *********************************************************************/
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
           over ( partition by all_lanes.item, all_lanes.dest 
                  order by cost_pallet, source asc
                 ) as rank
    from  
    /*********************************************************************
    ** Getting All Lanes: item, dest, dest_pc, source, source_pc max_dist
    ** ,max_src, dist and  cost(999 if null) 
    **********************************************************************/
    (select /*+ use_hash(lane_cost, lanes) parallel (lane_cost,4) parallel (lanes,4) */
            lanes.item, lanes.dest, lanes.dest_pc, lanes.source, lanes.source_pc
            ,lanes.u_max_dist, lanes.u_max_src, lane_cost.distance
            ,nvl(lane_cost.cost_pallet, 999) cost_pallet, lane_cost.direction
            ,lane_cost.u_equipment_type
        from
            /* Cost for the lanes from UDT_COST_TRANSIT */ 
            (select direction
                   ,u_equipment_type u_equipment_type
                   ,source_pc        source_pc
                   ,source_geo       source_geo
                   ,dest_pc          dest_pc
                   ,dest_geo         dest_geo
                   ,source_co
                   ,distance         distance
                   ,cost_pallet      cost_pallet 
             from udt_cost_transit
             order by direction, u_equipment_type, source_pc, dest_pc, source_geo, dest_geo
            )  lane_cost, 
             /***************************************************************
             ** Lanes based on matching the source for producitonyield and 
             ** dest for sku constraint. dest sku, max_dist, max_src, dest_pc
             ** ,source, source_pc 
             *****************************************************************/            
            (select /*+ use_hash(dest, source_sku, demand_group) parallel (dest,4)parallel (sku_source,4 ) */
                    ' ' direction
                   ,dest.item
                   ,dest.loc dest
                   ,dest.u_max_dist
                   ,dest.u_max_src
                   ,dest.dest_pc
                   ,dest.dest_geo
                   ,source_sku.loc source
                   ,source_sku.source_pc
                   ,source_sku.source_geo
                   ,case when dest.u_equipment_type='FB' then 'FB' 
                         else 'VN' 
                    end u_equipment_type
            
            from
                    /**********************************************************
                    ** Allowed Destinations (GLID) Based on SKUCONSTRAINT 
                    ** ( OR ACTUAL DEMAND) Sku, max _dist, max _src, Postal Code
                    ***********************************************************/
                    (select distinct sku.item
                                    ,i.u_materialcode matcode
                                    ,sku.loc
                                    ,l.u_max_dist
                                    ,l.u_max_src
                                    ,l.postalcode dest_pc
                                    ,l.u_equipment_type u_equipment_type
                                    ,l.u_3digitzip dest_geo
                    from skuconstraint sku
                        ,loc l
                        ,item i
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
                      and trim(l.postalcode ) is not null
                      and trim(l.u_3digitzip ) is not null
                    /* added by MAK */
                    and not exists ( select '1' from udt_gidlimits_na gl 
                                      where gl.loc  = sku.loc 
                                        and gl.item = sku.item 
                                        and gl.mandatory_loc is not null )  
                    ) dest,
                    /* Allowed Sources based on PRODUCITONYIELD (PLant).
                       sku, postalcode 
                       for the SOURCE SKU
                    */
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
                    union 
                    select sku.item
                          ,sku.loc
                          ,l1.postalcode source_pc
                          ,l1.u_3digitzip source_geo
                          ,ps.status flatbed_status
                    from sku sku
                        ,loc l1
                        ,item i1
                        ,udt_plant_status ps       
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item, dv.loc, max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction    = ' '
        and lanes.dest_pc          = lane_cost.dest_pc
        and lanes.source_pc        = lane_cost.source_pc
        and lanes.u_max_dist      <= lane_cost.distance
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank < ranked_lanes.u_max_src
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;
-- Next do the 3 digit zip to 3 digit zip
insert into igpmgr.intins_sourcing 
                     ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw
                      ,yieldfactor, supplyleadtime, costpercentage
                      ,supplytransfercost, nonewsupplydate, shipcal
                      ,ff_trigger_control, pullforwarddur, splitqty, loaddur
                      ,unloaddur, reviewcal, uselookaheadsw, convenientshipqty
                      ,convenientadjuppct, convenientoverridethreshold
                      ,roundingfactor, ordergroup, ordergroupmember
                      ,lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART2B'
      ,ranked_lanes.item, ranked_lanes.dest, ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      ,1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      ,''  ff_trigger_control,0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /***********************************************************************
     ** Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc
     ** ,max_dist, max_src, distance, rownum 
     ************************************************************************/
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
           over ( partition by all_lanes.item, all_lanes.dest 
                  order by cost_pallet, source asc
                 ) as rank
    from  
    /**************************************************************************
    ** Getting All Lanes: item, dest, dest_pc, source, source_pc max_dist
    ** , max_src, dist and  cost(999 if null)
    ***************************************************************************/
    (select /*+ use_hash(lane_cost, lanes) parallel (lane_cost,4) parallel (lanes,4) */
            lanes.item, lanes.dest, lanes.dest_pc, lanes.source
            ,lanes.source_pc, lanes.u_max_dist, lanes.u_max_src
            ,lane_cost.distance, nvl(lane_cost.cost_pallet, 999) cost_pallet
            ,lane_cost.direction, lane_cost.u_equipment_type
        from
            /* Cost for the lanes from UDT_COST_TRANSIT */ 
            (select direction
                   ,u_equipment_type u_equipment_type
                   ,source_pc        source_pc
                   ,source_geo       source_geo
                   ,dest_pc          dest_pc
                   ,dest_geo         dest_geo
                   ,source_co
                   ,distance         distance
                   ,cost_pallet      cost_pallet 
             from udt_cost_transit
             order by direction, u_equipment_type, source_pc, dest_pc, source_geo, dest_geo
            )  lane_cost, 
             /***********************************************************
             ** Lanes based on matching the source for producitonyield
             ** and dest for sku constraint. dest sku, max_dist, max_src
             ** ,dest_pc ,source, source_pc 
             *************************************************************/            
            (select /*+ use_hash(dest, source_sku, demand_group) parallel (dest,4)parallel (sku_source,4 ) */
                    ' ' direction
                   ,dest.item
                   ,dest.loc dest
                   ,dest.u_max_dist
                   ,dest.u_max_src
                   ,dest.dest_pc
                   ,dest.dest_geo
                   ,source_sku.loc source
                   ,source_sku.source_pc
                   ,source_sku.source_geo
                   ,case when dest.u_equipment_type='FB' then 'FB' 
                         else 'VN' 
                    end u_equipment_type
            
            from
                    /**********************************************************
                    ** Allowed Destinations (GLID) Based on SKUCONSTRAINT
                    ** ( OR ACTUAL DEMAND) Sku, max _dist, max _src, Postal Code
                    ***********************************************************/
                    (select distinct sku.item, i.u_materialcode matcode
                           ,sku.loc, l.u_max_dist, l.u_max_src
                           ,l.postalcode dest_pc
                           ,l.u_equipment_type u_equipment_type
                           ,l.u_3digitzip dest_geo
                    from skuconstraint sku
                        ,loc l
                        ,item i
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
                      and trim(l.postalcode ) is not null
                      and trim(l.u_3digitzip ) is not null
                    and not exists ( select '1' from udt_gidlimits_na gl 
                                      where gl.loc  = sku.loc 
                                        and gl.item = sku.item 
                                        and gl.mandatory_loc is not null )  
                    ) dest,
                    /***************************************************
                    ** Allowed Sources based on PRODUCITONYIELD (PLant).
                    ** sku, postalcode for the SOURCE SKU
                    ****************************************************/
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
                    union 
                    select sku.item
                          ,sku.loc
                          ,l1.postalcode source_pc
                          ,l1.u_3digitzip source_geo
                          ,ps.status flatbed_status
                    from sku sku
                        ,loc l1
                        ,item i1
                        ,udt_plant_status ps       
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item
                           ,dv.loc
                           ,max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction     = ' '
        and lanes.dest_geo          = lane_cost.dest_geo
        and lanes.source_geo        = lane_cost.source_geo
        and lanes.u_max_dist       <= lane_cost.distance
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank < ranked_lanes.u_max_src
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;

/*******************************************************************************
** Part 3: where no sourcing find closest loc_type = 2 location  ; less than 4k
**         Here, since I am looking for something not matched before
**===> I am doing this at the GeoCode level. If we want to do this at the 
**     5 digit zip code level, This code needs to be repeated at that level!!!!
*******************************************************************************/

insert into igpmgr.intins_sourcing 
                     ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw
                      ,yieldfactor, supplyleadtime, costpercentage
                      ,supplytransfercost, nonewsupplydate, shipcal
                      ,ff_trigger_control, pullforwarddur, splitqty, loaddur
                      ,unloaddur, reviewcal, uselookaheadsw, convenientshipqty
                      ,convenientadjuppct, convenientoverridethreshold
                      ,roundingfactor, ordergroup, ordergroupmember
                      ,lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART3'
      ,ranked_lanes.item, ranked_lanes.dest, ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      ,1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      ,''  ff_trigger_control, 0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /* Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc, max_dist, max_src, distance, rownum */
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
               over (partition by all_lanes.item, all_lanes.dest 
                       order by cost_pallet, source asc
                     ) as rank
    from  
    /* Geting All Lanes: item, dest, dest_pc, source, source_pc max_dist, max_src, dist and  cost(999 if null) */
    (select /*+ use_hash(lane_cost, lanes) parallel (lane_cost,4) parallel (lanes,4) */
            lanes.item, lanes.dest, lanes.dest_pc, lanes.source, lanes.source_pc
            ,lanes.u_max_dist, lanes.u_max_src, lane_cost.distance
            ,nvl(lane_cost.cost_pallet, 999) cost_pallet, lane_cost.direction
            ,lane_cost.u_equipment_type
        from
            /* Cost for the lanes from UDT_COST_TRANSIT */ 
            (select direction
                   ,u_equipment_type u_equipment_type
                   ,source_pc        source_pc
                   ,source_geo       source_geo
                   ,dest_pc          dest_pc
                   ,dest_geo         dest_geo
                   ,source_co
                   ,distance         distance
                   ,cost_pallet      cost_pallet 
             from udt_cost_transit
             order by direction, u_equipment_type, source_pc
                     ,dest_pc, source_geo, dest_geo
            )  lane_cost, 
             /* Lanes based on matching the source for producitonyield and dest for sku constraint. 
                 dest sku, max_dist, max_src, dest_pc , source, source_pc 
             */            
            (select /*+ use_hash(dest, source_sku, demand_group) parallel (dest,4)parallel (sku_source,4 ) */
                    ' ' direction
                   ,dest.item
                   ,dest.loc dest
                   ,dest.u_max_dist
                   ,dest.u_max_src
                   ,dest.dest_pc
                   ,dest.dest_geo
                   ,source_sku.loc source
                   ,source_sku.source_pc
                   ,source_sku.source_geo
                   ,case when dest.u_equipment_type='FB' then 'FB' 
                         else 'VN' 
                    end u_equipment_type
            
            from
                    /* Allowed Destinations (GLID) Based on SKUCONSTRAINT ( OR ACTUAL DEMAND)
                       Sku, max _dist, max _src, Postal Code
                    */
                    (select distinct sku.item, i.u_materialcode matcode
                           ,sku.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                           ,l.u_equipment_type u_equipment_type, l.u_3digitzip dest_geo
                    from skuconstraint sku, loc l, item i
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
                      and trim(l.postalcode ) is not null
                      and trim(l.u_3digitzip ) is not null
                    /* added by MAK */
                    and not exists ( select '1' from udt_gidlimits_na gl 
                                      where gl.loc  = sku.loc 
                                        and gl.item = sku.item 
                                        and gl.mandatory_loc is not null )  
                    ) dest,
                    /* Allowed Sources based on PRODUCITONYIELD (PLant).
                       sku, postalcode 
                       for the SOURCE SKU
                    */
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
                    union 
                    select sku.item
                          ,sku.loc
                          ,l1.postalcode source_pc
                          ,l1.u_3digitzip source_geo
                          ,ps.status flatbed_status
                    from sku sku
                        ,loc l1
                        ,item i1
                        ,udt_plant_status ps       
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item, dv.loc, max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction     = ' '
        and lanes.dest_geo          = lane_cost.dest_geo
        and lanes.source_geo        = lane_cost.source_geo
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank = 1
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
/* added by MAK */
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;

/*******************************************************************************
** Part 4: where LOC:U_RUNEW_CUST = 1 for GID find the closest 
**         MFG location (LOC_TYPE = 1) and assign as a single source for RUNEW.
*******************************************************************************/
insert into intins_sourcing ( integration_jobid
    ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)

select distinct 'U_30_SRC_DAILY_PART4'
    ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'ISS4MFG' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
    
from sourcing c, 

    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
    from  

    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
        from
                    
            (select distinct lpad(source_pc, 5, 0) source_pc, lpad(dest_pc, 5, 0) dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
            from udt_cost_transit  
            group by lpad(source_pc, 5, 0), lpad(dest_pc, 5, 0), source_co, dest_co
            )  pc, 
                        
            (select f.item, f.loc dest, f.u_max_dist, f.u_max_src, f.dest_pc, p.loc source, p.source_pc
            from

                    (select s.item, s.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                    from sku s, loc l
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.u_runew_cust = 1
                    and l.loc_type = 3
                    ) f,

                    (select s.item, s.loc, l.postalcode source_pc
                    from sku s, loc l, item i
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.loc_type = 1
                    and s.item = i.item
                    and i.u_stock = 'C'
                    ) p
                    
            where f.item = p.item 
            ) c
                    
        where c.dest_pc = pc.dest_pc(+)
        and c.source_pc = pc.source_pc(+) 
        
        ) u
        
   --where u.distance < u.u_max_dist
   
    ) u
    
where u.rank = 1
and u.item = c.item(+)
and u.dest = c.dest(+)
and c.item is null;

commit;

/*******************************************************************************
** Part 5: where U_RUNEW_CUST = 1 and forecast exists for other 
**         non-RUNEW items then allow sourcing to LOC_TYPE = 1 
**         where substitution logic can be used to satisfy demand 
**         with RUNEW proxy
*******************************************************************************/
insert into intins_sourcing ( integration_jobid
   ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)

select distinct 'U_30_SRC_DAILY_PART5'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'ISS5MFG' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
    
from 

    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
    from  

    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
        from
                    
            (select distinct lpad(source_pc, 5, 0) source_pc, lpad(dest_pc, 5, 0) dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
            from udt_cost_transit  
            group by lpad(source_pc, 5, 0), lpad(dest_pc, 5, 0), source_co, dest_co
            )  pc, 
                        
            (select f.item, f.loc dest, f.u_max_dist, f.u_max_src, f.dest_pc, p.loc source, p.source_pc
            from

                    (select k.item, k.loc, k.u_max_dist, k.u_max_src, k.dest_pc
                    from

                        (select c.item, c.dest, c.source
                        from sourcing c, loc l
                        where c.source = l.loc
                        and l.loc_type = 1
                        ) c,

                        (select distinct k.item, k.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                        from skuconstraint k, loc l, item i
                        where k.loc = l.loc
                        and l.u_area = 'NA'
                        and l.u_runew_cust = 1
                        and k.item <> '4055RUNEW'
                        and k.item = i.item
                        and i.u_stock = 'C'
                        ) k

                    where k.item = c.item(+)
                    and k.loc = c.dest(+)
                    and c.item is null
                    ) f,

                    (select s.item, s.loc, l.postalcode source_pc
                    from sku s, loc l, item i
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.loc_type = 1
                    and s.item = i.item
                    and i.u_stock = 'C'
                    ) p
                    
            where f.item = p.item 
            ) c
                    
        where c.dest_pc = pc.dest_pc(+)
        and c.source_pc = pc.source_pc(+) 
        
        ) u
        
   --where u.distance < u.u_max_dist
   
    ) u
    
where u.rank = 1;

commit;

/*******************************************************************************
** Part 6: collections
**         Find all possible sources within loc.u_max_dist & loc.u_max_srcs 
**         where udt_cost_transit matches source_pc and dest_pc or source_geo 
**         and dest_geo; 16k
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
  ,item, dest, source, transmode, eff, factor, arrivcal, majorshipqty, minorshipqty
  ,enabledyndepsw,shrinkagefactor, maxshipqty, abbr, sourcing, disc, maxleadtime
  ,minleadtime, priority, enablesw, yieldfactor, supplyleadtime, costpercentage
  ,supplytransfercost, nonewsupplydate, shipcal, ff_trigger_control
  ,pullforwarddur, splitqty, loaddur, unloaddur, reviewcal, uselookaheadsw
  ,convenientshipqty, convenientadjuppct, convenientoverridethreshold
  ,roundingfactor, ordergroup, ordergroupmember, lotsizesenabledsw
  ,convenientadjdownpct
)
select distinct 'U_30_SRC_DAILY_PART6'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'COLL0FIXED' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
from (select i.item item 
      ,l1.loc source
      ,l1.postalcode source_pc
      ,l2.loc dest
      ,l2.postalcode dest_pc
      ,l1.u_max_dist max_dist
      ,l1.u_max_src  max_src
from udt_fixed_coll coll, item i, loc l1, loc l2
where (  ( i.u_stock = 'A'
           and coll.loc=l1.loc
           and l1.loc_type in ('2','3','4')
          )
       or
         ( i.u_stock = 'B'
           and coll.loc=l1.loc
           and l1.loc_type in ('2','4')
         )
      )
  and coll.plant = l2.loc
  and l2.loc_type='2'
  and exists ( select '1'
                from skuconstraint skc 
               where skc.loc=l1.loc 
                 and skc.item=i.item
                 and skc.category=10
                 and skc.qty>0
             )
                        
    ) u
where exists (select 1 
              from sku sku1, sku sku2 
             where sku1.item=u.item 
               and sku1.loc=u.dest
               and sku2.item=u.item 
               and sku2.loc=u.source)
and not exists ( select 1
                   from sourcing src
                  where src.item=u.item
                    and src.source=u.source
                    and src.dest=u.dest
                );
commit;

--where unmatched try to find single lowest cost freight

--insert into sourcing (item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
--    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
--    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
--    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)
--
--select distinct u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
--    ' ' abbr, 'COLL1UNMATCHED' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
--    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
--    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
--    0 convenientadjdownpct
--from 
--
--    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
--                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
--    from 
--
--    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
--        from
--                    
--            (select distinct source_pc, dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
--            from udt_cost_transit  
--            group by source_pc, dest_pc, source_co, dest_co
--            )  pc, 
--            
--            (select distinct c.item, c.loc source, c.u_max_dist, c.u_max_src, c.source_pc, s.loc dest, s.dest_pc
--             from
--                                     
--                    (select distinct k.item, k.loc, l.u_max_dist, l.u_max_src, l.postalcode source_pc
--                    from skuconstraint k, loc l, item i, sourcing c
--                    where k.category = 10
--                    and k.loc = l.loc
--                    and l.loc_type = 3
--                    and k.item = i.item
--                    and i.u_stock = 'A'
--                    and k.qty > 0
--                    and k.item = c.item(+)
--                    and k.loc = c.source(+)
--                    and c.item is null
--                    ) c,
--                    
--                    (select s.item, s.loc, l.postalcode dest_pc
--                    from sku s, loc l, item i
--                    where s.loc = l.loc
--                    and l.loc_type = 2
--                    and s.item = i.item
--                    and i.u_stock = 'A'
--                    and s.item = i.item
--                    ) s
--                
--                where c.item = s.item
--                ) c
--                    
--        where c.dest_pc = pc.dest_pc(+)
--        and c.source_pc = pc.source_pc(+)
--
--        ) u
--        
--    --where u.distance < u.u_max_dist 
--    
--    ) u
--    
--
--where u.rank = 1;
--
--commit;

--if still unmatched use the zip code to default plant table

/*******************************************************************************
** Part 7: 
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
    ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct
)
select distinct 'U_30_SRC_DAILY_PART7'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'COLL3ZIPCODE' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
from 

    (SELECT k.item, k.loc source, k.postalcode, z.loc dest, k.qty
         FROM sourcing c, udt_default_zip z, sku s,
         
              (  SELECT DISTINCT k.item, k.loc, lpad(l.postalcode, 5, 0) postalcode, SUM (qty) qty
                   FROM skuconstraint k, item i, loc l
                  WHERE     k.category = 10
                        AND k.item = i.item
                        AND i.u_stock = 'A'
                        AND k.loc = l.loc
                        AND l.loc_type = 3
               GROUP BY k.item, k.loc, l.postalcode
                 HAVING SUM (qty) > 0
                 ) k
                 
        WHERE k.item = c.item(+) 
        AND k.loc = c.source(+)
        and k.postalcode = lpad(z.postalcode, 5, 0)
        and k.item = s.item
        and z.loc = s.loc 
        AND c.item IS NULL
    ) u;

commit;

/*******************************************************************************
** Part 8: TPM relocations (modified 06/19/2015)
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
   ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct
)
with 
source_skus ( source,  postal_code, item, stocktype)
 as
  ( select l.loc source, lpad(l.postalcode,5,0) postalcode, i.item, ps.u_stock
  from scpomgr.loc l, scpomgr.udt_plant_status ps, item i, sku sku
     where l.loc_type in ('2','4')
       and l.u_area='NA'
       and l.loc=ps.loc
       and (ps.res like '%RUSOURCE' or ps.res like '%ARSOURCE')
       and ps.status=1
       and ps.u_materialcode=i.u_materialcode
       and ps.u_stock in ('B','C')
       and ps.u_stock=i.u_stock
       and sku.item=i.item
       and sku.loc=l.loc
   ),
dest_skus ( dest,  postal_code,  item, max_dist, max_src, stocktype)
 as  
  ( select l.loc, lpad(l.postalcode,5,0) postalcode, i.item, l.u_max_dist, l.u_max_src, ps.u_stock
  from scpomgr.loc l, scpomgr.udt_plant_status ps, item i, sku sku
     where l.loc_type in ('2','4')
       and l.u_area='NA'
       and l.loc=ps.loc
       and (ps.res like '%RUDEST' or ps.res like '%ARDEST')
       and ps.status=1
       and ps.u_materialcode=i.u_materialcode
       and ps.u_stock in ('B','C')
       and ps.u_stock=i.u_stock
       and sku.item=i.item
       and sku.loc=l.loc
),
lanes (source, dest, item, max_src, cost_pallet)
   as   
   (  
  select src.source, dest.dest, src.item, dest.max_src, max(ct.cost_pallet)
   from source_skus src, dest_skus dest, udt_cost_transit ct
  where src.source <> dest.dest
    and src.item=dest.item
    and src.stocktype=dest.stocktype
    and lpad(src.postal_code,5,0)  = lpad(ct.source_pc,5,0)
    and lpad(dest.postal_code,5,0) = lpad(ct.dest_pc,5,0)
    having max(ct.distance) < 800 -- dest.max_dist
      group by src.source, dest.dest, src.item, dest.max_src
 ),
ranked_lanes ( source, dest, item, max_src, rank)
  as 
   (
 select lane.source, lane.dest, lane.item, lane.max_src
 ,row_number() over (partition by lane.item, lane.dest order by lane.cost_pallet, lane.source asc) as rank
 from lanes lane
)
select distinct 'U_30_SRC_DAILY_PART8' 
   ,rl.item, rl.dest, rl.source, 'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal, 0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'TPM_RELOC' sourcing, v_init_eff_date disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,  v_init_eff_date nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
   from ranked_lanes rl
   where rl.rank <= rl.max_src
   order by rl.dest, rl.item;
      
commit;

--insert into sourcing (item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
--    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
--    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
--    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)
--
--select distinct u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
--    ' ' abbr, 'TPM_RELOC' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
--    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
--    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
--    0 convenientadjdownpct
--from 
--
--(select t.item, t.matcode, t.source, p.dest
--from 
--
--    (select s.item, s.loc source, r.dest, r.matcode
--    from sku s, item i, udt_tpm_relocation_na r
--    where s.loc = r.source 
--    and s.item = i.item
--    and i.u_materialcode = r.matcode
--    ) t,
--
--    (
--    select s.item, s.loc dest, r.matcode, r.source
--    from udt_tpm_relocation_na r, loc l,
--
--        (select distinct s.item, s.loc, i.u_materialcode
--        from sku s, item i, productionmethod p
--        where s.item = i.item
--        and s.item = p.item
--        and s.loc = p.loc
--        ) s
--
--    where r.dest = l.loc
--    and l.loc_type in (2, 4)
--    and r.dest = s.loc
--    and r.matcode = s.u_materialcode
--    ) p
--
--where t.item = p.item
--and t.source = p.source
--and t.dest = p.dest
--) u;
--
--commit;

/*******************************************************************************
** Part 9: Update Sourcing Min LeadTime
*******************************************************************************/
declare
  cursor cur_selected is
    select c.item, c.dest, c.source, c.sourcing, t.transittime,
    case when t.transittime < 1 then 0 else round(t.transittime, 0)*1440 end transittime_new
    from sourcing c, u_42_src_costs t
    where c.item = t.item
    and c.dest = t.dest
    and c.source = t.source 
for update of c.minleadtime;

begin
  for cur_record in cur_selected loop
  
    update sourcing
    set minleadtime = cur_record.transittime_new
    where current of cur_selected;
    
  end loop;
  commit;
end;

/*******************************************************************************
** Part 10: Add Sourcing Draw Records
*******************************************************************************/
insert into igpmgr.intins_sourcingdraw 
( integration_jobid, sourcing, eff, item, dest, source, drawqty, qtyuom)
select 'U_30_SRC_DAILY_PART10'
       ,c.sourcing, v_init_eff_date eff, c.item, c.dest, c.source
       ,1 drawqty, 18 qtyuom 
from sourcing c, sourcingdraw d
where c.item = d.item(+)
and c.dest = d.dest(+)
and c.source = d.source(+)
and c.sourcing = d.sourcing(+)
and d.item is null;

commit;

/*******************************************************************************
** Part 11: Add Sourcing Yield Records
*******************************************************************************/
insert into igpmgr.intins_sourcingyield 
( integration_jobid, sourcing, eff, item, dest, source, yieldqty, qtyuom)
select 'U_30_SRC_DAILY_PART11'
       ,c.sourcing, v_init_eff_date eff, c.item, c.dest, c.source
       ,1 yieldqty, 18 qtyuom 
from sourcing c, sourcingyield d
where c.item = d.item(+)
and c.dest = d.dest(+)
and c.source = d.source(+)
and c.sourcing = d.sourcing(+)
and d.item is null;

commit;

/*******************************************************************************
** Part 12: Add Res Records
*******************************************************************************/
insert into igpmgr.intins_res 
(integration_jobid, loc, type,     res,    cal,  cost,     descr,  avgskuchg
  ,avgfamilychg,  avgskuchgcost,  avgfamilychgcost,     levelloadsw,     
    levelseqnum,  criticalitem, checkmaxcap,  unitpenalty,  adjfactor,  source,  enablesw,  subtype,   qtyuom,   currencyuom,     productionfamilychgoveropt
)
select distinct 'U_30_SRC_DAILY_PART12'
   ,u.dest loc, 5 type,     u.res,     ' '  cal,     0 cost,     ' '  descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' '  criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,  u.source,     1 enablesw,     6 subtype,     18 qtyuom,     11 currencyuom,     0 productionfamilychgoveropt
from res r,

    (select distinct c.source, c.dest , c.source||'->'||c.dest res from sourcing c
    ) u

where u.res = r.res(+)
and r.res is null;

commit;

/*******************************************************************************
** Part 13: Add SourcingRequirement Records
*******************************************************************************/
insert into igpmgr.intins_sourcingreq
( integration_jobid, stepnum,     nextsteptiming,     rate,     leadtime,     offset,     enablesw,     sourcing,     eff,     res,     item,     dest,     source,     qtyuom
)

select 'U_30_SRC_DAILY_PART13'
       ,1 stepnum,     3 nextsteptiming,     1 rate,     0 leadtime,     0 offset,     1 enablesw,     u.sourcing,     to_date('01/01/1970', 'MM/DD/YYYY') eff,     u.res,     u.item,     u.dest,     u.source,     18 qtyuom
from sourcingrequirement r, 

    (select c.item, c.dest, c.source, c.sourcing, c.source||'->'||c.dest res from sourcing c
    ) u
    
where u.item = r.item(+)
and u.dest = r.dest(+)
and u.source = r.source(+)
and u.sourcing = r.sourcing(+)
and r.item is null;

commit;

/*******************************************************************************
** Part 14: Add Cost Records
*******************************************************************************/
insert into igpmgr.intins_cost 
( integration_jobid, cost,  enablesw,   cumulativesw,  groupedsw,  sharedsw
  ,  qtyuom,  currencyuom,   accumcal,  maxqty,     maxutilization
)
select distinct 'U_30_SRC_DAILY_PART14'
    ,'LOCAL:RES:'||u.res||'-202' cost,     1 enablesw,     0 cumulativesw
    ,     0 groupedsw,     0 sharedsw,     18 qtyuom,     11 currencyuom
    ,    ' '   accumcal,     0 maxqty,     0 maxutilization
from cost c, 

    (select c.item, c.dest, c.source, c.sourcing, c.source||'->'||c.dest res, 'LOCAL:RES:'||c.source||'->'||c.dest||'-202' cost  from sourcing c
    ) u
    
where u.cost = c.cost(+)
and c.cost is null;

commit;

/*******************************************************************************
** Part 15: Now insert costtier records for 5 digit lanes 
*******************************************************************************/
insert into igpmgr.intins_costtier 
(integration_jobid, breakqty, category, value, eff, cost)
    select distinct 'U_30_SRC_DAILY_PART15'
      ,0 breakqty
      ,303 category
      ,lane_5zip_costed.value
      ,v_init_eff_date eff
      ,lane_5zip_costed.cost
    from costtier costtier
      , cost cost
      , (select distinct lane_5zip.source source
          ,lane_5zip.dest dest
          ,'LOCAL:RES:'
            ||lane_5zip.source
            ||'->'
            ||lane_5zip.dest
            ||'-202' cost
          ,nvl(round(tranit_cost.cost_pallet/480, 3), 10) value
        from udt_cost_transit tranit_cost
          , (select distinct src.source
              ,src.dest
              ,ls.postalcode source_pc
              ,ld.postalcode dest_pc
              ,case
                    when ld.u_equipment_type = 'FB'
                    then 'FB'
                    else 'VN'
                end u_equipment_type
            from sourcing src
              , loc ls
              , loc ld
            where src.source = ls.loc
                and src.dest = ld.loc
            ) lane_5zip
        where tranit_cost.direction(+)=' '
            and tranit_cost.u_equipment_type(+)=lane_5zip.u_equipment_type
            and lane_5zip.dest_pc = tranit_cost.dest_pc(+)
            and lane_5zip.source_pc = tranit_cost.source_pc(+)
        order by source
          , dest
        ) lane_5zip_costed
    where cost.cost = lane_5zip_costed.cost
      and lane_5zip_costed.cost = costtier.cost(+)
      and costtier.cost is null;

commit;


/**********************************************************
** Part 16: Now insert costtier records for 3 digit lanes 
**          where the 5 digit lanes were defaulted 
**          or have a higher cost
***********************************************************/
insert into intups_costtier 
(integration_jobid, breakqty, category, value, eff, cost)
select distinct 'U_30_SRC_DAILY_PART16'
          ,0 breakqty
          ,303 category
          ,lane_3zip_costed.value
          ,v_init_eff_date eff
          ,lane_3zip_costed.cost
from costtier costtier, cost cost, 
    (select distinct lane_3zip.source source
             ,lane_3zip.dest dest
             ,'LOCAL:RES:'||lane_3zip.source||'->'||lane_3zip.dest||'-202' cost
             ,nvl(round(tranit_cost.cost_pallet/480, 3), 10) value
      from udt_cost_transit tranit_cost, 
        ( select distinct src.source
                   ,src.dest
                   ,ls.u_3digitzip source_geo
                   ,ld.u_3digitzip dest_geo
                   ,case 
                      when ld.u_equipment_type = 'FB' then 'FB'
                      else 'VN'
                    end u_equipment_type
           from sourcing src, loc ls, loc ld 
          where src.source = ls.loc
            and src.dest = ld.loc
          ) lane_3zip        
    where tranit_cost.direction(+)=' '
      and lane_3zip.u_equipment_type = tranit_cost.u_equipment_type(+)
      and lane_3zip.source_geo = tranit_cost.source_geo(+)
      and lane_3zip.dest_geo   = tranit_cost.dest_geo(+)
    order by source, dest
    ) lane_3zip_costed
    
where cost.cost = lane_3zip_costed.cost
and lane_3zip_costed.cost = costtier.cost(+)
and costtier.value >= 10;

/**********************************************************
** Part 17: Now Populate teh ResCost table
***********************************************************/
insert into  intups_rescost 
(integration_jobid, category, res, localcost, tieredcost)
select distinct 'U_30_SRC_DAILY_PART17'
      ,202 category, u.res, u.cost localcost, ' ' tieredcost
from rescost r, costtier t, 

    (select distinct c.dest
  , c.source
  , c.source
    ||'->'
    ||c.dest res
  , 'LOCAL:RES:'
    ||c.source
    ||'->'
    ||c.dest
    ||'-202' cost
from sourcing c
) u
    
where u.cost = t.cost
and u.cost = r.localcost(+)
and r.localcost is null;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_60_PST_STOREMETRICS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_60_PST_STOREMETRICS" as

begin

execute immediate 'truncate table udt_skumetric_wk';

insert into udt_skumetric_wk

select *  
from skumetric;

commit;

execute immediate 'truncate table udt_sourcingmetric_wk';

insert into udt_sourcingmetric_wk

select *  
from sourcingmetric;

commit;

execute immediate 'truncate table udt_productionmetric_wk';

insert into udt_productionmetric_wk

select *  
from productionmetric;

commit;

--about five minutes; must run this before running u_60_pst_validation

--execute immediate 'truncate table tmp_resmetric';
--
--insert into tmp_resmetric  
--
--select *  
--from resmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_skumetric';
--
--insert into tmp_skumetric 
--
--select *  
--from skumetric;
--
--commit;
--
--execute immediate 'truncate table tmp_productionmetric';
--
--insert into tmp_productionmetric 
--
--select *  
--from productionmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_productionresmetric';
--
--insert into  tmp_productionresmetric  
--
--select *  
--from productionresmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_sourcingmetric';
--
--insert into tmp_sourcingmetric  
--
--select *  
--from sourcingmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_sourcingresmetric';
--
--insert into tmp_sourcingresmetric  
--
--select *  
--from sourcingresmetric;
--
--commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_65_PST_REPLENISHMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_65_PST_REPLENISHMENTS" as

begin

--about a minute

execute immediate 'truncate table planarriv';

insert into planarriv (item, dest, source, sourcing,   transmode, firmplansw, needarrivdate,  schedarrivdate,     needshipdate,     
    schedshipdate,     qty,  expdate, shrinkagefactor,   transname,   action,  actiondate, actionallowedsw, actionqty, reviseddate,        
    availtoshipdate, substqty,  ff_trigger_control, headerseqnum,  covdurscheddate,   departuredate,     deliverydate, orderplacedate,  supporderqty,     revisedexpdate,     nonignorableqty, u_admindate, u_z1banum, u_custorderid, u_sales_document, u_ship_condition, seqnum)

select item, dest, source, sourcing,   transmode, 0 firmplansw,     arrivdate needarrivdate,     arrivdate schedarrivdate,     shipdate needshipdate,     
    shipdate schedshipdate,     qty,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      0 shrinkagefactor,     ' ' transname,     
    0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,        
    shipdate availtoshipdate,     0 substqty,      '' ff_trigger_control,     0 headerseqnum,     TO_DATE('01/01/1970','MM/DD/YYYY') covdurscheddate,     
    shipdate departuredate,     arrivdate deliverydate,     TO_DATE('01/01/1970','MM/DD/YYYY') orderplacedate,     0 supporderqty,     
    TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 nonignorableqty,         TO_DATE('01/01/1970','MM/DD/YYYY')  u_admindate, ' ' u_z1banum, ' ' u_custorderid, ' ' u_sales_document, ' ' u_ship_condition,
    row_number()
              over (partition by item, dest order by item, dest ) as seqnum
from 

    (select t.item, t.dest, t.source, t.shipdate, t.arrivdate, t.sourcing, t.transmode, t.res, t.dur, t.qty, t.category, t.descr
    from

        (select t.item, t.dest, t.source, t.eff shipdate, t.eff+(c.minleadtime/1440) arrivdate, t.sourcing, 'TRUCK' transmode, tt.res, t.dur, t.value qty, t.category, m.descr
        from sourcingmetric t, metriccategory m, sourcing c, res r, sourcingrequirement tt
        where t.category = m.category 
        and t.category in (417)
        and t.item = c.item
        and t.dest = c.dest 
        and t.source = c.source
        and t.sourcing = c.sourcing 
        and t.item = tt.item
        and t.dest = tt.dest
        and t.source = tt.source
        and t.sourcing = tt.sourcing
        and r.res = tt.res
        and r.type = 5
        and t.value > 0
        ) t,
            
        (select distinct k.eff, t.item, k.res, t.source, t.dest, t.sourcing, qty mininflow
        from resconstraint k, res r, sourcingrequirement t
        where k.res = r.res
        and r.type = 5
        and r.res = t.res
        and t.sourcing = 'DELIVERY'
        and k.qty > 0 
        ) k
        
    where t.item = k.item(+)
    and t.source = k.source(+)
    and t.dest = k.dest(+)
    and t.arrivdate = k.eff(+)
    and t.res = k.res(+)  
    and k.source is null
    );    

commit;

declare
  cursor cur_selected is
        SELECT c.item, c.loc, p.source, p.schedshipdate, p.schedarrivdate, c.qty, 
            case when m.item is not null then 'MULTIPLE' else c.orderid end orderid
        from custorder c, loc l, planarriv p,
        
            (select distinct c.item, loc, shipdate, sum(qty) co_totqty, count(*) cnt
            from custorder c, item i
            where c.item = i.item
            and i.u_stock = 'C'
            group by c.item, loc, shipdate
            having count(*) > 1
            ) m
        
        where c.loc = l.loc
        and l.loc_type = 3 
        and c.item = p.item
        and c.loc = p.dest
        and c.shipdate = p.schedarrivdate 
        and p.qty > 0 
        and c.item = m.item(+)
        and c.loc = m.loc(+)
        and c.shipdate = m.shipdate(+) 
    for update of p.u_custorderid;
begin
  for cur_record in cur_selected loop
  
    update planarriv
    set u_custorderid = cur_record.orderid
    where current of cur_selected;
    
  end loop;
  commit;
end;

update planarriv set u_admindate = schedshipdate-1;

commit;

--create separate planned arrivals where multiple customer orders exist with same item / GID / ship date

insert into planarriv (item, dest, source, sourcing,   transmode, u_custorderid, firmplansw, needarrivdate,  schedarrivdate,     needshipdate,     
    schedshipdate,     qty,  expdate, shrinkagefactor,   transname,   action,  actiondate, actionallowedsw, actionqty, reviseddate,        
    availtoshipdate, substqty,  ff_trigger_control, headerseqnum,  covdurscheddate,   departuredate,     deliverydate, orderplacedate,  supporderqty,     revisedexpdate,     nonignorableqty, seqnum)

select item, dest, source, sourcing,   transmode, orderid u_custorderid, 0 firmplansw,     schedarrivdate needarrivdate,     schedarrivdate,     schedshipdate needshipdate,     
    schedshipdate,   co_qty qty,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      0 shrinkagefactor,     ' ' transname,     
    0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,        
    schedshipdate availtoshipdate,     0 substqty,      '' ff_trigger_control,     0 headerseqnum,     TO_DATE('01/01/1970','MM/DD/YYYY') covdurscheddate,     
    schedshipdate departuredate,     schedarrivdate deliverydate,     TO_DATE('01/01/1970','MM/DD/YYYY') orderplacedate,     0 supporderqty,     
    TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 nonignorableqty,         
    row_number()
              over (partition by 1 order by item, dest )+(select max(seqnum) from planarriv) as seqnum
from 
              
    (select p.item, p.dest, p.source, p.sourcing, p.transmode, p.schedshipdate, p.schedarrivdate, p.pa_qty, c.co_totqty, c.cnt, co.orderid, p.u_custorderid, co.qty co_qty
    from custorder co,

        (select distinct item, dest, source, sourcing, transmode, schedshipdate, schedarrivdate, u_custorderid, sum(qty) pa_qty, count(*) cnt
        from planarriv
        group by item, dest, source, sourcing, transmode, schedshipdate, schedarrivdate, u_custorderid) p, 

        (select distinct c.item, loc, shipdate, sum(qty) co_totqty, count(*) cnt
        from custorder c, item i
        where c.item = i.item
        and i.u_stock = 'C'
        group by c.item, loc, shipdate
        having count(*) > 1) c

    where p.item = c.item
    and p.dest = c.loc
    and c.shipdate = p.schedarrivdate
    and c.item = co.item
    and c.loc = co.loc 
    and c.shipdate = co.shipdate
    );
    
commit;

delete planarriv where u_custorderid = 'MULTIPLE';

commit;

execute immediate 'truncate table planorder';

insert into planorder (item, loc, scheddate,   qty,  needdate,  firmplansw, recschedrcptsopt,   productionmethod,  startdate,  expdate,  headerseqnum,  action,   actiondate,  actionallowedsw,  actionqty,   reviseddate,     
    substqty,  ff_trigger_control, covdurscheddate, editsw, revisedexpdate,  primaryseqnum,  coprodprimaryitem, coprodordertype, seqnum)

select item, loc, eff scheddate,     qty,     eff needdate,     1 firmplansw,     1 recschedrcptsopt,   productionmethod,     eff startdate,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      
    0 headerseqnum,     0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,     
    0 substqty,      '' ff_trigger_control,     eff covdurscheddate,     0 editsw,     TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 primaryseqnum,     ' ' coprodprimaryitem,     0 coprodordertype, 
    row_number()
              over (partition by item, loc order by item, loc ) as seqnum     
from
    (select c.eff, y.outputitem item, c.loc, c.productionmethod, c.category, m.descr, round(c.value*y.yieldqty, 5) qty
    FROM productionmetric c, metriccategory m, productionyield y
    where c.category = m.category
    and c.category = 417
    and c.value > 0 
    and c.item = y.item
    and c.loc =  y.loc
    and c.productionmethod = y.productionmethod
    );
    
commit;

delete schedrcpts where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 3);

commit;

insert into schedrcpts (item, loc, scheddate,  qty,   qtyreceived, lastcompletedstep, pctcomplete, explodesw, actionallowedsw, reviseddate,  expdate,  startdate, action,  actiondate,     
    actionqty, ordernum, seqnum,   ff_trigger_control,  productionmethod,  sourceopt,  revisedexpdate)

select u.item, u.loc,  u.eff scheddate,     u.qty,     0 qtyreceived,     0 lastcompletedstep,     0 pctcomplete,     0 explodesw,     0 actionallowedsw,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,     
    TO_DATE('01/01/1970','MM/DD/YYYY') expdate,     eff startdate,     0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     
    0 actionqty,     0 ordernum,     0 seqnum,  ''    ff_trigger_control,     ' ' productionmethod,     1 sourceopt,     TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate
from schedrcpts r,

    (select item, loc, eff, qty
    from skuconstraint
    where category = 10
    ) u
    
where u.item = r.item(+)
and u.loc = r.loc(+)
and u.eff = r.scheddate(+)
and r.item is null
and u.qty > 0;

commit;

/*
delete custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2);

insert into custorder (item, loc, shipdate, dfuloc,    status,    fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,  margin,     
    maxlatedur,  promiseddate,   revenue,   headerextref,   lineitemextref,   arrivtranszone,     maxearlydur,  lifecyclestatus,   arrivtransmode,     
    arrivleadtime,  promisedqty,     shipcompletesw,     cost,  unitprice,   orderlineitem,    project,     substlevel,  substoperator,   shipsw,  firmsw,         
    cust,    supersedesw,   ff_trigger_control,  priorityseqnum,  atpexcludesw,  ordertype,  fcsttype,    workscope,    dmdunit,    dmdgroup,    overridefcsttypesw,     
    u_sales_document,    u_ship_condition,   u_dmdgroup_code, orderseqnum, orderid)

select u.subord item, u.loc, eff shipdate, ' ' dfuloc,    1 status,    1 fcstsw,     qty,     0 reservation,     TO_DATE('01/01/1970','MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     
    0 maxlatedur,     TO_DATE('01/01/1970','MM/DD/YYYY') promiseddate,     -1 revenue,     ' ' headerextref,     ' ' lineitemextref,     ' ' arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,     ' ' arrivtransmode,     
    0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,     ' ' project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,         
    ' ' cust,     0 supersedesw,     '' ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,     ' ' workscope,     ' ' dmdunit,     ' ' dmdgroup,     1 overridefcsttypesw,     
    '' u_sales_document,     '' u_ship_condition,     '' u_dmdgroup_code, 
        (row_number()
                over (partition by 1 order by u.subord, u.loc, u.eff ))+10000000 as orderseqnum, 
        row_number()
              over (partition by 1 order by u.subord, u.loc, u.eff ) as orderid  --subord, loc, eff
from sku s,

    (select distinct p.eff, b.subord, p.loc, p.productionmethod, sum(p.value) value, b.drawqty, round(sum(p.value*b.drawqty), 2) qty
    from productionmetric p, metriccategory c, bom b
    where p.category = c.category
    and p.category = 417 
    and p.item = b.item
    and substr(b.subord, -2) = 'AI'
    and p.value > 0
    group by p.eff, b.subord, p.loc, p.productionmethod, b.drawqty
    ) u
    
where s.item = u.subord
and s.loc = u.loc;
    
commit;

*/

update skudemandparam
set fcstadjrule = 2
where item||loc in (select item||loc from custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2));

commit;

update skudemandparam
set custorderdur = 1440*14
where item||loc in (select item||loc from custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2));

commit;

--load depdmdstatic records to consume A stock at service centers

execute immediate 'truncate table depdmdstatic';

insert into depdmdstatic (item,     loc,   dur,  qty,   firmsw,     bomnum,  parentexpdate,  calcpriority,  scheddate, schedstatus,  schedqty,     
    parentscheddate,  parentseqnum,   supersedesw,  startdate,  parent,  parentordertype,  seqnum,  parentstartdate,   expdate,     earliestneeddate,   parentordernum)

select item,     loc,   dur,  qty,     0 firmsw,     bomnum,     to_date('01/01/1970', 'MM/DD/YYYY') parentexpdate,     0 calcpriority,     eff scheddate,     0 schedstatus,     qty schedqty,     
    eff parentscheddate,     0 parentseqnum,     0 supersedesw,     eff startdate,  parent,     6 parentordertype,     0 seqnum,     eff parentstartdate,     to_date('01/01/1970', 'MM/DD/YYYY')  expdate,     
    eff earliestneeddate,     0 parentordernum
from 

(select distinct eff, dur, item parent, subord item, loc, max(bomnum) bomnum, sum(qty) qty
from

    (select m.eff, m.dur, m.item, b.subord, m.loc, m.productionmethod, b.bomnum, b.drawqty, m.value, round(b.drawqty*m.value, 2) qty 
    from productionmetric m, bom b, productionmethod p, item i
    where m.category = 417
    and m.item = p.item
    and m.loc = p.loc
    and m.productionmethod = p.productionmethod
    and b.item = p.item
    and b.loc = p.loc
    and b.bomnum = p.bomnum
    and b.subord = i.item
    and i.u_stock in ( 'A', 'B') --and b.subord = '3AI' and m.loc = 'ES1J' and trunc(m.eff) = to_date('05/06/2014', 'MM/DD/YYYY')
    and m.value > 0
    )
    
group by eff, subord, loc, item, dur
order by loc, subord, eff, item, dur);

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D" as

begin

u_8d_exceptions;

u_8d_igptables;

u_8d_sourcing;

u_8d_productionmethod;

u_8d_sku;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_DELETECOSTTABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_DELETECOSTTABLES" 
AS
begin
      
declare
  begin

loop
    delete from scpomgr.rescost where rownum < 25000;
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;
loop
    delete from scpomgr.costtier where rownum < 25000; 
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;

    loop
      delete from scpomgr.cost 
      where rownum < 25000
        and trim(cost) is not null; 
      exit when sql%rowcount < 24999;
      commit;
    end loop;
  end;  

loop
    delete from scpomgr.skucost where rownum < 25000;
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;
--


--loop
--    delete from scpomgr.res where rownum < 25000;
--    exit when sql%rowcount < 24999;
--    commit;
--end loop;
--commit;
--
--loop
--    delete from scpomgr.resconstraint where rownum < 25000;
--    exit when sql%rowcount < 24999;
--    commit;
--end loop;
--commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_EXCEPTIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_EXCEPTIONS" as

begin

update sku set oh = 0 where item||loc in 

    (select s.item||s.loc
    from sku s, loc l
    where s.loc = l.loc
    and l.loc_type = 1
    );

commit;

execute immediate 'truncate table optimizerskuexception';

execute immediate 'truncate table optimizersourcingexception';

execute immediate 'truncate table optimizerprodexception';

execute immediate 'truncate table optimizercostexception';

execute immediate 'truncate table optimizercostexception';

execute immediate 'truncate table optimizerresexception';

delete optimizerexception;

execute immediate 'truncate table optimizerlocmap';

execute immediate 'truncate table optimizerresmap';

execute immediate 'truncate table optimizerskumap';

execute immediate 'truncate table optimizersourcingmap';

execute immediate 'truncate table optimizerproductionmap';

execute immediate 'truncate table processsku';

execute immediate 'truncate table optimizerbasiscount';

execute immediate 'truncate table optimizerbasis';

commit;

delete resexception;

commit;

execute immediate 'truncate table skumetric';

execute immediate 'truncate table resmetric';

execute immediate 'truncate table productionmetric';

execute immediate 'truncate table productionresmetric';

execute immediate 'truncate table sourcingresmetric';

execute immediate 'truncate table sourcingmetric';

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_IGPTABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_IGPTABLES" as

begin

execute immediate 'truncate table igpmgr.interr_bom';

execute immediate 'truncate table igpmgr.interr_cal';

execute immediate 'truncate table igpmgr.interr_caldata';

execute immediate 'truncate table igpmgr.interr_cost';

execute immediate 'truncate table igpmgr.interr_costtier';

execute immediate 'truncate table igpmgr.interr_prodmethod';

execute immediate 'truncate table igpmgr.interr_productionstep';

execute immediate 'truncate table igpmgr.interr_res';

execute immediate 'truncate table igpmgr.interr_rescost';

execute immediate 'truncate table igpmgr.interr_sku';

execute immediate 'truncate table igpmgr.interr_skudemandparam';

execute immediate 'truncate table igpmgr.interr_skudeployparam';

execute immediate 'truncate table igpmgr.interr_skussparam';

execute immediate 'truncate table igpmgr.interr_skuplannparam';

execute immediate 'truncate table igpmgr.interr_sourcing';

execute immediate 'truncate table igpmgr.intins_sourcingmetric';

/* reset BOM Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_BOM','INTUPS_BOM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Cal Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_CAL','INTUPS_CAL')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Caldata Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_CALDATA','INTUPS_CALDATA')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Cost Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_COST','INTUPS_COST')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Costier Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_COSTTIER','INTUPS_COSTTIER')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;


/* reset DFUTOSKUFCST Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_DFUTOSKUFCST','INTUPS_DFUTOSKUFCST')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset PRODMETHOD Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_PRODMETHOD','INTUPS_PRODMETHOD')
     and ( ij.jobid = 'INT_JOB'
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset PRODSTEP Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_PRODUCTIONSTEP','INTUPS_PRODUCTIONSTEP')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset RES Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_RES','INTUPS_RES')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset RESCOST Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_RESCOST','INTUPS_RESCOST')
     and ( ij.jobid = 'INT_JOB'
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset SKU Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKU','INTUPS_SKU')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Demand Param Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUDEMANDPARAM','INTUPS_SKUDEMANDPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Deployment Param Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUDEPLOYPARAM','INTUPS_SKUDEPLOYPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU PLanning Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUPLANNPARAM','INTUPSKU_SKUPLANPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Saftey Stock Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUSSPARAM','INTUPSKU_SKUSSPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Sourcing Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SOURCING','INTUPD_SOURCING','INTUPS_SOURCING')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset Sourcing Metric Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in (  'INTINS_SOURCINGMETRIC'
                               ,'INTUPD_SOURCINGMETRIC'
                               ,'INTUPS_SOURCINGMETRIC'
                              )
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_PRODUCTIONMETHOD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_PRODUCTIONMETHOD" as

begin

execute immediate 'truncate table productionstep';

execute immediate 'truncate table productionyield';

execute immediate 'truncate table bom';

delete res where type = 4 and res <> ' ';

commit;

delete productionmethod;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_SKU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_SKU" as

--about 15 minutes

begin

execute immediate 'truncate table skuconstraint';

execute immediate 'truncate table storagerequirement';

delete res where type = 9 and res <> ' ';

execute immediate 'truncate table skuexception';

execute immediate 'truncate table skuprojstatic';

execute immediate 'truncate table skustatstatic';

execute immediate 'truncate table skudemandparam';

execute immediate 'truncate table skudeploymentparam';

execute immediate 'truncate table skusafetystockparam'; 

execute immediate 'truncate table skuplanningparam';

execute immediate 'truncate table skumetric';

execute immediate 'truncate table skupenalty';

execute immediate 'truncate table skuexternalfcst';

execute immediate 'truncate table dfutoskufcst';

delete custorder;

commit;

execute immediate 'truncate table vehicleloadline';

execute immediate 'truncate table dfutoskufcst';

execute immediate 'truncate table dfutosku';

delete sku;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8D_SOURCING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_SOURCING" as

--about 12 minutes, (line 35 almost all)

begin

execute immediate 'truncate table optimizersourcingexception';

execute immediate 'truncate table sourcingconstraint';

execute immediate 'truncate table sourcingcost';

execute immediate 'truncate table sourcingdraw';

execute immediate 'truncate table sourcingyield';

execute immediate 'truncate table sourcingleadtime';

execute immediate 'truncate table sourcingmetric';

execute immediate 'truncate table sourcingresmetric';

execute immediate 'truncate table sourcingpenalty';

execute immediate 'truncate table sourcingtarget';

execute immediate 'truncate table marginalpriceandslacksrcng';

execute immediate 'truncate table reducedcostsourcing';

execute immediate 'truncate table sourcingproj';

execute immediate 'truncate table sourcingrequirement';

--delete res where type = 5 and res <> ' ';

--commit;

delete sourcing;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_8S_METRICS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S_METRICS" as

Begin

--less than 1 minute

--step 1

    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC');
    
--do we do this???

  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PRODUCTIONMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_PRODUCTIONMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PRODUCTIONRESMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_SOURCINGMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGRESMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SKUMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_SKUMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RESMETRIC');

--step 2
-- Gather table stats with cascade true,incase you are manually gathering stats while the process was running
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);

-- Step 3
--Delete some of the  column stats for Process tables
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'PRODUCTIONMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'PRODUCTIONRESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SOURCINGMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SOURCINGRESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SKUMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'RESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');

--step 4
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC');

End;

/

--------------------------------------------------------
--  DDL for Procedure U_8S_OPTMAP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S_OPTMAP" as

Begin

--less than 1 minute

--step 1

    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSKUMAP');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSOURCINGMAP');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERRESMAP');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERPRODUCTIONMAP');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERLOCMAP');

    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASIS');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASISCOUNT');
    
--do we do this???

--  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'OPTIMIZERSKUMAP');
--  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'OPTIMIZERSOURCINGMAP');
--  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'OPTIMIZERRESMAP');
--  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'OPTIMIZERPRODUCTIONMAP');

--step 2
-- Gather table stats with cascade true,incase you are manually gathering stats while the process was running
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSKUMAP',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSOURCINGMAP',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERRESMAP',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERPRODUCTIONMAP',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERLOCMAP',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);

    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASIS',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASISCOUNT',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);

-- Step 3
--Delete some of the  column stats for Process tables
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERSKUMAP', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERSKUMAP', COLNAME => 'INSTANCEID', statown => 'scpomgr');

    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERSOURCINGMAP', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERSOURCINGMAP', COLNAME => 'INSTANCEID', statown => 'scpomgr');

    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERRESMAP', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERRESMAP', COLNAME => 'INSTANCEID', statown => 'scpomgr');


    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERPRODUCTIONMAP', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERPRODUCTIONMAP', COLNAME => 'INSTANCEID', statown => 'scpomgr');

    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERLOCMAP', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERLOCMAP', COLNAME => 'INSTANCEID', statown => 'scpomgr');


    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERBASIS', COLNAME => 'SERVICEID', statown => 'scpomgr');
    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'OPTIMIZERBASIS', COLNAME => 'INSTANCEID', statown => 'scpomgr');

--step 4
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSKUMAP');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERSOURCINGMAP');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERRESMAP');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERPRODUCTIONMAP');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERLOCMAP');

    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASIS');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'OPTIMIZERBASISCOUNT');

End;

/

--------------------------------------------------------
--  DDL for Procedure U_8S_SOURCING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S_SOURCING" as

Begin

--about 5 minutes

--step 1

    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCING');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGDRAW');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGYIELD');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGREQUIREMENT');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGCONSTRAINT');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKU');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUCONSTRAINT');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCONSTRAINT');
    
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'CUSTORDER');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANARRIV');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANORDER');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUTOSKUFCST');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'FCST');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RES');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'COST');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'COSTTIER');
    DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCOST');
    
--do we do this???

  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCING');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGDRAW');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGYIELD');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGREQUIREMENT');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGCONSTRAINT');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SKU');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SKUCONSTRAINT');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RESCONSTRAINT');
  
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'CUSTORDER');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PLANARRIV');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PLANORDER');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'DFUTOSKUFCST');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'FCST');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RES');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'COST');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'COSTTIER');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RESCOST');

--step 2
-- Gather table stats with cascade true,incase you are manually gathering stats while the process was running
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCING',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGDRAW',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGYIELD',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGREQUIREMENT',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGCONSTRAINT',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKU',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUCONSTRAINT',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCONSTRAINT',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'CUSTORDER',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANARRIV',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANORDER',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUTOSKUFCST',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'FCST',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RES',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'COST',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'COSTTIER',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
    DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCOST',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);

-- Step 3
--Delete some of the  column stats for Process tables
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'PRODUCTIONMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'PRODUCTIONRESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SOURCINGMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SOURCINGRESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'SKUMETRIC', COLNAME => 'SERVICEID', statown => 'scpomgr');
--    DBMS_STATS.DELETE_COLUMN_STATS(ownname=> 'scpomgr', tabname => 'RESMETRIC', COLNAME => 'INSTANCEID', statown => 'scpomgr');

--step 4
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCING');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGDRAW');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGYIELD');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGREQUIREMENT');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGCONSTRAINT');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKU');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUCONSTRAINT');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCONSTRAINT');
    
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'CUSTORDER');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANARRIV');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PLANORDER');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUTOSKUFCST');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'FCST');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RES');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'COST');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'COSTTIER');
    DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESCOST');

End;

/

--------------------------------------------------------
--  DDL for Procedure U_99_MFG_CAPACITY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_MFG_CAPACITY" as

begin

delete resconstraint where res = 'MFG_CAPACITY';

commit;

insert into resconstraint (eff, policy, qty, dur, category, res, qtyuom, timeuom)

select eff, 2 policy, qty, 1440*7*1 dur, 12 category, 'MFG_CAPACITY' res, 18 qtyuom, 0 timeuom  --need to factor not by 5 days per week
from tmp_mfgcap;

commit;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_99_MISC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_MISC" as

begin

insert into item (item,    descr,   uom,  wgt, vol,  unitsperpallet,   unitsperaltship, canceldepthlimit,  unitprice,  planlevel,   enablesw, perishablesw,  priitempriority, priority,  restrictplanmode, ddskusw,     
    ddsrccostsw,  dyndepdecimals,  dyndepoption,   dyndeppushopt, dyndepqty,    ff_trigger_control,  itemclass,  invoptimizertype, defaultuom,  allocpolicy,  calccumleadtimesw,    supsngroupnum,      
    u_materialcode,   u_qualitybatch,      u_stock,     u_delete,     u_freight_factor )

select u.item,      ' ' descr,      ' ' uom,     0 wgt,     0 vol,     1 unitsperpallet,     1 unitsperaltship,     0 canceldepthlimit,     0 unitprice,     -1 planlevel,     1 enablesw,     0 perishablesw,     0 priitempriority,     1 priority,     1 restrictplanmode,     0 ddskusw,     
    0 ddsrccostsw,     0 dyndepdecimals,     1 dyndepoption,     1 dyndeppushopt,     1 dyndepqty,      '' ff_trigger_control,     'DEFAULT' itemclass,     1 invoptimizertype,     18 defaultuom,     1 allocpolicy,     0 calccumleadtimesw,     -1 supsngroupnum,      
    u.matcode u_materialcode,      u.qb u_qualitybatch,      u.u_stock,     0 u_delete,     1 u_freight_factor 
from

(select distinct f.dmdunit item, substr(f.dmdunit, 1, 4) matcode, substr(f.dmdunit, 5, 55) qb, 
    case when substr(f.dmdunit, 5, 55) = 'AI' then 'A'
            when substr(f.dmdunit, 5, 55) = 'AR' then 'B' else 'C' end u_stock
from fcst f, loc l
where f.loc = l.loc
and l.u_area = 'NA'
group by f.dmdunit) u;

commit;

insert into loc (loc, descr,  ohpost,   frzstart,    sourcecal,    destcal,   type,    altplantid,    cust,    transzone,  lat,  lon, enablesw,   ff_trigger_control,     
    loc_type,    vendid,    companyid,    workingcal,     seqintexportdur,     seqintimportdur,  seqintlastexportedtoseq,  seqintlastimportedfromseq,     postalcode,    country,     
   currency,    wddarea,   borrowingpct,    hierarchylevel,    u_loctype,    u_city,    u_countrydes,    u_geocode,    u_salesdir,    u_salesdirdes,    u_salesman,     
   u_salesmandes,    u_3digitzip,    u_state,     u_area,    u_region,    u_parent,    u_parent_des,    u_subaffil,    u_grandparent,    u_grandparent_des,    u_affil,    u_custtype,    u_cgroup,    u_industry,    u_mktsector,     
   u_mktsector_des,    u_closingdate,     u_max_src,     u_max_dist,    u_territory,    u_product_speciality)

select y.loc,  ' ' descr,     TO_DATE('01/01/1970','MM/DD/YYYY') ohpost,     TO_DATE('01/01/1970','MM/DD/YYYY') frzstart,     ' ' sourcecal,     ' ' destcal,     1 type,     ' ' altplantid,     ' ' cust,     ' ' transzone,     0 lat,     0 lon,     1 enablesw,      '' ff_trigger_control,     
    2 loc_type,     ' ' vendid,     ' ' companyid,     ' ' workingcal,     0 seqintexportdur,     0 seqintimportdur,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastexportedtoseq,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastimportedfromseq,     0 postalcode,     'US' country,     
    ' ' currency,     ' ' wddarea,     0 borrowingpct,     ' ' hierarchylevel,     ' ' u_loctype,     ' ' u_city,     ' ' u_countrydes,     ' ' u_geocode,     ' ' u_salesdir,     ' ' u_salesdirdes,     ' ' u_salesman,     
    ' ' u_salesmandes,     ' ' u_3digitzip,     ' ' u_state,     'NA' u_area,     ' ' u_region,     ' ' u_parent,     ' ' u_parent_des,     ' ' u_subaffil,     ' ' u_grandparent,     ' ' u_grandparent_des,     ' ' u_affil,     ' ' u_custtype,     ' ' u_cgroup,     ' ' u_industry,     ' ' u_mktsector,     
    ' ' u_mktsector_des,     ' ' u_closingdate,     3 u_max_src,     110 u_max_dist,     ' ' u_territory,     ' ' u_product_speciality
from loc l, 

(select distinct loc from udt_yield) y

where y.loc = l.loc(+)
and l.loc is null;

commit;

insert into udt_cost_transit (source_co, dest_co, distance, cost_pallet, primary_key_col)

select c.source_co, c.dest_co, c.distance, c.cost_pallet, c.rk_co+u.pk pk
from

    (select max(primary_key_col) pk from udt_cost_transit
    ) u, 

    (select source_co, dest_co, distance, cost_pallet, row_number()
            over (partition by 1 order by source_co, dest_co asc) as rk_co 
    from 
    tmp_cost
    ) c;

commit;

--populates various LOC columns from staging table

declare
  cursor cur_selected is
        select l2.loc, l2.descr, l2.country, l2.postalcode, l2.u_geocode, l2.u_city 
        from tmp_loc l2, loc l
        where l2.loc = l.loc
    for update of l.descr;
begin
  for cur_record in cur_selected loop
  
    update loc l
    set l.descr = cur_record.descr
    where current of cur_selected;
    
    update loc l
    set l.country = cur_record.country
    where current of cur_selected;
    
    update loc l
    set l.postalcode = cur_record.postalcode
    where current of cur_selected;
    
    update loc l
    set l.u_geocode = cur_record.u_geocode
    where current of cur_selected;
    
    update loc l
    set l.u_city = cur_record.u_city
    where current of cur_selected;
    
  end loop;
  commit;
end;

-- sets loc_type and storablesw

update loc set loc_type = 6;

commit;

update loc set loc_type = 2 where loc in (select distinct loc from productionmethod);

commit;

update loc set loc_type = 3 where loc in (select distinct dest from sourcing where dest in (select loc from loc where loc_type <> 2));

commit;

update sku set storablesw = 1 where loc in (select loc from loc where loc_type = 2 and substr(loc, -2) <> 'AI');

commit;

update sku set storablesw = 0 where loc in (select loc from loc where loc_type = 3) or substr(loc, -2) = 'AI';

commit;

-- sets loc_type from 2 to 0 if there is no way to assign a production method due to absence of dfuview u_defplant

update loc set loc_type = 0 where loc in (

select u.loc   --, d.u_defplant
from

    (select distinct dmdunit, u_defplant from dfuview ) d,

    (select u.loc
    from

        (select distinct from_loc loc
        from tmp_distance d, loc l
        where from_loc = loc
        and l.loc_type = 2) u,

        (select distinct loc from productionmethod) p

    where u.loc = p.loc(+)
    and p.loc is null) u

where u.loc = d.u_defplant(+)
and d.U_defplant is null);

commit;

--deletes loc_type = 3 SKU that have no sku constraint 

delete sku where item||loc in 

(select s.item||s.loc
from sku s, loc l,

    (select distinct item, loc from skuconstraint) k

where s.loc = l.loc
and l.loc_type = 3
and s.item = k.item(+)
and s.loc = k.loc(+)
and k.item is null);

commit;

--create placeholder customer orders for PSO to test forecast adjustment logic

insert into custorder (item, loc, shipdate, status,     orderid,     fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,   margin,     maxlatedur,     
    promiseddate,   revenue,       headerextref,       lineitemextref,       arrivtranszone,  maxearlydur,    lifecyclestatus,       arrivtransmode,     
    arrivleadtime,     promisedqty,     shipcompletesw,     cost,     unitprice,     orderlineitem,    project,   substlevel,     substoperator,     shipsw,     firmsw,     
    cust,   supersedesw,      ff_trigger_control,  priorityseqnum, atpexcludesw,  ordertype,  fcsttype,   workscope,  dmdunit,  dmdgroup,     overridefcsttypesw, orderseqnum)

select c.item, c.loc, shipdate, o.status,     o.orderid,     o.fcstsw,     o.qty,     o.reservation,     o.resexp,     o.priority,     o.calcpriority,   o.margin,     o.maxlatedur,     
    o.promiseddate,   o.revenue,       o.headerextref,       o.lineitemextref,       o.arrivtranszone,  o.maxearlydur,    o.lifecyclestatus,       o.arrivtransmode,     
    o.arrivleadtime,     o.promisedqty,     o.shipcompletesw,     o.cost,     o.unitprice,     o.orderlineitem,    o.project,   o.substlevel,     o.substoperator,     o.shipsw,     o.firmsw,     
    o.cust,   o.supersedesw,      o.ff_trigger_control,  o.priorityseqnum, o.atpexcludesw,  o.ordertype,  o.fcsttype,   o.workscope,  o.dmdunit,  o.dmdgroup,     o.overridefcsttypesw,
    row_number()
                over (partition by o.status order by c.item, c.loc, shipdate ) as orderseqnum
from

    (select distinct item, dest loc
    from sourcing
    where source = 'ES1J'
    and dest not in (select distinct loc from custorder)) c,

    (select item, shipdate, 1 status,     orderid,     1 fcstsw,     qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')
    union
    select item, to_date('05/11/2014', 'MM/DD/YYYY') shipdate, 1 status,     orderid,     1 fcstsw,     qty+12 qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')) o

where c.item = o.item;

commit;

--another custorder insert  .... 

insert into custorder (item, loc, shipdate, dfuloc,    status,    fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,  margin,     
    maxlatedur,  promiseddate,   revenue,   headerextref,   lineitemextref,   arrivtranszone,     maxearlydur,  lifecyclestatus,   arrivtransmode,     
    arrivleadtime,  promisedqty,     shipcompletesw,     cost,  unitprice,   orderlineitem,    project,     substlevel,  substoperator,   shipsw,  firmsw,         
    cust,    supersedesw,   ff_trigger_control,  priorityseqnum,  atpexcludesw,  ordertype,  fcsttype,    workscope,    dmdunit,    dmdgroup,    overridefcsttypesw,     
    u_sales_document,    u_ship_condition,   u_dmdgroup_code, orderseqnum, orderid)

select item, loc, shipdate, ' ' dfuloc,    1 status,    fcstsw,     qty,     0 reservation,     TO_DATE('01/01/1970','MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     
    0 maxlatedur,     TO_DATE('01/01/1970','MM/DD/YYYY') promiseddate,     -1 revenue,     ' ' headerextref,     ' ' lineitemextref,     ' ' arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,     ' ' arrivtransmode,     
    0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,     ' ' project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,         
    ' ' cust,     0 supersedesw,     '' ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,     ' ' workscope,     ' ' dmdunit,     ' ' dmdgroup,     1 overridefcsttypesw,     
    u_sales_document,     u_ship_condition,     u_dmdgroup_code, orderseqnum, orderid
 from 
(select item,  loc, orderid, shipdate, fcstsw,     qty,     
    u_sales_document,    u_ship_condition,    u_dmdgroup_code,  
        row_number()
              over (partition by 1 order by item, loc, shipdate ) as orderseqnum
from tmp_custorder);

commit;

declare
  cursor cur_selected is
    select l.loc, u.country, u.sq_miles, u.radius_miles, u.radius_km 
    from loc l,

        (select distinct l.country, u.sq_miles, sqrt(u.sq_miles/3.1412) radius_miles, round((sqrt(u.sq_miles/3.1412))*1.61, 0) radius_km 
        from skuconstraint k, loc l, 

            (select 32383 sq_miles, 'AT' country from dual union
            select 11787 sq_miles, 'BE' country from dual union
            select 42855 sq_miles, 'BG' country from dual union
            select 15940 sq_miles, 'CH' country from dual union
            select 30450 sq_miles, 'CZ' country from dual union
            select 137849 sq_miles, 'DE' country from dual union
            select 16440 sq_miles, 'DK' country from dual union
            select 17462 sq_miles, 'EE' country from dual union
            select 195363 sq_miles, 'ES' country from dual union
            select 130559 sq_miles, 'FI' country from dual union
            select 210026 sq_miles, 'FR' country from dual union
            select 93638 sq_miles, 'GB' country from dual union
            select 50999 sq_miles, 'GR' country from dual union
            select 300 sq_miles, 'HR' country from dual union
            select 35919 sq_miles, 'HU' country from dual union
            select 17959.5 sq_miles, 'IE' country from dual union
            select 116346 sq_miles, 'IT' country from dual union
            select 35519 sq_miles, 'JE' country from dual union
            select 36419 sq_miles, 'LT' country from dual union
            select 36169 sq_miles, 'LU' country from dual union
            select 16146 sq_miles, 'NL' country from dual union
            select 125000 sq_miles, 'NO' country from dual union
            select 120700 sq_miles, 'PL' country from dual union
            select 35655 sq_miles, 'PT' country from dual union
            select 148129 sq_miles, 'RO' country from dual union
            select 39617 sq_miles, 'RS' country from dual union
            select 43578 sq_miles, 'SE' country from dual union
            select 21789.17 sq_miles, 'SK' country from dual union
            select 300948 sq_miles, 'TR' country from dual  
            ) u

        where k.loc = l.loc
        and l.country = u.country(+)
        ) u

    where u.radius_km > 110
    and u.country = l.country
    for update of l.u_max_dist;
begin
  for cur_record in cur_selected loop
  
    update loc 
    set u_max_dist = cur_record.radius_km
    where current of cur_selected;
    
  end loop;
  commit;
end;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_99_MISC_EDIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_MISC_EDIT" as

begin

insert into item (item,    descr,   uom,  wgt, vol,  unitsperpallet,   unitsperaltship, canceldepthlimit,  unitprice,  planlevel,   enablesw, perishablesw,  priitempriority, priority,  restrictplanmode, ddskusw,     
    ddsrccostsw,  dyndepdecimals,  dyndepoption,   dyndeppushopt, dyndepqty,    ff_trigger_control,  itemclass,  invoptimizertype, defaultuom,  allocpolicy,  calccumleadtimesw,    supsngroupnum,      
    u_materialcode,   u_qualitybatch,      u_stock,
--    u_delete, ( Commented this out for now )
    u_freight_factor )

select u.item,      ' ' descr,      ' ' uom,     0 wgt,     0 vol,     1 unitsperpallet,     1 unitsperaltship,     0 canceldepthlimit,     0 unitprice,     -1 planlevel,     1 enablesw,     0 perishablesw,     0 priitempriority,     1 priority,     1 restrictplanmode,     0 ddskusw,     
    0 ddsrccostsw,     0 dyndepdecimals,     1 dyndepoption,     1 dyndeppushopt,     1 dyndepqty,      '' ff_trigger_control,     'DEFAULT' itemclass,     1 invoptimizertype,     18 defaultuom,     1 allocpolicy,     0 calccumleadtimesw,     -1 supsngroupnum,      
    u.matcode u_materialcode,      u.qb u_qualitybatch,      u.u_stock,
--    0 u_delete,( Commented this out for now )
    1 u_freight_factor 
from 

(select distinct f.dmdunit item, substr(f.dmdunit, 1, 4) matcode, substr(f.dmdunit, 5, 55) qb, 
    case when substr(f.dmdunit, 5, 55) = 'AI' then 'A'
            when substr(f.dmdunit, 5, 55) = 'AR' then 'B' else 'C' end u_stock
from fcst f, loc l
where f.loc = l.loc
and l.u_area = 'NA'
group by f.dmdunit) u;

commit;

insert into loc (loc, descr,  ohpost,   frzstart,    sourcecal,    destcal,   type,    altplantid,    cust,    transzone,  lat,  lon, enablesw,   ff_trigger_control,     
    loc_type,    vendid,    companyid,    workingcal,     seqintexportdur,     seqintimportdur,  seqintlastexportedtoseq,  seqintlastimportedfromseq,     postalcode,    country,     
   currency,    wddarea,   borrowingpct,    hierarchylevel,    u_loctype,    u_city,    u_countrydes,    u_geocode,    u_salesdir,    u_salesdirdes,    u_salesman,     
   u_salesmandes,    u_3digitzip,    u_state,     u_area,    u_region,    u_parent,    u_parent_des,    u_subaffil,    u_grandparent,    u_grandparent_des,    u_affil,    u_custtype,    u_cgroup,    u_industry,    u_mktsector,     
   u_mktsector_des,    u_closingdate,     u_max_src,     u_max_dist,    u_territory,    u_product_speciality)

select y.loc,  ' ' descr,     TO_DATE('01/01/1970','MM/DD/YYYY') ohpost,     TO_DATE('01/01/1970','MM/DD/YYYY') frzstart,     ' ' sourcecal,     ' ' destcal,     1 type,     ' ' altplantid,     ' ' cust,     ' ' transzone,     0 lat,     0 lon,     1 enablesw,      '' ff_trigger_control,     
    2 loc_type,     ' ' vendid,     ' ' companyid,     ' ' workingcal,     0 seqintexportdur,     0 seqintimportdur,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastexportedtoseq,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastimportedfromseq,     0 postalcode,     'US' country,     
    ' ' currency,     ' ' wddarea,     0 borrowingpct,     ' ' hierarchylevel,     ' ' u_loctype,     ' ' u_city,     ' ' u_countrydes,     ' ' u_geocode,     ' ' u_salesdir,     ' ' u_salesdirdes,     ' ' u_salesman,     
    ' ' u_salesmandes,     ' ' u_3digitzip,     ' ' u_state,     'NA' u_area,     ' ' u_region,     ' ' u_parent,     ' ' u_parent_des,     ' ' u_subaffil,     ' ' u_grandparent,     ' ' u_grandparent_des,     ' ' u_affil,     ' ' u_custtype,     ' ' u_cgroup,     ' ' u_industry,     ' ' u_mktsector,     
    ' ' u_mktsector_des,     ' ' u_closingdate,     3 u_max_src,     110 u_max_dist,     ' ' u_territory,     ' ' u_product_speciality
from loc l, 

(select distinct loc from udt_yield) y

where y.loc = l.loc(+)
and l.loc is null;

commit;

/* Primary Key Column is no longer a valid field. How should I replace this */
--insert into udt_cost_transit (source_co, dest_co, distance, cost_pallet, primary_key_col)
--
--select c.source_co, c.dest_co, c.distance, c.cost_pallet, c.rk_co+u.pk pk
--from
--
--    (select max(primary_key_col) pk from udt_cost_transit
--    ) u, 
--
--    (select source_co, dest_co, distance, cost_pallet, row_number()
--            over (partition by 1 order by source_co, dest_co asc) as rk_co 
--    from 
--    tmp_cost
--    ) c;
--
--commit;

--populates various LOC columns from staging table

/* country and geo code are not columns in tmp_loc Set Country to US. */
--declare
--  cursor cur_selected is
--        select l2.loc
--              ,l2.descr
----            , l2.country
--              , l2.postalcode
--              , l2.u_geocode
--              , l2.u_city
--       from tmp_loc l2
--           ,loc l 
--       where l2.loc = l.loc
--   for update of l.descr;
--begin
--  for cur_record in cur_selected loop
--  
--    update loc l
--    set l.descr = cur_record.descr
--    where current of cur_selected;
--    
--    update loc l
--    set l.country = 'US'
----    set l.country = cur_record.country
--    where current of cur_selected;
--    
--    update loc l
--    set l.postalcode = cur_record.postalcode
--    where current of cur_selected;
--    
--    update loc l
--    set l.u_geocode = cur_record.u_geocode
--    where current of cur_selected;
--    
--    update loc l
--    set l.u_city = cur_record.u_city
--    where current of cur_selected;
--    
--  end loop;
--  commit;
--end;

-- sets loc_type and storablesw

update loc set loc_type = 6;

commit;

update loc set loc_type = 2 where loc in (select distinct loc from productionmethod);

commit;

update loc set loc_type = 3 where loc in (select distinct dest from sourcing where dest in (select loc from loc where loc_type <> 2));

commit;

update sku set storablesw = 1 where loc in (select loc from loc where loc_type = 2 and substr(loc, -2) <> 'AI');

commit;

update sku set storablesw = 0 where loc in (select loc from loc where loc_type = 3) or substr(loc, -2) = 'AI';

commit;

-- sets loc_type from 2 to 0 if there is no way to assign a production method due to absence of dfuview u_defplant

update loc set loc_type = 0 where loc in (

select u.loc   --, d.u_defplant
from

    (select distinct dmdunit, u_defplant from dfuview ) d,

    (select u.loc
    from

        (select distinct from_loc loc
        from tmp_distance d, loc l
        where from_loc = loc
        and l.loc_type = 2) u,

        (select distinct loc from productionmethod) p

    where u.loc = p.loc(+)
    and p.loc is null) u

where u.loc = d.u_defplant(+)
and d.U_defplant is null);

commit;

--deletes loc_type = 3 SKU that have no sku constraint 

delete sku where item||loc in 

(select s.item||s.loc
from sku s, loc l,

    (select distinct item, loc from skuconstraint) k

where s.loc = l.loc
and l.loc_type = 3
and s.item = k.item(+)
and s.loc = k.loc(+)
and k.item is null);

commit;

--create placeholder customer orders for PSO to test forecast adjustment logic

insert into custorder (item, loc, shipdate, status,     orderid,     fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,   margin,     maxlatedur,     
    promiseddate,   revenue,       headerextref,       lineitemextref,       arrivtranszone,  maxearlydur,    lifecyclestatus,       arrivtransmode,     
    arrivleadtime,     promisedqty,     shipcompletesw,     cost,     unitprice,     orderlineitem,    project,   substlevel,     substoperator,     shipsw,     firmsw,     
    cust,   supersedesw,      ff_trigger_control,  priorityseqnum, atpexcludesw,  ordertype,  fcsttype,   workscope,  dmdunit,  dmdgroup,     overridefcsttypesw, orderseqnum)

select c.item, c.loc, shipdate, o.status,     o.orderid,     o.fcstsw,     o.qty,     o.reservation,     o.resexp,     o.priority,     o.calcpriority,   o.margin,     o.maxlatedur,     
    o.promiseddate,   o.revenue,       o.headerextref,       o.lineitemextref,       o.arrivtranszone,  o.maxearlydur,    o.lifecyclestatus,       o.arrivtransmode,     
    o.arrivleadtime,     o.promisedqty,     o.shipcompletesw,     o.cost,     o.unitprice,     o.orderlineitem,    o.project,   o.substlevel,     o.substoperator,     o.shipsw,     o.firmsw,     
    o.cust,   o.supersedesw,      o.ff_trigger_control,  o.priorityseqnum, o.atpexcludesw,  o.ordertype,  o.fcsttype,   o.workscope,  o.dmdunit,  o.dmdgroup,     o.overridefcsttypesw,
    row_number()
                over (partition by o.status order by c.item, c.loc, shipdate ) as orderseqnum
from

    (select distinct item, dest loc
    from sourcing
    where source = 'ES1J'
    and dest not in (select distinct loc from custorder)) c,

    (select item, shipdate, 1 status,     orderid,     1 fcstsw,     qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')
    union
    select item, to_date('05/11/2014', 'MM/DD/YYYY') shipdate, 1 status,     orderid,     1 fcstsw,     qty+12 qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')) o

where c.item = o.item;

commit;

--another custorder insert  .... 

/* The table tmp_custorder does not exist */
--insert into custorder (item, loc, shipdate, dfuloc,    status,    fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,  margin,     
--    maxlatedur,  promiseddate,   revenue,   headerextref,   lineitemextref,   arrivtranszone,     maxearlydur,  lifecyclestatus,   arrivtransmode,     
--    arrivleadtime,  promisedqty,     shipcompletesw,     cost,  unitprice,   orderlineitem,    project,     substlevel,  substoperator,   shipsw,  firmsw,         
--    cust,    supersedesw,   ff_trigger_control,  priorityseqnum,  atpexcludesw,  ordertype,  fcsttype,    workscope,    dmdunit,    dmdgroup,    overridefcsttypesw,     
--    u_sales_document,    u_ship_condition,   u_dmdgroup_code, orderseqnum, orderid)
--
--select item, loc, shipdate, ' ' dfuloc,    1 status,    fcstsw,     qty,     0 reservation,     TO_DATE('01/01/1970','MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     
--    0 maxlatedur,     TO_DATE('01/01/1970','MM/DD/YYYY') promiseddate,     -1 revenue,     ' ' headerextref,     ' ' lineitemextref,     ' ' arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,     ' ' arrivtransmode,     
--    0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,     ' ' project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,         
--    ' ' cust,     0 supersedesw,     '' ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,     ' ' workscope,     ' ' dmdunit,     ' ' dmdgroup,     1 overridefcsttypesw,     
--    u_sales_document,     u_ship_condition,     u_dmdgroup_code, orderseqnum, orderid
-- from 
--(select item,  loc, orderid, shipdate, fcstsw,     qty,     
--    u_sales_document,    u_ship_condition,    u_dmdgroup_code,  
--        row_number()
--              over (partition by 1 order by item, loc, shipdate ) as orderseqnum
--from tmp_custorder);
--
--commit;

declare
  cursor cur_selected is
    select l.loc, u.country, u.sq_miles, u.radius_miles, u.radius_km 
    from loc l,

        (select distinct l.country, u.sq_miles, sqrt(u.sq_miles/3.1412) radius_miles, round((sqrt(u.sq_miles/3.1412))*1.61, 0) radius_km 
        from skuconstraint k, loc l, 

            (select 32383 sq_miles, 'AT' country from dual union
            select 11787 sq_miles, 'BE' country from dual union
            select 42855 sq_miles, 'BG' country from dual union
            select 15940 sq_miles, 'CH' country from dual union
            select 30450 sq_miles, 'CZ' country from dual union
            select 137849 sq_miles, 'DE' country from dual union
            select 16440 sq_miles, 'DK' country from dual union
            select 17462 sq_miles, 'EE' country from dual union
            select 195363 sq_miles, 'ES' country from dual union
            select 130559 sq_miles, 'FI' country from dual union
            select 210026 sq_miles, 'FR' country from dual union
            select 93638 sq_miles, 'GB' country from dual union
            select 50999 sq_miles, 'GR' country from dual union
            select 300 sq_miles, 'HR' country from dual union
            select 35919 sq_miles, 'HU' country from dual union
            select 17959.5 sq_miles, 'IE' country from dual union
            select 116346 sq_miles, 'IT' country from dual union
            select 35519 sq_miles, 'JE' country from dual union
            select 36419 sq_miles, 'LT' country from dual union
            select 36169 sq_miles, 'LU' country from dual union
            select 16146 sq_miles, 'NL' country from dual union
            select 125000 sq_miles, 'NO' country from dual union
            select 120700 sq_miles, 'PL' country from dual union
            select 35655 sq_miles, 'PT' country from dual union
            select 148129 sq_miles, 'RO' country from dual union
            select 39617 sq_miles, 'RS' country from dual union
            select 43578 sq_miles, 'SE' country from dual union
            select 21789.17 sq_miles, 'SK' country from dual union
            select 300948 sq_miles, 'TR' country from dual  
            ) u

        where k.loc = l.loc
        and l.country = u.country(+)
        ) u

    where u.radius_km > 110
    and u.country = l.country
    for update of l.u_max_dist;
begin
  for cur_record in cur_selected loop
  
    update loc 
    set u_max_dist = cur_record.radius_km
    where current of cur_selected;
    
  end loop;
  commit;
end;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_BACKUP_VIEWS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_BACKUP_VIEWS" as 
begin

execute immediate drop table SCPOMGR.MAK_SKUCONSTR_COLL_MISSING;

drop table SCPOMGR.MAK_SKUCONSTR_NO_3DIGIT_COLL;

drop table MAK_SKUCONSTR_NO_3ZIP_COSTTRN;

drop table SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_SUMMARY;

drop table MAK_SKUCONSTR_NO_5ZIP_COL;

drop table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN;

drop table SCPOMGR.MAK_SKUCONSTR_NO_PC_SUMMARY;

drop table SCPOMGR.MAK_SKUCONSTR_SRC_MISSING;


create table SCPOMGR.MAK_SKUCONSTR_COLL_MISSING
as select * from SCPOMGR.SKUCONSTR_COLL_MISSING;

create table SCPOMGR.MAK_SKUCONSTR_NO_3DIGIT_COLL
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_COLL;

create table SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_COSTTRN;

create table SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_SUMMARY
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_SUMMARY;

create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COLL
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COLLECTION;


create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COSTTRN;

create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COSTTRN;

create table SCPOMGR.MAK_SKUCONSTR_NO_PC_SUMMARY
as select * from SCPOMGR.SKUCONSTR_NO_PC_SUMMARY;

create table SCPOMGR.MAK_SKUCONSTR_SRC_ALL
as select * from SCPOMGR.SKUCONSTR_SRC_ALL;

create table SCPOMGR.MAK_SKUCONSTR_SRC_MISSING
as select * from SCPOMGR.SKUCONSTR_SRC_MISSING;

end;

/

--------------------------------------------------------
--  DDL for Procedure U_REFRESH_MVS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_REFRESH_MVS" as

begin

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_ALL','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_MISSING','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_NO_3DIGIT_COLL','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_3DIGIT_COSTTRN','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_3DIGIT_SUMMARY','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_5DIGIT_COLLECTION','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_5DIGIT_COSTTRN','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_PC_SUMMARY','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_SRC_ALL','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_SRC_MISSING','C');

end;

/

