--------------------------------------------------------
--  Constraints for Table KEY_UDT_PLANT_STATUS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" ADD CONSTRAINT "XPKKEY_UDT_PLANT_STATUS" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "RES", "U_STOCK", "U_MATERIALCODE", "LOC")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("U_MATERIALCODE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("U_STOCK" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("RES" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" MODIFY ("KEY_ID" NOT NULL ENABLE)
