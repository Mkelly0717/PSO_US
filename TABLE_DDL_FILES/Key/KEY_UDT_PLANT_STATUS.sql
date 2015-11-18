--------------------------------------------------------
--  DDL for Table KEY_UDT_PLANT_STATUS
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_PLANT_STATUS" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"RES" VARCHAR2(120 CHAR), 
	"U_STOCK" VARCHAR2(120 CHAR), 
	"U_MATERIALCODE" VARCHAR2(120 CHAR), 
	"LOC" VARCHAR2(120 CHAR), 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
