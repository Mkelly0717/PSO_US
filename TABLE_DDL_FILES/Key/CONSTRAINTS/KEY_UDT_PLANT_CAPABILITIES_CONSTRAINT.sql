--------------------------------------------------------
--  Constraints for Table KEY_UDT_PLANT_CAPABILITIES
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" ADD CONSTRAINT "XPKKEY_UDT_PLANT_CAPABILITIES" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "CAPABILITY")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("CAPABILITY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_CAPABILITIES" MODIFY ("KEY_ID" NOT NULL ENABLE)