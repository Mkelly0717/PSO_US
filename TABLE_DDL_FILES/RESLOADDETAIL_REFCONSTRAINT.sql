--------------------------------------------------------
--  Ref Constraints for Table RESLOADDETAIL
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESLOADDETAIL" ADD CONSTRAINT "RESLOADDETAIL_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
