--------------------------------------------------------
--  Ref Constraints for Table RESLOADREQUIREMENT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESLOADREQUIREMENT" ADD CONSTRAINT "RESLOADREQUIREMENT_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
