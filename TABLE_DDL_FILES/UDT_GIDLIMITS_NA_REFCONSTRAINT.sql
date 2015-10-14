--------------------------------------------------------
--  Ref Constraints for Table UDT_GIDLIMITS_NA
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_GIDLIMITS_NA" ADD CONSTRAINT "UDT_GIDLIMITS_NA_LOC_FK1" FOREIGN KEY ("MANDATORY_LOC")
	  REFERENCES "SCPOMGR"."LOC" ("LOC") ENABLE
