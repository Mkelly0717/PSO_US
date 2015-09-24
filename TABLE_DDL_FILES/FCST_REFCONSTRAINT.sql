--------------------------------------------------------
--  Ref Constraints for Table FCST
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCST" ADD CONSTRAINT "FCST_DFUVIEW_FK1" FOREIGN KEY ("DMDUNIT", "DMDGROUP", "LOC")
	  REFERENCES "SCPOMGR"."DFUVIEW" ("DMDUNIT", "DMDGROUP", "LOC") ON DELETE CASCADE ENABLE
