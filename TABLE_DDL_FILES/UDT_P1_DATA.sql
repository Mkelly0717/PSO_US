--------------------------------------------------------
--  DDL for Table UDT_P1_DATA
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_P1_DATA" 
   (	"DATE" DATE, 
	"SM_RANK" NUMBER, 
	"LS_PRIORITY" NUMBER, 
	"CT_RANK" NUMBER, 
	"LS_ITEM" VARCHAR2(20), 
	"LS_DEST" VARCHAR2(50), 
	"LS_SRC" VARCHAR2(50), 
	"CT_SOURCE_PC" VARCHAR2(8 CHAR), 
	"CT_DEST_PC" VARCHAR2(8 CHAR), 
	"CT_COST" NUMBER, 
	"CT_TLT" NUMBER, 
	"LS_TLT" NUMBER, 
	"SM_SOURCING" VARCHAR2(50 CHAR), 
	"SM_VALUE" NUMBER, 
	"CT_ET" VARCHAR2(50), 
	"CT_DIR" VARCHAR2(2 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;