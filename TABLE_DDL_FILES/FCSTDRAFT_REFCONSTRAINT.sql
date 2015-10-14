--------------------------------------------------------
--  Ref Constraints for Table FCSTDRAFT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCSTDRAFT" ADD CONSTRAINT "FCSTDRAFT_DFU_FK1" FOREIGN KEY ("DMDUNIT", "DMDGROUP", "LOC", "MODEL")
	  REFERENCES "SCPOMGR"."DFU" ("DMDUNIT", "DMDGROUP", "LOC", "MODEL") ON DELETE CASCADE ENABLE
