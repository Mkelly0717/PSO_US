--------------------------------------------------------
--  DDL for Table PRODUCTIONFAMILYSKULOAD
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."PRODUCTIONFAMILYSKULOAD" 
   (	"PLANNAME" VARCHAR2(50 CHAR), 
	"RES" VARCHAR2(101 CHAR), 
	"PRODFAMILY" VARCHAR2(50 CHAR), 
	"STARTDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"SEQNUM" NUMBER DEFAULT 0, 
	"LOAD" FLOAT(126) DEFAULT 0.0, 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR), 
	"STEPNUM" NUMBER(*,0) DEFAULT 0, 
	"SUPPLYTYPE" NUMBER(1,0) DEFAULT 0, 
	"LOADSEQNUM" NUMBER DEFAULT 0, 
	"ORGWHENLOADED" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA"
