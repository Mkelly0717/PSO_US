--------------------------------------------------------
--  Constraints for Table UDT_RATE_TYPE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_RATE_TYPE" ADD CONSTRAINT "UDT_RATE_TYPE_PK" PRIMARY KEY ("U_RATE_TYPE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_RATE_TYPE" MODIFY ("DESCRIPTION" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_RATE_TYPE" MODIFY ("U_RATE_TYPE" NOT NULL ENABLE)
