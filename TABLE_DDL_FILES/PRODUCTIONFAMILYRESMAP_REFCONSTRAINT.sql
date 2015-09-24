--------------------------------------------------------
--  Ref Constraints for Table PRODUCTIONFAMILYRESMAP
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONFAMILYRESMAP" ADD CONSTRAINT "PRODFAMILYRESMAP_PRODFAMILY_FK" FOREIGN KEY ("PRODFAMILY")
	  REFERENCES "SCPOMGR"."PRODUCTIONFAMILY" ("PRODFAMILY") ENABLE
