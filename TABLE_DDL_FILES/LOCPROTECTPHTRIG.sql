--------------------------------------------------------
--  DDL for Trigger LOCPROTECTPHTRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."LOCPROTECTPHTRIG" 
before delete on LOC for each row
begin
  if :old.LOC = ' ' then
     RAISE_APPLICATION_ERROR
        (-20001, 'Cannot delete LOC record with blank LOC column');
  end if;
end;
ALTER TRIGGER "SCPOMGR"."LOCPROTECTPHTRIG" ENABLE
