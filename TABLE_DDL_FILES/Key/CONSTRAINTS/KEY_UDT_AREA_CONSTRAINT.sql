--------------------------------------------------------
--  Constraints for Table KEY_UDT_AREA
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" ADD CONSTRAINT "XPKKEY_UDT_AREA" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "COMPANYID")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("COMPANYID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_AREA" MODIFY ("KEY_ID" NOT NULL ENABLE)
