--------------------------------------------------------
--  Constraints for Table KEY_UDT_AREA_TYPE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" ADD CONSTRAINT "XPKKEY_UDT_AREA_TYPE" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "U_AREA")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("U_AREA" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA_TYPE" MODIFY ("KEY_ID" NOT NULL ENABLE)
