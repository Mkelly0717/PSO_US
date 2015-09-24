--------------------------------------------------------
--  Constraints for Table RESCONSTRAINT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" ADD CONSTRAINT "XPKRESCONSTRAINT" PRIMARY KEY ("EFF", "CATEGORY", "RES")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" ADD CONSTRAINT "CHK_RESCONSTRAINT_DUR" CHECK (Dur >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" ADD CONSTRAINT "CHK_RESCONSTRAINT_QTY" CHECK (Qty >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" ADD CONSTRAINT "CONSTRAINT_POLICY5" CHECK (Policy IN (0, 1, 2)) ENABLE
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("QTYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("TIMEUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("RES" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("CATEGORY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("DUR" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("QTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("POLICY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESCONSTRAINT" MODIFY ("EFF" NOT NULL ENABLE)
