--------------------------------------------------------
--  DDL for Trigger RESCOST_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."RESCOST_TRIGGER" 
after delete
on rescost
referencing new as new old as old
for each row
begin
delete from cost where cost = :OLD.localcost;
end;
ALTER TRIGGER "SCPOMGR"."RESCOST_TRIGGER" ENABLE
