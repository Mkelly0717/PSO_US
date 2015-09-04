--------------------------------------------------------
--  DDL for Procedure U_10_SKU_BASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_10_SKU_BASE" as

begin

insert into item (item, descr, uom, defaultuom, u_materialcode, u_qualitybatch, u_stock)

select y.item, ' ' descr, ' ' uom, 18 defaultuom, substr(y.item, 1, 5) u_materialcode, substr(y.item, 5, 55) u_qualitybatch, 
    case when substr(y.item, -2) = 'AR' then 'B'
            when substr(y.item, -2) = 'AI' then 'A' else 'C' end u_stock
from item i, 

(select distinct item from udt_yield
 where maxcap > 0
   and yield > 0
union
select '4055AI' item from dual 
) y

where y.item = i.item(+)
and i.item is null;

commit;

--SKU for service centers, TPM

insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
    itemstoregrade,     rpbatchnum)

select u.item, u.loc, 0 oh,     5 replentype,     1 netchgsw,     to_date('01/01/1970', 'MM/DD/YYYY') ohpost,     -1 planlevel,     ' ' sourcinggroup,     18 qtyuom,    15 currencyuom,     1 storablesw,     
    1 enablesw,     35 timeuom,    ''  ff_trigger_control,     0 infcarryfwdsw,     1 minohcovrule,     1 targetohcovrule,     ' ' ltdgroup,     0 infinitesupplysw,     0 mpbatchnum,     0 seqintenablesw,     
    -1 itemstoregrade,     0 rpbatchnum
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

--temporary step to create SKU for MFG locations

insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
    itemstoregrade,     rpbatchnum)

/**************************************************************
** 08282015 - added other skus at mfg so can create production 
**            methods to convert to RUNEW 
***************************************************************/
select i.item
  , l.loc
  , 0 oh
  , 5 replentype
  , 1 netchgsw
  , to_date('01/01/1970', 'MM/DD/YYYY') ohpost
  , -1 planlevel
  , ' ' sourcinggroup
  , 18 qtyuom
  , 15 currencyuom
  , 1 storablesw
  , 1 enablesw
  , 35 timeuom
  , '' ff_trigger_control
  , 0 infcarryfwdsw
  , 1 minohcovrule
  , 1 targetohcovrule
  , ' ' ltdgroup
  , 0 infinitesupplysw
  , 0 mpbatchnum
  , 0 seqintenablesw
  , -1 itemstoregrade
  , 0 rpbatchnum
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

/*
SKU for AI at service centers; if an RU exists at SC then an AI should as well  
RU could be created at service from udt_yield or dfuview def_plant
AR SKU should be created if percenrepair > 0 
*/  

insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
    itemstoregrade,     rpbatchnum)

select u.item, u.loc, 0 oh,     5 replentype,     1 netchgsw,     to_date('01/01/1970', 'MM/DD/YYYY') ohpost,     -1 planlevel,     ' ' sourcinggroup,     18 qtyuom,    15 currencyuom,     1 storablesw,     
    1 enablesw,     35 timeuom,    ''  ff_trigger_control,     0 infcarryfwdsw,     1 minohcovrule,     1 targetohcovrule,     ' ' ltdgroup,     0 infinitesupplysw,     0 mpbatchnum,     0 seqintenablesw,     
    -1 itemstoregrade,     0 rpbatchnum
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


/* loc_type 3 SKU for NA ==> Infinit Carry Switch to 0 for WEEEKLY VERSION */

insert into sku (item, loc, oh,   replentype,   netchgsw,  ohpost,  planlevel,  sourcinggroup, qtyuom, currencyuom,  storablesw,     
    enablesw,   timeuom,  ff_trigger_control, infcarryfwdsw,  minohcovrule, targetohcovrule,  ltdgroup,     infinitesupplysw,     mpbatchnum,     seqintenablesw,     
    itemstoregrade,     rpbatchnum)

select u.item, u.loc, 0 oh,     5 replentype,     1 netchgsw,     to_date('01/01/1970', 'MM/DD/YYYY') ohpost,     -1 planlevel,     ' ' sourcinggroup,     18 qtyuom,    15 currencyuom,    1 storablesw,     
    1 enablesw,     35 timeuom,    ''  ff_trigger_control,     u.infcarryfwdsw,     1 minohcovrule,     1 targetohcovrule,     ' ' ltdgroup,     0 infinitesupplysw,     0 mpbatchnum,     0 seqintenablesw,     
    -1 itemstoregrade,     0 rpbatchnum
