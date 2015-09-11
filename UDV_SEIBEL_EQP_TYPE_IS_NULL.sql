--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_IS_NULL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_IS_NULL" ("LOC") AS 
  select l.loc
from loc l
where trim(l.u_equipment_type) is null
  and l.country='US';
