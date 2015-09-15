--------------------------------------------------------
--  DDL for Table UDT_CONSTRAINED_COLLECTION
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_CONSTRAINED_COLLECTION" 
   (	"LOC" VARCHAR2(50 CHAR), 
	"QTY" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
