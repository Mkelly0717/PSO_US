--------------------------------------------------------
--  DDL for Index XPKPRODUCTIONFAMILYLOAD
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."XPKPRODUCTIONFAMILYLOAD" ON "SCPOMGR"."PRODUCTIONFAMILYLOAD" ("PLANNAME", "RES", "PRODFAMILY", "CHGOVERPRODFAMILY", "STARTDATE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"