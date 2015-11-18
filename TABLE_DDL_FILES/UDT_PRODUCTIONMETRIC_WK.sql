--------------------------------------------------------
--  DDL for Table UDT_PRODUCTIONMETRIC_WK
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_PRODUCTIONMETRIC_WK" 
   (	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR), 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"EFF" DATE, 
	"VALUE" FLOAT(126), 
	"DUR" NUMBER(*,0), 
	"CATEGORY" NUMBER(*,0), 
	"OUTPUTITEM" VARCHAR2(50 CHAR), 
	"CURRENCYUOM" NUMBER(*,0), 
	"QTYUOM" NUMBER(*,0)
   )
