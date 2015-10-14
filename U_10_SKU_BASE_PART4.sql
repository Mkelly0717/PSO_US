set echo off;
set feedback off
set verify off
set trimspool on
set heading off
set showmode = off;
/****************************************************/

define loc='UT50';
Define Item='4055AR';

select 'U_10_SKU_BASE_PART4'
   ,i.item, l.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
   ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom, 1 storablesw
   ,1 enablesw, 35 timeuom, ''  ff_trigger_control, 0 infcarryfwdsw
   ,1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup, 0 infinitesupplysw
   , 0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade, 0 rpbatchnum
from loc l, item i
where l.loc_type = 5                        and l.loc='&loc'
  and l.u_area='NA'
  and i.u_stock='C'
  and i.enablesw = 1
  and l.enablesw = 1 
  and not exists ( select 1
                     from sku sku
                    where sku.loc=l.loc
                      and sku.item=i.item
                  );