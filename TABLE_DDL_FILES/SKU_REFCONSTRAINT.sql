--------------------------------------------------------
--  Ref Constraints for Table SKU
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_ITEM_FK1" FOREIGN KEY ("ITEM")
	  REFERENCES "SCPOMGR"."ITEM" ("ITEM") ON DELETE CASCADE ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_LOC_FK1" FOREIGN KEY ("LOC")
	  REFERENCES "SCPOMGR"."LOC" ("LOC") ON DELETE CASCADE ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_LTDGROUP_FK" FOREIGN KEY ("LTDGROUP")
	  REFERENCES "SCPOMGR"."LTDGROUP" ("LTDGROUP") ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_SOURCINGGROUP_FK1" FOREIGN KEY ("SOURCINGGROUP")
	  REFERENCES "SCPOMGR"."SOURCINGGROUP" ("SOURCINGGROUP") ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_UOM_FK3" FOREIGN KEY ("CURRENCYUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_UOM_FK4" FOREIGN KEY ("QTYUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
  ALTER TABLE "SCPOMGR"."SKU" ADD CONSTRAINT "SKU_UOM_FK5" FOREIGN KEY ("TIMEUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
