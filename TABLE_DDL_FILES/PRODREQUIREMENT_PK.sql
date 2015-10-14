--------------------------------------------------------
--  DDL for Index PRODREQUIREMENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."PRODREQUIREMENT_PK" ON "SCPOMGR"."PRODREQUIREMENT" ("ITEM", "LOC", "SEQNUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"
