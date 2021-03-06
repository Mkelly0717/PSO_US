--------------------------------------------------------
--  Constraints for Table KEY_UDT_COST_TRANSIT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("KEY_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("KEY_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" ADD CONSTRAINT "XPKKEY_UDT_COST_TRANSIT" PRIMARY KEY ("KEY_ID", "KEY_TYPE", "DIRECTION", "SOURCE_CO", "SOURCE_PC", "DEST_GEO", "SOURCE_GEO", "U_EQUIPMENT_TYPE", "DEST_PC", "DEST_CO")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("VIEW_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("CREATE_DATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("SESSION_ID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("DEST_CO" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("DEST_PC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("U_EQUIPMENT_TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("SOURCE_GEO" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("DEST_GEO" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("SOURCE_PC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("SOURCE_CO" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."KEY_UDT_COST_TRANSIT" MODIFY ("DIRECTION" NOT NULL ENABLE)
