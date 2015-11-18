--------------------------------------------------------
--  DDL for Table KEY_UDT_SUBSTITUTE
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_SUBSTITUTE" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"PARENT" VARCHAR2(60 CHAR), 
	"SUBORD" VARCHAR2(60 CHAR), 
	"COUNTRY" VARCHAR2(8 CHAR), 
	"BOMNUM" NUMBER, 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
