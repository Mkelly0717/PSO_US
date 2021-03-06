--------------------------------------------------------
--  Constraints for Table UDT_SOURCING_DEFINITIONS
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "UDT_SOURCING_DEF_CHK_SRC_TYPE" CHECK (SOURCING_TYPE IN ('ISSUE', 'COLLECTION')) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "UDT_SOURCING_DEF_CHK_ZIPTYPE" CHECK (ZIP_TYPE IN ('3', '5', 'NA')) ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" ADD CONSTRAINT "TABLE1_PK" PRIMARY KEY ("SOURCING")
  USING INDEX  ENABLE
  ALTER TABLE "SCPOMGR"."UDT_SOURCING_DEFINITIONS" MODIFY ("SOURCING" NOT NULL ENABLE)
