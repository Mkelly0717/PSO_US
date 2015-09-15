--------------------------------------------------------
--  DDL for Table UDT_COUNTRY_GLID_MAT_QTY
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_COUNTRY_GLID_MAT_QTY" 
   (	"COUNTRY" VARCHAR2(50 CHAR), 
	"GLID" VARCHAR2(50 CHAR), 
	"MATERIAL_CODE" VARCHAR2(50 CHAR), 
	"DMDGROUP" VARCHAR2(50 CHAR), 
	"QTY" FLOAT(126)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"
