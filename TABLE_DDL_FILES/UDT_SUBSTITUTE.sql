--------------------------------------------------------
--  DDL for Table UDT_SUBSTITUTE
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_SUBSTITUTE" 
   (	"COUNTRY" VARCHAR2(2 CHAR), 
	"PARENT" VARCHAR2(15 CHAR), 
	"SUBORD" VARCHAR2(15 CHAR), 
	"BOMNUM" NUMBER(*,0), 
	"LOC" VARCHAR2(50 CHAR), 
	"UNIT_COST" NUMBER(22,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"