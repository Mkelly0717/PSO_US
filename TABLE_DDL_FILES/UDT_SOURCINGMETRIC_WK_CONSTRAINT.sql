--------------------------------------------------------
--  Constraints for Table UDT_SOURCINGMETRIC_WK
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" ADD CONSTRAINT "PK_UDT_SOURCINGMETRIC_WK" PRIMARY KEY ("ITEM", "DEST", "SOURCE", "SOURCING", "EFF", "CATEGORY")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("QTYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("CURRENCYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("CATEGORY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("DUR" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("VALUE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("EFF" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("SOURCE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("DEST" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("ITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_SOURCINGMETRIC_WK" MODIFY ("SOURCING" NOT NULL ENABLE)
