--------------------------------------------------------
--  Constraints for Table PRODUCTIONPENALTY
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" ADD CONSTRAINT "XPKPRODUCTIONPENALTY" PRIMARY KEY ("CATEGORY", "PRODUCTIONMETHOD", "ITEM", "OUTPUTITEM", "LOC", "EFF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" ADD CONSTRAINT "CHK_PRODUCTIONPENALTY_RATE" CHECK (Rate >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("CURRENCYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("QTYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("OUTPUTITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("ITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("CATEGORY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("RATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("EFF" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONPENALTY" MODIFY ("PRODUCTIONMETHOD" NOT NULL ENABLE)