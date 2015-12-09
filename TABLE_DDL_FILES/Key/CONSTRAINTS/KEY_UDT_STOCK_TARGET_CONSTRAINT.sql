--------------------------------------------------------
--  Constraints for Table KEY_UDT_STOCK_TARGET
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" ADD CONSTRAINT "XPKKEY_UDT_STOCK_TARGET" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "STOCK", "MATCODE", "LOC")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("MATCODE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("STOCK" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" MODIFY ("KEY_ID" NOT NULL ENABLE)