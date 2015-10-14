--------------------------------------------------------
--  DDL for Table UDT_YIELDRATE
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_YIELDRATE" 
   (	"PLANT" VARCHAR2(4 CHAR), 
	"MATERIAL" VARCHAR2(10 CHAR), 
	"BATCH" VARCHAR2(25 CHAR), 
	"SLOC" VARCHAR2(4 CHAR), 
	"MVT" VARCHAR2(3 CHAR), 
	"MVTTYPETEXT" VARCHAR2(55 CHAR), 
	"USERNAME" VARCHAR2(55 CHAR), 
	"MATDOC" VARCHAR2(25 CHAR), 
	"PURCHORDER" VARCHAR2(25 CHAR), 
	"PSTDATE" DATE, 
	"QUANTITY" NUMBER(*,0), 
	"DOCDATE" DATE, 
	"PRIMARY_KEY_COL" NUMBER, 
	"PRODUCTIONMETHOD" VARCHAR2(4 CHAR) DEFAULT ' '
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
