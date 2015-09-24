--------------------------------------------------------
--  Ref Constraints for Table PRODUCTIONTARGET
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONTARGET" ADD CONSTRAINT "PRODTARGET_PRODMETHOD_FK1" FOREIGN KEY ("PRODUCTIONMETHOD", "ITEM", "LOC")
	  REFERENCES "SCPOMGR"."PRODUCTIONMETHOD" ("PRODUCTIONMETHOD", "ITEM", "LOC") ON DELETE CASCADE ENABLE
