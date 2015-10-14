--------------------------------------------------------
--  Ref Constraints for Table FCSTORDER
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCSTORDER" ADD CONSTRAINT "FCSTORDER_SKU_FK1" FOREIGN KEY ("ITEM", "LOC")
	  REFERENCES "SCPOMGR"."SKU" ("ITEM", "LOC") ON DELETE CASCADE ENABLE
