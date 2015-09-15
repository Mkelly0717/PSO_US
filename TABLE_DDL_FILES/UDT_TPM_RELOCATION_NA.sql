--------------------------------------------------------
--  DDL for Table UDT_TPM_RELOCATION_NA
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_TPM_RELOCATION_NA" 
   (	"SOURCE" VARCHAR2(50 CHAR), 
	"DEST" VARCHAR2(50 CHAR), 
	"MATCODE" CHAR(4 CHAR), 
	"QB" CHAR(2 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"