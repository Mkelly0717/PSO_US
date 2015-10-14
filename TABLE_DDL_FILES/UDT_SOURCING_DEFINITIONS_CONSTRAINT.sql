--------------------------------------------------------
--  Constraints for Table UDT_SOURCING_DEFINITIONS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "UDT_SOURCING_DEF_CHK_SRC_TYPE" CHECK (SOURCING_TYPE IN ('ISSUE', 'COLLECTION')) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "UDT_SOURCING_DEF_CHK_ZIPTYPE" CHECK (ZIP_TYPE IN ('3', '5', 'NA')) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "TABLE1_PK" PRIMARY KEY ("SOURCING")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" MODIFY ("SOURCING" NOT NULL ENABLE)