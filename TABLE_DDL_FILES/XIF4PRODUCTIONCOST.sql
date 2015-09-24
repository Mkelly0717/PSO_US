--------------------------------------------------------
--  DDL for Index XIF4PRODUCTIONCOST
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF4PRODUCTIONCOST" ON "SCPOMGR"."PRODUCTIONCOST" ("LOCALCOST") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
