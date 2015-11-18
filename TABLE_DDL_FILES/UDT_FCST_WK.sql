--------------------------------------------------------
--  DDL for Table UDT_FCST_WK
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_FCST_WK" 
   (	"DMDUNIT" VARCHAR2(50 CHAR), 
	"DMDGROUP" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"STARTDATE" DATE, 
	"DUR" NUMBER, 
	"TYPE" NUMBER, 
	"FCSTID" VARCHAR2(50 CHAR), 
	"QTY" FLOAT(126), 
	"MODEL" VARCHAR2(18 CHAR), 
	"LEWMEANQTY" FLOAT(126), 
	"MARKETMGRVERSIONID" NUMBER(38,0)
   )
