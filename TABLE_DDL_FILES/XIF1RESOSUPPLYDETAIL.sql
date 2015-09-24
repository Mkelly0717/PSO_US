--------------------------------------------------------
--  DDL for Index XIF1RESOSUPPLYDETAIL
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF1RESOSUPPLYDETAIL" ON "SCPOMGR"."RESOSUPPLYDETAIL" ("LOC", "ITEM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
