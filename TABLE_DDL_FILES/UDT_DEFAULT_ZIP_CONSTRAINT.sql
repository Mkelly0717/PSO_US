--------------------------------------------------------
--  Constraints for Table UDT_DEFAULT_ZIP
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_DEFAULT_ZIP" ADD CONSTRAINT "PK_UDT_DEFAULT_ZIP" PRIMARY KEY ("POSTALCODE", "LOC")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_DEFAULT_ZIP" MODIFY ("LOC" NOT NULL ENABLE)
