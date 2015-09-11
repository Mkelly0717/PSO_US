--------------------------------------------------------
--  Ref Constraints for Table UDT_EQUIPMENT_CONVERSION
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."UDT_EQUIPMENT_CONVERSION" ADD CONSTRAINT "UDT_EQUIPMENT_CONVERSION__FK1" FOREIGN KEY ("U_EQUIPMENT_TYPE")
	  REFERENCES "SCPOMGR"."UDT_EQUIPMENT_TYPE" ("U_EQUIPMENT_TYPE") ENABLE;
  ALTER TABLE "SCPOMGR"."UDT_EQUIPMENT_CONVERSION" ADD CONSTRAINT "UDT_EQUIPMENT_CONVERSION__FK2" FOREIGN KEY ("COMPANYID")
	  REFERENCES "SCPOMGR"."UDT_AREA" ("COMPANYID") ENABLE;
  ALTER TABLE "SCPOMGR"."UDT_EQUIPMENT_CONVERSION" ADD CONSTRAINT "UDT_EQUIPMENT_CONVERSION__FK3" FOREIGN KEY ("U_AREA")
	  REFERENCES "SCPOMGR"."UDT_AREA_TYPE" ("U_AREA") ENABLE;
