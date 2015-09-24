--------------------------------------------------------
--  DDL for Index RESPROJSTATIC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."RESPROJSTATIC_PK" ON "SCPOMGR"."RESPROJSTATIC" ("LOC", "RES", "STARTDATE", "OPTIONSET") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
