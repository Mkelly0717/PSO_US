--------------------------------------------------------
--  Constraints for Table PRODUCTIONTARGET
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" ADD CONSTRAINT "PRODUCTIONTARGET_PK" PRIMARY KEY ("PRODUCTIONMETHOD", "ITEM", "LOC", "OUTPUTITEM", "EFF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("QTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("DISC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("EFF" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("OUTPUTITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("ITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" MODIFY ("PRODUCTIONMETHOD" NOT NULL ENABLE)