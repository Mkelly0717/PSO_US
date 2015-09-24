--------------------------------------------------------
--  Ref Constraints for Table RESSUBTYPE_TRANS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."RESSUBTYPE_TRANS" ADD CONSTRAINT "RESSUBTYPE_TRANS_RESSUBTYPE_FK" FOREIGN KEY ("SUBTYPE")
	  REFERENCES "SCPOMGR"."RESSUBTYPE" ("SUBTYPE") ENABLE
