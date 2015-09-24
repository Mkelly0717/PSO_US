--------------------------------------------------------
--  Constraints for Table RESMETRIC
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESMETRIC" ADD CONSTRAINT "XPKRESMETRIC" PRIMARY KEY ("EFF", "SETUP", "CATEGORY", "RES")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."RESMETRIC" ADD CONSTRAINT "CHK_RESMETRIC_DUR" CHECK (Dur >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("SETUP" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("QTYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("TIMEUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("CURRENCYUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("RES" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("CATEGORY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("DUR" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("VALUE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESMETRIC" MODIFY ("EFF" NOT NULL ENABLE)
