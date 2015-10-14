set echo off;
set feedback off
set verify off
set trimspool on
set heading off
set showmode = off;
/
/****************************************************/

--define loc='UT50';
--define loc='UT63';
--define item='4055RUPLUS';
/


select distinct 'U_10_SKU_BASE_PART6'
   ,i.item, l.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
   ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom, 1 storablesw
   ,1 enablesw, 35 timeuom, ''  ff_trigger_control, 0 infcarryfwdsw
   ,1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup, 0 infinitesupplysw
   , 0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade, 0 rpbatchnum
from loc l, item i, udt_yield yield
where l.loc_type in (2, 4)
  and l.u_area='NA'
  and i.u_stock='C'
  and i.enablesw = 1
  and l.enablesw = 1 
  and not exists ( select 1
                     from sku sku
                    where sku.loc=l.loc
                      and sku.item=i.item
                  )
  and yield.loc=l.loc
  and yield.item=i.item
  and yield.maxcap > 0
  and yield.yield > 0
  and exists ( select 1
                 from udt_plant_status ps
                where ps.loc=yield.loc
                  and ps.status=1
                  and (   (yield.productionmethod='INS' and ps.res='SORT')
                       or 
                          (yield.productionmethod='REP' and ps.res='REPAIR'
                           )
                       or
                          (yield.productionmethod='HTR' and ps.res='HEATTREAT')
                      )
              );