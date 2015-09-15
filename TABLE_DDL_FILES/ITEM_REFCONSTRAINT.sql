--------------------------------------------------------
--  Ref Constraints for Table ITEM
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "ITEM_UOM_FK1" FOREIGN KEY ("DEFAULTUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
