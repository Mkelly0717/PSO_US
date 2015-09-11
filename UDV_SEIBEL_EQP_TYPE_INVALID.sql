--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_INVALID
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_INVALID" ("LOC", "U_EQUIPMENT_TYPE") AS 
  select l.loc, l.u_equipment_type
from loc l
where l.country='US'
  and trim(l.u_equipment_type) is not null
  and not exists ( select '1' from udt_equipment_type eqt
                 where l.u_equipment_type=eqt.u_equipment_type
              );
