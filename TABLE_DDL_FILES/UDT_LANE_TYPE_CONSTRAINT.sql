--------------------------------------------------------
--  Constraints for Table UDT_LANE_TYPE
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_LANE_TYPE" ADD CONSTRAINT "UDT_LANE_TYPE_PK" PRIMARY KEY ("LANE_TYPE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE;
  ALTER TABLE "SCPOMGR"."UDT_LANE_TYPE" MODIFY ("LANE_TYPE" NOT NULL ENABLE);