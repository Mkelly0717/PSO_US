--------------------------------------------------------
--  DDL for Trigger TIU_PLANNETCHG_LOC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."TIU_PLANNETCHG_LOC" 
BEFORE INSERT OR UPDATE ON LOC
for each row
   WHEN (NEW.FF_TRIGGER_CONTROL IS NOT NULL) BEGIN

   if INSERTING THEN
      -- set netchangesw if not already set
      UPDATE sku SET netchgsw = 1
         WHERE  netchgsw = 0
            AND   sku.loc = :new.loc;

    elsif UPDATING then
        if :NEW.FF_TRIGGER_CONTROL=-1 then
          UPDATE sku SET netchgsw = 1
            WHERE  netchgsw = 0
            AND   sku.loc = :new.loc;
      elsif
        -- set netchangesw if ohpost, frzstart columns have changed
        :new.ohpost <> :old.ohpost or
        :new.frzstart <> :old.frzstart
      then
        -- set netchangesw if not already set
        UPDATE sku SET netchgsw = 1
            WHERE netchgsw = 0
            AND   sku.loc = :new.loc;
      end if;
  end if;

   -- reset trigger_control to NULL
   :new.FF_TRIGGER_CONTROL := NULL;

END;
ALTER TRIGGER "SCPOMGR"."TIU_PLANNETCHG_LOC" ENABLE
