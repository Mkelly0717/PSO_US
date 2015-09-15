--------------------------------------------------------
--  DDL for Index UDT_COST_TRANIST_NEW_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."UDT_COST_TRANIST_NEW_PK" ON "SCPOMGR"."UDT_COST_TRANSIT" ("DIRECTION", "U_EQUIPMENT_TYPE", "SOURCE_PC", "DEST_PC", "SOURCE_GEO", "DEST_GEO", "SOURCE_CO", "DEST_CO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
