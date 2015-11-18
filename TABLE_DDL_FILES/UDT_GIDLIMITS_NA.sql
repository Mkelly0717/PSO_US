--------------------------------------------------------
--  DDL for Table UDT_GIDLIMITS_NA
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_GIDLIMITS_NA" 
   (	"LOC" VARCHAR2(50 CHAR), 
	"DESCR" VARCHAR2(50 CHAR), 
	"COUNTRY" VARCHAR2(20 CHAR), 
	"MATCODE" VARCHAR2(5 CHAR), 
	"MANDATORY_LOC" VARCHAR2(4 CHAR), 
	"MANDATORY_CO" VARCHAR2(4 CHAR), 
	"FORBIDDEN_LOC" VARCHAR2(4 CHAR), 
	"FORBIDDEN_CO" VARCHAR2(4 CHAR), 
	"PRIMARY_KEY_COL" NUMBER, 
	"U_LOC_TYPE" NUMBER, 
	"ITEM" VARCHAR2(25 CHAR), 
	"EXCLUSIVE_LOC" VARCHAR2(25 CHAR), 
	"DE" VARCHAR2(1 CHAR)
   )
