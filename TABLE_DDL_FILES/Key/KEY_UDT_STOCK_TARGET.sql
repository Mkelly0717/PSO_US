--------------------------------------------------------
--  DDL for Table KEY_UDT_STOCK_TARGET
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_STOCK_TARGET" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"STOCK" VARCHAR2(200 CHAR), 
	"MATCODE" VARCHAR2(40 CHAR), 
	"LOC" VARCHAR2(200 CHAR), 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
