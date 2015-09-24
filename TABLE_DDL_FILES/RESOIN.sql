--------------------------------------------------------
--  DDL for Table RESOIN
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."RESOIN" 
   (	"PROCESSID" NUMBER(*,0), 
	"DMDORDERTYPE" NUMBER(*,0), 
	"DMDORDERSEQNUM" NUMBER(*,0), 
	"STDCOST" FLOAT(126) DEFAULT 0, 
	"PROJECTID" NUMBER(*,0), 
	"SUBSTLEVEL" NUMBER(*,0) DEFAULT 0, 
	"SUBSTOPERATOR" NUMBER(*,0) DEFAULT 0, 
	"NEEDDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"DMDQTY" FLOAT(126) DEFAULT 0, 
	"PRIORITY" NUMBER(*,0), 
	"REVENUE" FLOAT(126) DEFAULT 0, 
	"ORDERNUM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"LINENUM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"PEGSETNUM" NUMBER(*,0) DEFAULT 0, 
	"OPTIONSETNAME" VARCHAR2(255 CHAR) DEFAULT ' '
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA" 

   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."PROCESSID" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."DMDORDERTYPE" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."DMDORDERSEQNUM" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."STDCOST" IS 'Standard cost of need quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."PROJECTID" IS 'Numeric "hashed" project code from independent demand'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."SUBSTLEVEL" IS 'Substitution level'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."SUBSTOPERATOR" IS 'Substitution operator'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."NEEDDATE" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."DMDQTY" IS 'Required quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."PRIORITY" IS 'Used to sort independent demands'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."REVENUE" IS 'Revenue for this order (information only)'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."ORDERNUM" IS 'Order identifier'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."LINENUM" IS 'Line number'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."LOC" IS 'Must contain a special location called "ANY" to support location independent BOMs.'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."PEGSETNUM" IS 'Used for sorting the independent demands within a priority'
   COMMENT ON COLUMN "SCPOMGR"."RESOIN"."OPTIONSETNAME" IS 'Reso Fetch option set name'
   COMMENT ON TABLE "SCPOMGR"."RESOIN"  IS 'RESO input; generated from SupplyPlanResult by Fetch process'