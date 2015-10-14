--------------------------------------------------------
--  DDL for Index PRODPROJ_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."PRODPROJ_PK" ON "SCPOMGR"."PRODPROJ" ("PRODUCTIONMETHOD", "ITEM", "LOC", "TVQCATEGORY", "EFF", "OUTPUTITEM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
