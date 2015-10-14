--------------------------------------------------------
--  DDL for Table PRODREQUIREMENT
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."PRODREQUIREMENT" 
   (	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"SEQNUM" NUMBER(*,0), 
	"STARTDATE" DATE DEFAULT TO_DATE('01/01/1970','DD/MM/YYYY'), 
	"SCHEDDATE" DATE DEFAULT TO_DATE('01/01/1970','DD/MM/YYYY'), 
	"NEEDDATE" DATE DEFAULT TO_DATE('01/01/1970','DD/MM/YYYY'), 
	"QTY" FLOAT(126) DEFAULT 0, 
	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"EXPDATE" DATE DEFAULT TO_DATE('01/01/1970','DD/MM/YYYY'), 
	"COPRODORDERTYPE" NUMBER(1,0) DEFAULT 0, 
	"PRIMARYSEQNUM" NUMBER(*,0) DEFAULT 0, 
	"COPRODPRIMARYITEM" VARCHAR2(50 CHAR) DEFAULT ' '
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA"