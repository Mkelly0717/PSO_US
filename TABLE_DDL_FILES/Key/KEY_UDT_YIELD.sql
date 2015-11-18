--------------------------------------------------------
--  DDL for Table KEY_UDT_YIELD
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_YIELD" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"PRODUCTIONMETHOD" VARCHAR2(12 CHAR), 
	"ITEM" VARCHAR2(60 CHAR), 
	"LOC" VARCHAR2(16 CHAR), 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
