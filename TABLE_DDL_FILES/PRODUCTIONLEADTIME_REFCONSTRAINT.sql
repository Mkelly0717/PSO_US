--------------------------------------------------------
--  Ref Constraints for Table PRODUCTIONLEADTIME
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONLEADTIME" ADD CONSTRAINT "PRODLEADTIME_PRODMETHOD_FK1" FOREIGN KEY ("PRODUCTIONMETHOD", "ITEM", "LOC")
	  REFERENCES "SCPOMGR"."PRODUCTIONMETHOD" ("PRODUCTIONMETHOD", "ITEM", "LOC") ON DELETE CASCADE ENABLE
