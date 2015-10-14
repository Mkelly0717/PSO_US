--------------------------------------------------------
--  Constraints for Table FCSTDRAFT
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."FCSTDRAFT" ADD CONSTRAINT "FCSTDRAFT_PK" PRIMARY KEY ("DMDUNIT", "DMDGROUP", "LOC", "MODEL", "STARTDATE", "TYPE", "FCSTID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("MARKETMGRVERSIONID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("LEWMEANQTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("MODEL" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("QTY" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("FCSTID" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("TYPE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("DUR" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("STARTDATE" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("LOC" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("DMDGROUP" NOT NULL ENABLE)
  ALTER TABLE "SCPOMGR"."FCSTDRAFT" MODIFY ("DMDUNIT" NOT NULL ENABLE)