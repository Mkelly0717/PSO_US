--------------------------------------------------------
--  Constraints for Table UDT_STOCK_TARGET
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_STOCK_TARGET" ADD CONSTRAINT "PK_UDT_STOCK_TARGET" PRIMARY KEY ("LOC", "MATCODE", "STOCK")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_STOCK_TARGET" MODIFY ("STOCK" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_STOCK_TARGET" MODIFY ("MATCODE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_STOCK_TARGET" MODIFY ("LOC" NOT NULL ENABLE)
