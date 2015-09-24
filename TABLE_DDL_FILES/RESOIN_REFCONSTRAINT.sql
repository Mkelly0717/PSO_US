--------------------------------------------------------
--  Ref Constraints for Table RESOIN
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESOIN" ADD CONSTRAINT "RESOIN_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
