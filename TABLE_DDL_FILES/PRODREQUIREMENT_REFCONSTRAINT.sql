--------------------------------------------------------
--  Ref Constraints for Table PRODREQUIREMENT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODREQUIREMENT" ADD CONSTRAINT "PRODREQUIREMENT_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
