--------------------------------------------------------
--  DDL for Table RESOSUPPLYDETAIL
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."RESOSUPPLYDETAIL" 
   (	"PROCESSID" NUMBER(*,0), 
	"DMDORDERSEQNUM" NUMBER(*,0), 
	"SUPPLYSEQNUM" NUMBER(*,0), 
	"LEADTIME" NUMBER(*,0) DEFAULT 0, 
	"SUPPLYQTY" FLOAT(126) DEFAULT 0, 
	"SCHEDDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"NEEDDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"DMDQTY" FLOAT(126) DEFAULT 0, 
	"SUPPLYORDERTYPE" NUMBER(*,0), 
	"PLANLEVEL" NUMBER(*,0), 
	"PROJECTID" NUMBER(*,0), 
	"SCRAPQTY" FLOAT(126) DEFAULT 0, 
	"POSSIBLEQTY" FLOAT(126) DEFAULT 0, 
	"ITEM" VARCHAR2(50 CHAR), 
	"LOC" VARCHAR2(50 CHAR), 
	"SUBSTLOC" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"DMDORDERTYPE" NUMBER(*,0), 
	"SUPPLYORDERSEQNUM" NUMBER(*,0), 
	"DMDNEEDDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"NEEDCOST" FLOAT(126) DEFAULT 0, 
	"USEDCOST" FLOAT(126) DEFAULT 0, 
	"ORDERCOST" FLOAT(126) DEFAULT 0, 
	"SUPPLYACTION" NUMBER(*,0) DEFAULT 0, 
	"SUBSTITEM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"CAPACITYSCHEDDATE" DATE DEFAULT TO_DATE('01/01/1970','MM/DD/YYYY'), 
	"ORDERNUM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"LINENUM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"OPTIONSETNAME" VARCHAR2(255 CHAR) DEFAULT ' '
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "SCPODATA" 

   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."PROCESSID" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."DMDORDERSEQNUM" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."LEADTIME" IS 'Lead time from here up to independent demand'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SUPPLYQTY" IS 'Supply quantity used'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SCHEDDATE" IS 'Scheduled (available) date'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."NEEDDATE" IS 'Required date'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."DMDQTY" IS 'Required quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SUPPLYORDERTYPE" IS 'Supply order type (PO, WO, PSO, ...)'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."PLANLEVEL" IS 'Level in this specific recursion (may not match SupplySku.Llc)'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."PROJECTID" IS 'Numeric "hashed" project code from independent demand'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."POSSIBLEQTY" IS 'How much of this supply is available on the need date (may exceed need quantity).'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."LOC" IS 'Must contain a special location called "ANY" to support location independent BOMs.'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SUBSTLOC" IS 'Must contain a special location called "ANY" to support location independent BOMs.'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."DMDORDERTYPE" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SUPPLYORDERSEQNUM" IS 'The OrderSeqNum of the supply order'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."DMDNEEDDATE" IS ' '
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."NEEDCOST" IS 'Standard cost of demand quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."USEDCOST" IS 'Standard cost of used quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."ORDERCOST" IS 'Standard cost of supply order quantity'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."SUPPLYACTION" IS 'None (0), New (1), Cancel (2), Push (3), Pull (4), Past Due (5), Firm (6), Transfer Order (7), Cancel Damper (8), Push Damper (9), Pull Damper (10), Visual (11).'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."CAPACITYSCHEDDATE" IS 'Capacity Available Date'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."ORDERNUM" IS 'Order number from WO or TO or PO tables'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."LINENUM" IS 'line number from WO.lot or TO.orderline or PO tables'
   COMMENT ON COLUMN "SCPOMGR"."RESOSUPPLYDETAIL"."OPTIONSETNAME" IS 'Reso option set name'
   COMMENT ON TABLE "SCPOMGR"."RESOSUPPLYDETAIL"  IS 'Detailed output from RESO'
