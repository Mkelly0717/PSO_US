--------------------------------------------------------
--  DDL for Table KEY_UDT_COST_UNIT
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_COST_UNIT" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"PROCESS" VARCHAR2(60 CHAR), 
	"MATCODE" VARCHAR2(20 CHAR), 
	"LOC" VARCHAR2(200 CHAR), 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
