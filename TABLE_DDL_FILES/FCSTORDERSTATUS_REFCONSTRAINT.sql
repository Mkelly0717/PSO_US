--------------------------------------------------------
--  Ref Constraints for Table FCSTORDERSTATUS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCSTORDERSTATUS" ADD CONSTRAINT "FCSTORDERSTATUS_FCSTORDER_FK1" FOREIGN KEY ("ITEM", "LOC", "SEQNUM")
	  REFERENCES "SCPOMGR"."FCSTORDER" ("ITEM", "LOC", "SEQNUM") ON DELETE CASCADE ENABLE
