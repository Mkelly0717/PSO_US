--------------------------------------------------------
--  Constraints for Table KEY_UDT_SRCLIMITS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" ADD CONSTRAINT "XPKKEY_UDT_SRCLIMITS" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "PRIMARY_KEY_COL")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("PRIMARY_KEY_COL" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_SRCLIMITS" MODIFY ("KEY_ID" NOT NULL ENABLE)