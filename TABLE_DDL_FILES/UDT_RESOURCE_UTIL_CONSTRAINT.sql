--------------------------------------------------------
--  Constraints for Table UDT_RESOURCE_UTIL
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_RESOURCE_UTIL" ADD CONSTRAINT "UDT_RESOURCE_UTIL_PK" PRIMARY KEY ("RES")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_RESOURCE_UTIL" MODIFY ("RES" NOT NULL ENABLE)
