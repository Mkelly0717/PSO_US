--------------------------------------------------------
--  DDL for Index XIF7PRODUCTIONCOST
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF7PRODUCTIONCOST" ON "SCPOMGR"."PRODUCTIONCOST" ("TIEREDCOST") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
