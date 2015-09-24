--------------------------------------------------------
--  Ref Constraints for Table PRODUCTIONFAMILYLOAD
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODUCTIONFAMILYLOAD" ADD CONSTRAINT "PRODFAMILYLOAD_PRODFAMILY_FK" FOREIGN KEY ("PRODFAMILY")
	  REFERENCES "SCPOMGR"."PRODUCTIONFAMILY" ("PRODFAMILY") ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONFAMILYLOAD" ADD CONSTRAINT "PRODFAMILYLOAD_PRODFAMILY_FK2" FOREIGN KEY ("CHGOVERPRODFAMILY")
	  REFERENCES "SCPOMGR"."PRODUCTIONFAMILY" ("PRODFAMILY") ENABLE
  ALTER TABLE "SCPOMGR"."PRODUCTIONFAMILYLOAD" ADD CONSTRAINT "PRODFAMILYLOAD_RES_FK" FOREIGN KEY ("RES")
	  REFERENCES "SCPOMGR"."RES" ("RES") ENABLE