--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_INTER
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_INTER" ("POSTALCODE", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  select pc.postalcode, geo."3DigitZip", pc.u_equipment_type
from udv_skuconstr_no_pc_summary pc, udv_skuconstr_no_3zip_summary geo
where substr(pc.postalcode,1,3) = geo."3DigitZip"
  and pc.u_equipment_type=geo.u_equipment_type;
