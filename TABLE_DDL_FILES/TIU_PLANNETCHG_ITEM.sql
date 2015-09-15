--------------------------------------------------------
--  DDL for Trigger TIU_PLANNETCHG_ITEM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."TIU_PLANNETCHG_ITEM" 
BEFORE INSERT OR UPDATE ON ITEM
for each row
   WHEN (NEW.FF_TRIGGER_CONTROL IS NOT NULL) BEGIN

   if INSERTING THEN
      UPDATE sku SET netchgsw = 1
         WHERE netchgsw = 0
        AND   sku.item = :new.item;

    elsif UPDATING then
        if :NEW.FF_TRIGGER_CONTROL=-1 then
         UPDATE sku SET netchgsw = 1
            WHERE netchgsw = 0
        AND   sku.item = :new.item;

        elsif
        -- set netchangesw if perishablesw, restrictplanmode columns have changed
        :new.perishablesw <> :old.perishablesw or
        :new.restrictplanmode <> :old.restrictplanmode
      then
            -- set netchangesw if not already set
            UPDATE sku SET netchgsw = 1
                WHERE netchgsw = 0
                AND   sku.item = :new.item;
      end if;
  end if;
   -- reset trigger_control to NULL
   :new.FF_TRIGGER_CONTROL := NULL;

END;
ALTER TRIGGER "SCPOMGR"."TIU_PLANNETCHG_ITEM" ENABLE
