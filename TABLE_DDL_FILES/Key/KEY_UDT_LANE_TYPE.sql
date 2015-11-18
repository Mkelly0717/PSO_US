--------------------------------------------------------
--  DDL for Table KEY_UDT_LANE_TYPE
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."KEY_UDT_LANE_TYPE" 
   (	"KEY_ID" FLOAT(126) DEFAULT 0, 
	"KEY_TYPE" CHAR(1 CHAR), 
	"LANE_TYPE" VARCHAR2(20 CHAR) DEFAULT ' ', 
	"SESSION_ID" VARCHAR2(75 CHAR), 
	"CREATE_DATE" DATE, 
	"VIEW_ID" VARCHAR2(513 CHAR)
   )
