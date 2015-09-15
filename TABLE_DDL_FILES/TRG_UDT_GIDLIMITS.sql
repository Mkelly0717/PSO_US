--------------------------------------------------------
--  DDL for Trigger TRG_UDT_GIDLIMITS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SCPOMGR"."TRG_UDT_GIDLIMITS" 
-- Optionally restrict this trigger to fire only when really needed
  BEFORE INSERT 
  ON UDT_GIDLIMITS
  FOR EACH ROW
 WHEN (
new.PRIMARY_KEY_COL is null
      ) DECLARE
  v_id UDT_GIDLIMITS.PRIMARY_KEY_COL%TYPE;
BEGIN
  -- Select a new value from the sequence into a local variable. As David
  -- commented, this step is optional. You can directly select into :new.qname_id
  SELECT SEQ_UDT_GIDLIMITS.nextval INTO v_id FROM DUAL;

  -- :new references the record that you are about to insert into qname. Hence,
  -- you can overwrite the value of :new.qname_id (qname.qname_id) with the value
  -- obtained from your sequence, before inserting
  :new.PRIMARY_KEY_COL := v_id;
END TRG_UDT_GIDLIMITS;
ALTER TRIGGER "SCPOMGR"."TRG_UDT_GIDLIMITS" ENABLE
