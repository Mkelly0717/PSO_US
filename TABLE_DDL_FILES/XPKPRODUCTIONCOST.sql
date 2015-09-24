--------------------------------------------------------
--  DDL for Index XPKPRODUCTIONCOST
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."XPKPRODUCTIONCOST" ON "SCPOMGR"."PRODUCTIONCOST" ("CATEGORY", "PRODUCTIONMETHOD", "ITEM", "LOC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