from 

    (select f.item, f.loc, f.infcarryfwdsw
    from sku s, 

        (select  distinct 
            case when f.dmdunit = '4001AI' then '4055AI' else f.dmdunit end item, f.loc, 
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

execute immediate 'truncate table dfutoskufcst';


insert into dfutoskufcst (dmdunit, item, dmdgroup, dfuloc, skuloc, startdate, dur, type, supersedesw, ff_trigger_control, totfcst)

select distinct f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate, f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
from sku s, item i, loc l, 

    (select distinct f.dmdunit, 
        case when f.dmdunit = '4001AI' then '4055AI' else f.dmdunit end item, f.dmdgroup, f.loc dfuloc, f.loc skuloc, startdate, dur, 1 type, 0 supersedesw, ''  ff_trigger_control, sum(qty) totfcst
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

--create forecast records for RUNEW only where permitted, LOC:U_RUNEW_CUST = 1 

insert into dfutoskufcst (dmdunit, item, dmdgroup, dfuloc, skuloc, startdate, dur, type, supersedesw, ff_trigger_control, totfcst)
 
select distinct f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate, f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
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

-- create forecast records at LOC_TYPE 2 locations for supply of TPM; A, B and C stock are all supply (CAT10 SKU constraints)

insert into dfutoskufcst (dmdunit, item, dmdgroup, dfuloc, skuloc, startdate, dur, type, supersedesw, ff_trigger_control, totfcst)

select distinct f.dmdunit, f.item, f.dmdgroup, f.dfuloc, f.skuloc, f.startdate, f.dur, f.type, f.supersedesw, f.ff_trigger_control, f.totfcst
from sku s, item i, loc l, 

    (select distinct f.dmdunit, 
        case when f.dmdunit = '4001AI' then '4055AI' else f.dmdunit end item, f.dmdgroup, f.loc dfuloc, f.loc skuloc, startdate, dur, 1 type, 0 supersedesw, ''  ff_trigger_control, sum(qty) totfcst
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


insert into cal 

select s.loc||'_'||s.item cal, 'Allocation Calendar' descr, 7 type, ' ' master, 0 numfcstper, 0 rollingsw 
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

insert into caldata

select c.cal, ' ' altcal, 23319360 eff, 6 opt, 0 repeat, 0 avail, 'Allocation Calendar' descr, 0 perwgt, 1/7 allocwgt, 0 covdur 
from cal c, caldata cd, sku s
where substr(c.cal, 1, instr(c.cal, '_')-1) = s.loc
and substr(c.cal, instr(c.cal, '_')+1, 55) = s.item
and c.type = 7 
and c.cal = cd.cal(+)
and cd.cal is null;

commit;

/*
SKU demand paramters are created initially here but are maintained afterwards through FE page.  SKU typically are not deleted like sourcing but if they are and need to be re-created then previous
demand parameter settigns will be lost.  A UDT may later be considered.
*/

insert into skudemandparam (item, loc, custorderdur,  dmdtodate,  fcstadjrule,  maxcustordersysdur,  proratesw,  prorationdur,   dmdredid,  ccpsw,  custorderpriority,  fcstmeetearlydur,   fcstpriority,     
    fcstmeetlatedur,     alloccal,   inddmdunitcost,   inddmdunitmargin,  unitcarcost,  ff_trigger_control, fcstconsumptionrule,  fcstprimconsdur, fcstsecconsdur,     
    proratebytypesw,  alloccalgroup,   mastercal,  weeklyavghist)

select s.item, s.loc, 
    case when l.loc_type = 3 then 1440*1 else 1440*365 end custorderdur,     0 dmdtodate,     
    case when l.loc_type = 3 then 6 else 2 end fcstadjrule,     
    case when l.loc_type = 3 then 1440*13 else 0 end maxcustordersysdur,     0 proratesw,     0 prorationdur,     ' ' dmdredid,     0 ccpsw,     -1 custorderpriority,     0 fcstmeetearlydur,     -1 fcstpriority,     
    0 fcstmeetlatedur,      s.loc||'_'||s.item alloccal,     0 inddmdunitcost,     0 inddmdunitmargin,     0 unitcarcost,    ''  ff_trigger_control,     0 fcstconsumptionrule,     0 fcstprimconsdur,     0 fcstsecconsdur,     
    0 proratebytypesw,     ' ' alloccalgroup,     ' ' mastercal,     0 weeklyavghist
from skudemandparam p, sku s, loc l
where s.enablesw = 1
and s.loc = l.loc
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;

insert into skudeploymentparam (item, loc, allocstratid,   constrrecshipsw,   locpriority,   minallocdur,  pushopt,  recshippushopt,  recshipsupplyrule,  rsallocrule,  stockavaildur,   dyndepldur,     
    incstkoutcost,  initstkoutcost,  shortagessfactor,   surplusrestockcost,  surplusssfactor,  shortagedur,  unitstocklowcost,  unitstockoutcost,  enablesubsw,     
    meetprisssw,    usesubstsssw,  recshipcal,  ff_trigger_control,  deploydetaillevel,   holdbackqty,  maxbucketdur,  skupriority, secrsallocrule,     
    recshipdur,   sourcessrule)

select s.item, s.loc, ' ' allocstratid,     0 constrrecshipsw,     1 locpriority,     0 minallocdur,     0 pushopt,     1 recshippushopt,     1 recshipsupplyrule,     1 rsallocrule,     0 stockavaildur,     0 dyndepldur,     
    0 incstkoutcost,     0 initstkoutcost,     1 shortagessfactor,     0 surplusrestockcost,     0 surplusssfactor,     0 shortagedur,     0 unitstocklowcost,     0 unitstockoutcost,     0 enablesubsw,     
    0 meetprisssw,     0 usesubstsssw, ' ' recshipcal,    ''  ff_trigger_control,     1 deploydetaillevel,     0 holdbackqty,     0 maxbucketdur,     0 skupriority,     1 secrsallocrule,     
    0 recshipdur,     3 sourcessrule
from skudeploymentparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;

insert into skuplanningparam (item, loc, atpdur, depdmdopt, externalskusw,  firstreplendate, lastfrzstart,     
     lastplanstart,  plandur, planleadtime, planleadtimerule, planshipfrzdur, restrictdur, allocbatchsw, cmpfirmdur,     
     custservicelevel, maxchangefactor,  mfgleadtime,  recschedrcptsdur,  cpppriority, cpplocksw, criticalmaterialsw, aggexcesssupplyrule,  aggundersupplyrule,     
     bufferleadtime,   maxoh,  maxcovdur,  drpcovdur,  drpfrzdur,  drprule, drptimefencedate,     
     drptimefencedur,  incdrpqty, mindrpqty, mpscovdur, mfgfrzdur, mpsrule, mpstimefencedate,mpstimefencedur,     
     incmpsqty,  minmpsqty,  shrinkagefactor,  expdate, atprule,  prodcal,  prodstartdate,     
     prodstopdate,   orderingcost, holdingcost,  eoq,  ff_trigger_control,  workingcal, lookaheaddur, orderpointrule,     
     orderskudetailsw,  supsdmindmdcovdur,  orderpointminrule, orderpointminqty, orderpointmindur,  orderuptolevelmaxrule,  orderuptolevelmaxqty,     
     orderuptolevelmaxdur,   aggskurule,  fwdbuymaxdur, costuom,  cumleadtimedur,   cumleadtimeadjdur,  cumleadtimerule,  roundingfactor,     
     limitplanarrivpublishsw,  limitplanarrivpublishdur,     maxohrule)

select s.item, s.loc, 0 atpdur,     3 depdmdopt,     0 externalskusw,     TO_DATE('01/01/1970','MM/DD/YYYY') firstreplendate,     TO_DATE('01/01/1970','MM/DD/YYYY') lastfrzstart,     
    TO_DATE('01/01/1970','MM/DD/YYYY') lastplanstart,     524160 plandur,     0 planleadtime,     2 planleadtimerule,     0 planshipfrzdur,     0 restrictdur,     0 allocbatchsw,     0 cmpfirmdur,     
     0.9 custservicelevel,     1 maxchangefactor,     0 mfgleadtime,     0 recschedrcptsdur,     1 cpppriority,     0 cpplocksw,     1 criticalmaterialsw,     2 aggexcesssupplyrule,     1 aggundersupplyrule,     
     0 bufferleadtime,     999999999 maxoh,     1048320 maxcovdur,     10080 drpcovdur,     0 drpfrzdur,     1 drprule,     TO_DATE('01/01/1970','MM/DD/YYYY') drptimefencedate,     
     0 drptimefencedur,     1 incdrpqty,     0 mindrpqty,     10080 mpscovdur,     0 mfgfrzdur,     1 mpsrule,     TO_DATE('01/01/1970','MM/DD/YYYY') mpstimefencedate,     0 mpstimefencedur,     
     1 incmpsqty,     0 minmpsqty,     0 shrinkagefactor,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,     1 atprule,     ' ' prodcal,     TO_DATE('01/01/1970','MM/DD/YYYY') prodstartdate,     
     TO_DATE('01/01/1970','MM/DD/YYYY') prodstopdate,     1 orderingcost,     1 holdingcost,     1 eoq,    ''  ff_trigger_control,     ' ' workingcal,     0 lookaheaddur,     2 orderpointrule,     
     0 orderskudetailsw,     1048320 supsdmindmdcovdur,     1 orderpointminrule,     0 orderpointminqty,     0 orderpointmindur,     1 orderuptolevelmaxrule,     0 orderuptolevelmaxqty,     
     0 orderuptolevelmaxdur,     0 aggskurule,     0 fwdbuymaxdur,     0 costuom,     0 cumleadtimedur,     0 cumleadtimeadjdur,     1 cumleadtimerule,     0 roundingfactor,     
     0 limitplanarrivpublishsw,     0 limitplanarrivpublishdur,     1 maxohrule
from skuplanningparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;

insert into skusafetystockparam (item, loc, avgleadtime,     avgnumlines,     leadtimesd,     maxss,     minss,     mfgleadtimerule,     mselag,     mseper,     netfcstmsesmconst,     
    numreplenyr,     statssadjopt,     sscov,     ssrule,     statsscsl,     ssmeetearlydur,     sspriority,     tohrule, sstemplate,     dmddisttype,     
    cslmetric,     calcstatssrule,     avgdmdcal,     avgdmdlookbwddur,     avgdmdlookfwddur,     calcmserule,     dmdcal,     dmdpostdate,     fcstdur,     ff_trigger_control,     
    statsscovlimitdur,     supersedesssw,     msemaskopt,     msemaskminval,     msemaskmaxval,     dmdcorrelationfactor,     accumdur,     mseabstolerancelimit,     dmdalloccal,   
    sspresentationopt,     maxsscovskipdur,     maxssfactor,     msemodelopt,     sscovusebaseonlysw,     arrivalpostdate,     shipdatadur,     shiplag,     orderlag,     orderpostdate,     
    orderdatadur,     allowearlyarrivsw,     allowearlyordersw,     csltemplate)

select s.item, s.loc, 0 avgleadtime,     0 avgnumlines,     0 leadtimesd,     999999999 maxss,     0 minss,     1 mfgleadtimerule,     0 mselag,     0 mseper,     0 netfcstmsesmconst   ,     
    12 numreplenyr,     1 statssadjopt,     0 sscov,     1 ssrule,     0 statsscsl,     0 ssmeetearlydur,     -1 sspriority,     3 tohrule,     ' ' sstemplate,     1 dmddisttype ,     
    2 cslmetric,     1 calcstatssrule,     ' ' avgdmdcal,     0 avgdmdlookbwddur,     525600 avgdmdlookfwddur,     1 calcmserule,     ' ' dmdcal,     TO_DATE('01/01/1970','MM/DD/YYYY') dmdpostdate, 10080 fcstdur,    ''  ff_trigger_control,     
    0 statsscovlimitdur,     1 supersedesssw,     0 msemaskopt,     0 msemaskminval,     100 msemaskmaxval,     1 dmdcorrelationfactor,     1440 accumdur,     0 mseabstolerancelimit,     ' ' dmdalloccal,     
    1 sspresentationopt,     0 maxsscovskipdur,     0 maxssfactor,     1 msemodelopt,     0 sscovusebaseonlysw, TO_DATE('01/01/1970','MM/DD/YYYY') arrivalpostdate,     0 shipdatadur,     0 shiplag,     0 orderlag,     TO_DATE('01/01/1970','MM/DD/YYYY') orderpostdate,     
    0 orderdatadur,     1 allowearlyarrivsw,     1 allowearlyordersw, '' csltemplate
from skusafetystockparam p, sku s
where s.enablesw = 1
and s.item = p.item(+)
and s.loc = p.loc(+)
and p.item is null;

commit;

update sku set ohpost = (select min(startdate) from dfutoskufcst);

commit;

end;

/

