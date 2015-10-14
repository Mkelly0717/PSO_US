--------------------------------------------------------
--  Constraints for Table PRODRESPROJ
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "PRODRESPROJ_PK" PRIMARY KEY ("PRODUCTIONMETHOD", "ITEM", "LOC", "RES", "TVQCATEGORY", "EFF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "CHK_PRDRESPROJ_DUR" CHECK (DUR >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "CONSTRAINT_POLICY3" CHECK (POLICY IN (0, 1, 2)) ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "CHK_PRDRESPROJ_ADDITIONALUOM" CHECK (ADDITIONALUOM >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "CHK_PRDRESPROJ_DENOMINATORUOM" CHECK (DENOMINATORUOM >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" ADD CONSTRAINT "CHK_PRDRESPROJ_NUMERATORUOM" CHECK (NUMERATORUOM >= 0) ENABLE
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("DUR" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("EFF" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("VALUE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("POLICY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("OPTIONSETNAME" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("ADDITIONALUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("DENOMINATORUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("NUMERATORUOM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("TVQCATEGORY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("RES" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("ITEM" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."PRODRESPROJ" MODIFY ("PRODUCTIONMETHOD" NOT NULL ENABLE)
