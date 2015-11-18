--------------------------------------------------------
--  DDL for Table UDT_RESOURCE_WEEKLY_UTIL
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_RESOURCE_WEEKLY_UTIL" 
   (	"RES" VARCHAR2(101 CHAR), 
	"EFF" DATE, 
	"VALUE" FLOAT(126), 
	"QTY" FLOAT(126), 
	"PERCENTWEEKLYUTIL" FLOAT(126), 
	"RM_CATEGORY" NUMBER(*,0), 
	"CATEGORY" NUMBER(*,0), 
	"POLICY" NUMBER(*,0)
   )
