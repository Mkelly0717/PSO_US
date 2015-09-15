--------------------------------------------------------
--  DDL for Table UDT_SKUMETRIC_WK
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_SKUMETRIC_WK" 
   (	"EFF" DATE, 
	"DUR" NUMBER(*,0), 
	"VALUE" FLOAT(126), 
	"CATEGORY" NUMBER(*,0), 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"CURRENCYUOM" NUMBER(*,0), 
	"QTYUOM" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" 
  PARALLEL 8