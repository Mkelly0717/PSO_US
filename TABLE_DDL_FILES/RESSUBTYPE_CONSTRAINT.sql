--------------------------------------------------------
--  Constraints for Table RESSUBTYPE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESSUBTYPE" ADD CONSTRAINT "XPKRESSUBTYPE" PRIMARY KEY ("SUBTYPE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."RESSUBTYPE" ADD CONSTRAINT "BOOL_RESSUBTYPE_IS_DEFAULT" CHECK (Is_Default IN (0, 1)) ENABLE
  ALTER TABLE "SCPOMGR"."RESSUBTYPE" MODIFY ("IS_DEFAULT" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."RESSUBTYPE" MODIFY ("SUBTYPE" NOT NULL ENABLE)
