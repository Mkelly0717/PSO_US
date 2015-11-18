--------------------------------------------------------
--  Constraints for Table UDT_IGPERROR_STATS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_IGPERROR_STATS" ADD CONSTRAINT "UDT_IGPERROR_STATS_PK" PRIMARY KEY ("RUN_DATE")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_IGPERROR_STATS" MODIFY ("RUN_DATE" NOT NULL ENABLE)
