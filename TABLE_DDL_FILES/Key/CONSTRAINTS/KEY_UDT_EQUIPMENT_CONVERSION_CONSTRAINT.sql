--------------------------------------------------------
--  Constraints for Table KEY_UDT_EQUIPMENT_CONVERSION
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" ADD CONSTRAINT "XPKKEY_UDT_EQUIPMENT_CONVERSIO" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "U_EQUIPMENT_TYPE", "U_AREA", "EQUIPMENT_NATIVE", "COMPANYID")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("COMPANYID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("EQUIPMENT_NATIVE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("U_AREA" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("U_EQUIPMENT_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" MODIFY ("KEY_ID" NOT NULL ENABLE)
