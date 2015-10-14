--------------------------------------------------------
--  DDL for Table FCSTTEMP
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."FCSTTEMP" 
   (	"PROCESSID" NUMBER(10,0), 
	"BATCHNUM" NUMBER(10,0), 
	"DMDUNIT" VARCHAR2(50 CHAR), 
	"DMDGROUP" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"MODEL" VARCHAR2(50 CHAR), 
	"DUR" NUMBER(*,0) DEFAULT 0, 
	"TYPE" NUMBER(*,0), 
	"FCSTID" VARCHAR2(50 CHAR), 
	"QTY" FLOAT(126) DEFAULT 0.000000, 
	"LEWMEANQTY" FLOAT(126) DEFAULT 0, 
	"MARKETMGRVERSIONID" NUMBER(38,0) DEFAULT -1, 
	"STARTDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA"