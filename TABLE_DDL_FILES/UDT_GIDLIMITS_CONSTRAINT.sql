--------------------------------------------------------
--  Constraints for Table UDT_GIDLIMITS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS" MODIFY ("U_LOC_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS" ADD CONSTRAINT "PK_UDT_GIDLIMITS" PRIMARY KEY ("PRIMARY_KEY_COL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS" ADD CONSTRAINT "UDT_GIDLIMITS_C03" CHECK (MATCODE IS NOT NULL) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS" ADD CONSTRAINT "UDT_GIDLIMITS_C02" CHECK (COUNTRY IS NOT NULL) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS" MODIFY ("LOC" NOT NULL ENABLE)
