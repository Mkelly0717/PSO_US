--------------------------------------------------------
--  Constraints for Table UDT_PLANT_CAPABILITIES
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" ADD CONSTRAINT "UDT_CAPACITIES_PK" PRIMARY KEY ("CAPABILITY")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" MODIFY ("STATUS" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" MODIFY ("CAPABILITY" NOT NULL ENABLE)
