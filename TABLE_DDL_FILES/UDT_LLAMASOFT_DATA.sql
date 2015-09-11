--------------------------------------------------------
--  DDL for Table UDT_LLAMASOFT_DATA
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_LLAMASOFT_DATA" 
   (	"ITEM" VARCHAR2(20), 
	"SOURCE" VARCHAR2(50), 
	"SOURCE_PC" VARCHAR2(10), 
	"DEST" VARCHAR2(50), 
	"DEST_PC" VARCHAR2(10), 
	"TRANSLEADTIME" NUMBER, 
	"PRIORITY" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
