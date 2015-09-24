--------------------------------------------------------
--  DDL for Trigger PRODUCTIONFAMILYPROTECHPHTRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."PRODUCTIONFAMILYPROTECHPHTRIG" 
   BEFORE DELETE
   ON PRODUCTIONFAMILY
   FOR EACH ROW
BEGIN
   IF (   (:OLD.PRODFAMILY = '*')
       OR (:OLD.PRODFAMILY = ' ')
       OR (:OLD.PRODFAMILY = '?'))
   THEN
      RAISE_APPLICATION_ERROR
         (-20001,
          'Cannot delete PRODUCTIONFAMILY record with *,blank and ? PRODFAMILY column');
   END IF;
END;
ALTER TRIGGER "SCPOMGR"."PRODUCTIONFAMILYPROTECHPHTRIG" ENABLE
