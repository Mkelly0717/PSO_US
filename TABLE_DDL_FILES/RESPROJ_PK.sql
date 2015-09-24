--------------------------------------------------------
--  DDL for Index RESPROJ_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."RESPROJ_PK" ON "SCPOMGR"."RESPROJ" ("RES", "TVQCATEGORY", "EFF") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
