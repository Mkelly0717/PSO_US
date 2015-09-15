--------------------------------------------------------
--  Constraints for Table UDT_AREA
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_AREA" ADD PRIMARY KEY ("COMPANYID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_AREA" MODIFY ("U_AREA" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_AREA" MODIFY ("COMPANYID" NOT NULL ENABLE)
