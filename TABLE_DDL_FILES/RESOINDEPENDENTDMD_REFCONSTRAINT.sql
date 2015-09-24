--------------------------------------------------------
--  Ref Constraints for Table RESOINDEPENDENTDMD
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESOINDEPENDENTDMD" ADD CONSTRAINT "RESOINDEPENDENTDMD_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
