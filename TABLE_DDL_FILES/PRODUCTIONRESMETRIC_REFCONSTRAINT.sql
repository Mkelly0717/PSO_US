--------------------------------------------------------
--  Ref Constraints for Table PRODUCTIONRESMETRIC
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONRESMETRIC" ADD CONSTRAINT "PRODRESMETRIC_METRICCAT_FK" FOREIGN KEY ("CATEGORY")
	  REFERENCES "SCPOMGR"."METRICCATEGORY" ("CATEGORY") ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONRESMETRIC" ADD CONSTRAINT "PRODRESMETRIC_PRODMETHOD_FK" FOREIGN KEY ("PRODUCTIONMETHOD", "ITEM", "LOC")
	  REFERENCES "SCPOMGR"."PRODUCTIONMETHOD" ("PRODUCTIONMETHOD", "ITEM", "LOC") ON DELETE CASCADE ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONRESMETRIC" ADD CONSTRAINT "PRODUCTIONRESMETRIC_CURRUOM_FK" FOREIGN KEY ("CURRENCYUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONRESMETRIC" ADD CONSTRAINT "PRODUCTIONRESMETRIC_QTYUOM_FK" FOREIGN KEY ("QTYUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONRESMETRIC" ADD CONSTRAINT "PRODUCTIONRESMETRIC_RES_FK" FOREIGN KEY ("RES")
	  REFERENCES "SCPOMGR"."RES" ("RES") ON DELETE CASCADE ENABLE