--------------------------------------------------------
--  Constraints for Table UDT_PLANT_CAPABILITIES
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" ADD CONSTRAINT "UDT_CAPACITIES_PK" PRIMARY KEY ("CAPABILITY")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE;
  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" MODIFY ("STATUS" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."UDT_PLANT_CAPABILITIES" MODIFY ("CAPABILITY" NOT NULL ENABLE);
