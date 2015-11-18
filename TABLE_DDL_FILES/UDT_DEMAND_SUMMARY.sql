--------------------------------------------------------
--  DDL for Table UDT_DEMAND_SUMMARY
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_DEMAND_SUMMARY" 
   (	"DDS_ITEM" VARCHAR2(50 CHAR), 
	"DUMS_ITEM" VARCHAR2(50 CHAR), 
	"DMS_ITEM" VARCHAR2(50 CHAR), 
	"TOTALDEMAND" NUMBER, 
	"TOTALUNMET" NUMBER, 
	"TOTALMET" NUMBER, 
	"%unmetofmet" NUMBER, 
	"%unmetofall" NUMBER
   )
