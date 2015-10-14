--------------------------------------------------------
--  Ref Constraints for Table FCSTPERFSTATIC
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCSTPERFSTATIC" ADD CONSTRAINT "FCSTPERFSTATIC_DFU_FK1" FOREIGN KEY ("DMDUNIT", "DMDGROUP", "LOC", "MODEL")
	  REFERENCES "SCPOMGR"."DFU" ("DMDUNIT", "DMDGROUP", "LOC", "MODEL") ON DELETE CASCADE ENABLE
