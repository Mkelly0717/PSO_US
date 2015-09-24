--------------------------------------------------------
--  DDL for Trigger RESPROTECTPHTRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."RESPROTECTPHTRIG" 
BEFORE DELETE ON RES FOR EACH ROW
BEGIN
  IF :OLD.RES = ' ' THEN
     RAISE_APPLICATION_ERROR
        (-20001, 'Cannot delete Res record with blank Res column');
  END IF;
END;
ALTER TRIGGER "SCPOMGR"."RESPROTECTPHTRIG" ENABLE
