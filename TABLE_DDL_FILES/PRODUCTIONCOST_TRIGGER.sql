--------------------------------------------------------
--  DDL for Trigger PRODUCTIONCOST_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."PRODUCTIONCOST_TRIGGER" 
after delete
on productioncost
referencing new as new old as old
for each row
begin
delete from cost where cost = :OLD.localcost;
end;
ALTER TRIGGER "SCPOMGR"."PRODUCTIONCOST_TRIGGER" ENABLE
