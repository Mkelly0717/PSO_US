--------------------------------------------------------
--  DDL for Index PK_UDT_DFUVIEW_ABC_CLASS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."PK_UDT_DFUVIEW_ABC_CLASS" ON "SCPOMGR"."UDT_DFUVIEW_ABC_CLASS" ("COUNTRY", "DMDUNIT", "DMDGROUP", "LOC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
