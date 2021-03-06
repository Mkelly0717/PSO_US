--------------------------------------------------------
--  Constraints for Table KEY_UDT_SUBSTITUTE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" ADD CONSTRAINT "XPKKEY_UDT_SUBSTITUTE" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "PARENT", "SUBORD", "COUNTRY", "BOMNUM")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("BOMNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("COUNTRY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("SUBORD" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("PARENT" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" MODIFY ("KEY_ID" NOT NULL ENABLE)
