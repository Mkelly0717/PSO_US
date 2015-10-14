set echo off;
set feedback off
set verify off
set trimspool on
set heading off
set showmode = off;
/****************************************************/
Define Loc='UT50';
define item='4001AI';

select 'U_10_SKU_BASE_PART2'
   ,loc_item.item, loc_item.loc, 0 oh, 5 replentype, 1 netchgsw, v_init_eff_date ohpost
   ,-1 planlevel, ' ' sourcinggroup, 18 qtyuom, 15 currencyuom
   ,1 storablesw, 1 enablesw, 35 timeuom, ''  ff_trigger_control
   ,0 infcarryfwdsw, 1 minohcovrule, 1 targetohcovrule, ' ' ltdgroup
   ,0 infinitesupplysw, 0 mpbatchnum, 0 seqintenablesw, -1 itemstoregrade
   , 0 rpbatchnum
from sku s,
( select l.loc, i.item
    From Loc L, Item I
   where l.loc_type in ( 2, 4, 5) and l.loc='&loc'
     and l.u_area='NA'
     and i.enablesw = 1
     And L.Enablesw = 1
     and i.u_stock in ('A') and i.item='&item'
) loc_item  
Where S.Item(+)=Loc_Item.Item
  and s.loc(+) = loc_item.loc
--  and s.item is null;