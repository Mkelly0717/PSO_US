--------------------------------------------------------
--  DDL for Table KEY_UDT_LOC_TYPE
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_LOC_TYPE" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"LOC_TYPE" NUMBER(38,0) DEFAULT 6, 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
