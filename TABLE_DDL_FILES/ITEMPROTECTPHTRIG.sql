--------------------------------------------------------
--  DDL for Trigger ITEMPROTECTPHTRIG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."ITEMPROTECTPHTRIG" 
before delete on ITEM for each row
begin
  if :old.ITEM = ' ' then
     RAISE_APPLICATION_ERROR
        (-20001, 'Cannot delete ITEM record with blank ITEM column');
  end if;
end;
ALTER TRIGGER "SCPOMGR"."ITEMPROTECTPHTRIG" ENABLE
