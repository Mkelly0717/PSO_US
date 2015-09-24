--------------------------------------------------------
--  DDL for Table RES_BKP_23APR2015
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."RES_BKP_23APR2015" 
   (	"SOURCE" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"TYPE" NUMBER, 
	"RES" VARCHAR2(101 CHAR), 
	"DESCR" VARCHAR2(50 CHAR), 
	"ENABLESW" NUMBER(1,0), 
	"ADJFACTOR" FLOAT(126), 
	"CHECKMAXCAP" NUMBER(*,0), 
	"SUBTYPE" NUMBER(*,0), 
	"QTYUOM" NUMBER(*,0), 
	"CURRENCYUOM" NUMBER(*,0), 
	"CAL" VARCHAR2(50 CHAR), 
	"AVGFAMILYCHG" FLOAT(126), 
	"AVGSKUCHG" FLOAT(126), 
	"AVGSKUCHGCOST" FLOAT(126), 
	"AVGFAMILYCHGCOST" FLOAT(126), 
	"COST" FLOAT(126), 
	"LEVELLOADSW" NUMBER(1,0), 
	"LEVELSEQNUM" NUMBER(*,0), 
	"CRITICALITEM" VARCHAR2(50 CHAR), 
	"UNITPENALTY" FLOAT(126), 
	"PRODUCTIONFAMILYCHGOVEROPT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
