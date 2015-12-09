--------------------------------------------------------
--  DDL for Table KEY_UDT_EQUIPMENT_CONVERSION
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_EQUIPMENT_CONVERSION" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"U_EQUIPMENT_TYPE" VARCHAR2(20 CHAR) DEFAULT ' ', 
	"U_AREA" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"EQUIPMENT_NATIVE" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"COMPANYID" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )