--------------------------------------------------------
--  Ref Constraints for Table UDT_YIELD
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_YIELD" ADD CONSTRAINT "UDT_YIELD_LOC_FK1" FOREIGN KEY ("LOC")
	  REFERENCES "SCPOMGR"."LOC" ("LOC") ENABLE;
