--------------------------------------------------------
--  DDL for Index XIF6PRODUCTIONCOST
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF6PRODUCTIONCOST" ON "SCPOMGR"."PRODUCTIONCOST" ("PRODUCTIONMETHOD", "ITEM", "LOC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
