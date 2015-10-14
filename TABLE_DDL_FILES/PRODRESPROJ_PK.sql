--------------------------------------------------------
--  DDL for Index PRODRESPROJ_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."PRODRESPROJ_PK" ON "SCPOMGR"."PRODRESPROJ" ("PRODUCTIONMETHOD", "ITEM", "LOC", "RES", "TVQCATEGORY", "EFF") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
