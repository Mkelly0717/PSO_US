--------------------------------------------------------
--  DDL for Table PRODUCTIONLEADTIME
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."PRODUCTIONLEADTIME" 
   (	"CALCLEADTIME" NUMBER(*,0) DEFAULT 0, 
	"EFF" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"PRODUCTIONMETHOD" VARCHAR2(50 CHAR) DEFAULT ' '
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA" 

   COMMENT ON TABLE "SCPOMGR"."PRODUCTIONLEADTIME"  IS 'The ProductionLeadTime table is an output table of the NetWORKS Strategy pre-processor. This table will be populated with the calculated lead-time for each production method.'
