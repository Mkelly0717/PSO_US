--------------------------------------------------------
--  DDL for Trigger TIU_PLANNETCHG_SKU
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."TIU_PLANNETCHG_SKU" 
BEFORE INSERT OR UPDATE ON SKU
for each row
   WHEN (NEW.FF_TRIGGER_CONTROL IS NOT NULL) BEGIN
   if INSERTING THEN
      -- set netchangesw if not already set
         :new.netchgsw := 1;
    elsif UPDATING then
        if :NEW.FF_TRIGGER_CONTROL=-1 then
             :new.netchgsw := 1;
      elsif
        :new.oh <> :old.oh or
        :new.replentype <> :old.replentype or
        :new.ohpost <> :old.ohpost
      then
         :new.netchgsw := 1;
      end if;
   end if;
     -- reset trigger_control to NULL
   :new.FF_TRIGGER_CONTROL := NULL;

END;
ALTER TRIGGER "SCPOMGR"."TIU_PLANNETCHG_SKU" ENABLE
