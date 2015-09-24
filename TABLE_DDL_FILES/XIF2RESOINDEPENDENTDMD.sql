--------------------------------------------------------
--  DDL for Index XIF2RESOINDEPENDENTDMD
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF2RESOINDEPENDENTDMD" ON "SCPOMGR"."RESOINDEPENDENTDMD" ("LOC", "ITEM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
