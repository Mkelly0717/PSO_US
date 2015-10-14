--------------------------------------------------------
--  DDL for Index PRODITEMPROJ_PRODMETHOD_FK
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."PRODITEMPROJ_PRODMETHOD_FK" ON "SCPOMGR"."PRODITEMPROJ" ("PRODUCTIONMETHOD", "ITEM", "LOC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
