--------------------------------------------------------
--  Constraints for Table UDT_CHECK_TABLES
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_CHECK_TABLES" ADD CONSTRAINT "UDT_CHECK_TABLES_PK" PRIMARY KEY ("RUN_DATE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_CHECK_TABLES" MODIFY ("RUN_DATE" NOT NULL ENABLE)