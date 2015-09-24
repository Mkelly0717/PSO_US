--------------------------------------------------------
--  DDL for Table PRODUCTIONYIELD
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."PRODUCTIONYIELD" 
   (	"YIELDQTY" FLOAT(126) DEFAULT 0, 
	"ITEM" VARCHAR2(50 CHAR), 
	"OUTPUTITEM" VARCHAR2(50 CHAR), 
	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"LOC" VARCHAR2(50 CHAR), 
	"EFF" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"QTYUOM" NUMBER(*,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" 

   COMMENT ON COLUMN "SCPOMGR"."PRODUCTIONYIELD"."YIELDQTY" IS 'The YieldQty for the co-product specified in terms of the QtyUOM for the associated co-product SKU.'
   COMMENT ON TABLE "SCPOMGR"."PRODUCTIONYIELD"  IS 'The CoProduction table specifies the co/by-products produced via a given production method. Only the co-products are specified in the CoProduction table. The primary output SKU and its associated yield is specified in the ProductionMethod table itself.'
