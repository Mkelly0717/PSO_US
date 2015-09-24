--------------------------------------------------------
--  DDL for Index PRODUCTIONTARGET_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."PRODUCTIONTARGET_PK" ON "SCPOMGR"."PRODUCTIONTARGET" ("PRODUCTIONMETHOD", "ITEM", "LOC", "OUTPUTITEM", "EFF") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
