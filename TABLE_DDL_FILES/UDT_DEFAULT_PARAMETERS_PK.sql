--------------------------------------------------------
--  DDL for Index UDT_DEFAULT_PARAMETERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."UDT_DEFAULT_PARAMETERS_PK" ON "SCPOMGR"."UDT_DEFAULT_PARAMETERS" ("NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
