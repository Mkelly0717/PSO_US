--------------------------------------------------------
--  Constraints for Table UDT_YIELDRATE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" ADD CONSTRAINT "PK_UDT_YIELDRATE" PRIMARY KEY ("PRIMARY_KEY_COL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("DOCDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("QUANTITY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("PSTDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("PURCHORDER" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("MATDOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("USERNAME" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("MVTTYPETEXT" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("MVT" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("SLOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("BATCH" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("MATERIAL" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_YIELDRATE" MODIFY ("PLANT" NOT NULL ENABLE)