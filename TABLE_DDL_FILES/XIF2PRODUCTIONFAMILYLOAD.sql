--------------------------------------------------------
--  DDL for Index XIF2PRODUCTIONFAMILYLOAD
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIF2PRODUCTIONFAMILYLOAD" ON "SCPOMGR"."PRODUCTIONFAMILYLOAD" ("PRODFAMILY") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
