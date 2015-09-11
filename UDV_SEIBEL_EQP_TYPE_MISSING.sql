--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_MISSING" ("LOC", "U_EQUIPMENT_TYPE") AS 
  select l.loc, l.u_equipment_type
from loc l
where (  l.u_equipment_type='X'
            or 
            trim( l.u_equipment_type) is null
           )
  and l.country='US';
