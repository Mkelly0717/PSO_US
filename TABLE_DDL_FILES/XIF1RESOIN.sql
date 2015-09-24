--------------------------------------------------------
--  DDL for Index XIF1RESOIN
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF1RESOIN" ON "SCPOMGR"."RESOIN" ("ITEM", "LOC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
