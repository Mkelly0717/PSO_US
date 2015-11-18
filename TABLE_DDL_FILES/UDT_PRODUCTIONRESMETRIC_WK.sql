--------------------------------------------------------
--  DDL for Table UDT_PRODUCTIONRESMETRIC_WK
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_PRODUCTIONRESMETRIC_WK" 
   (	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR), 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"EFF" DATE, 
	"VALUE" FLOAT(126), 
	"DUR" NUMBER(*,0), 
	"CATEGORY" NUMBER(*,0), 
	"RES" VARCHAR2(101 CHAR), 
	"CURRENCYUOM" NUMBER(*,0), 
	"QTYUOM" NUMBER(*,0)
   )
