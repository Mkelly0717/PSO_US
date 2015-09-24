--------------------------------------------------------
--  Constraints for Table RESLOADDETAIL
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SUPPLYORDERNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" ADD CONSTRAINT "RESLOADDETAIL_PK" PRIMARY KEY ("ITEM", "LOC", "RES", "SUPPLYTYPE", "PRODUCTIONMETHOD", "STEPNUM", "WHENLOADED", "PROCESSID", "SOURCE", "EXPDATE", "NEEDDATE", "SCHEDDATE", "SUPPLYSEQNUM", "STARTDATE", "DMDNEEDDATE", "DMDORDERSEQNUM", "DMDORDERTYPE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("OPTIONSETNAME" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SUPPLYORDERSEQNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("DMDORDERTYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("DMDORDERSEQNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("DMDNEEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("ROUTINGNEEDCOMPLETEDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("OFFSET" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("PROCESSID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("EXPDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SCHEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("NEEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SOURCE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SUPPLYSEQNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("STARTDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SUPPLYQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SSLOADQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("FCSTORDLOADQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("CUSTORDLOADQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("RESLOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SOURCEOPT" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("LOADQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("WHENLOADED" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("STEPNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("PRODUCTIONMETHOD" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("SUPPLYTYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("RES" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" MODIFY ("ITEM" NOT NULL ENABLE)
