--------------------------------------------------------
--  Constraints for Table KEY_UDT_TERRITORY
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" ADD CONSTRAINT "XPKKEY_UDT_TERRITORY" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "POSTALCODE")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("POSTALCODE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_TERRITORY" MODIFY ("KEY_ID" NOT NULL ENABLE)
