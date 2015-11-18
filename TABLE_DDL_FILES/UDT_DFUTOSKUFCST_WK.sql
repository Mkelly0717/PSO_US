--------------------------------------------------------
--  DDL for Table UDT_DFUTOSKUFCST_WK
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_DFUTOSKUFCST_WK" 
   (	"ITEM" VARCHAR2(50 CHAR), 
	"SKULOC" VARCHAR2(50 CHAR), 
	"DMDUNIT" VARCHAR2(50 CHAR), 
	"DMDGROUP" VARCHAR2(50 CHAR), 
	"DFULOC" VARCHAR2(50 CHAR), 
	"STARTDATE" DATE, 
	"DUR" NUMBER(38,0), 
	"TYPE" NUMBER(38,0), 
	"TOTFCST" FLOAT(126), 
	"SUPERSEDESW" NUMBER(1,0), 
	"FF_TRIGGER_CONTROL" NUMBER(*,0)
   )
