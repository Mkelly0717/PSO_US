--------------------------------------------------------
--  Constraints for Table UDT_DFUVIEW_ABC_CLASS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_DFUVIEW_ABC_CLASS" ADD CONSTRAINT "PK_UDT_DFUVIEW_ABC_CLASS" PRIMARY KEY ("COUNTRY", "DMDUNIT", "DMDGROUP", "LOC")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE