--------------------------------------------------------
--  DDL for Index XPKRESPENALTY
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."XPKRESPENALTY" ON "SCPOMGR"."RESPENALTY" ("EFF", "CATEGORY", "RES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
