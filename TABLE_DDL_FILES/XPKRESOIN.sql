--------------------------------------------------------
--  DDL for Index XPKRESOIN
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."XPKRESOIN" ON "SCPOMGR"."RESOIN" ("PROCESSID", "DMDORDERTYPE", "DMDORDERSEQNUM", "NEEDDATE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
