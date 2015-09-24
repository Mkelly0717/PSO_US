--------------------------------------------------------
--  Constraints for Table RESOINDEPENDENTDMD
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" ADD CONSTRAINT "XPKRESOINDEPENDENTDMD" PRIMARY KEY ("PROCESSID", "DMDORDERTYPE", "DMDORDERSEQNUM", "NEEDDATE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" ADD CONSTRAINT "CAPACITYSTATUS" CHECK (capacitystatus in (-1,1,2,3)) ENABLE
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" ADD CONSTRAINT "EXCEPTION_STATUS" CHECK (Status IN (1, 2, 3)) ENABLE
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("OPTIONSETNAME" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("CAPACITYSTATUS" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("CAPACITYSCHEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("PRIORITY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("PEGSETNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("DMDQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("NEEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("ITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("POSSIBLEQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("STDCOST" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("LINENUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("ORDERNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("MARGIN" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("REVENUE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("SCHEDDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("COSTINVEST" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("STATUS" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("DMDORDERSEQNUM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("DMDORDERTYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" MODIFY ("PROCESSID" NOT NULL ENABLE)