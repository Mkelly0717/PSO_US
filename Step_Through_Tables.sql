set echo off;
set feedback off
set verify off
set trimspool on
set heading off
set showmode = off;
/
/****************************************************/

define loc='UT1X';
define item='4001AI';
--define item='4055RUPLUS';
/* Check Item */
select 'Item' "TABLE"
  , item
  , u_materialcode
  , u_qualitybatch
  , u_stock
  , enablesw
from item
where item='&item';
/

/* Check Loc */
select 'Loc' "TABLE"
  , loc
  , loc_type
  , u_plant_network_type
  , u_area
  , enablesw
from loc
where loc='&loc';
/

/* Check Sku */
select 'SKU' "TABLE"
  , loc
  , item
from sku
where loc='&loc'
    and item = '&item';
/