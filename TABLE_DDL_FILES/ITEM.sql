--------------------------------------------------------
--  File created - Friday-September-04-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ITEM
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."ITEM" 
   (	"ITEM" VARCHAR2(50 CHAR), 
	"DESCR" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"UOM" VARCHAR2(50 CHAR) DEFAULT ' ', 
	"WGT" FLOAT(126) DEFAULT 0, 
	"VOL" FLOAT(126) DEFAULT 0, 
	"UNITSPERPALLET" FLOAT(126) DEFAULT 1, 
	"UNITSPERALTSHIP" FLOAT(126) DEFAULT 1, 
	"CANCELDEPTHLIMIT" NUMBER DEFAULT 0, 
	"UNITPRICE" FLOAT(126) DEFAULT 0, 
	"PLANLEVEL" NUMBER(38,0) DEFAULT -1, 
	"ENABLESW" NUMBER(1,0) DEFAULT 1, 
	"PERISHABLESW" NUMBER(1,0) DEFAULT 0, 
	"PRIITEMPRIORITY" NUMBER(38,0) DEFAULT 0, 
	"PRIORITY" NUMBER(*,0) DEFAULT 1, 
	"RESTRICTPLANMODE" NUMBER(*,0) DEFAULT 1, 
	"DDSKUSW" NUMBER(1,0) DEFAULT 0, 
	"DDSRCCOSTSW" NUMBER(1,0) DEFAULT 0, 
	"DYNDEPDECIMALS" NUMBER(*,0) DEFAULT 0, 
	"DYNDEPOPTION" NUMBER(*,0) DEFAULT 1, 
	"DYNDEPPUSHOPT" NUMBER(*,0) DEFAULT 1, 
	"DYNDEPQTY" FLOAT(126) DEFAULT 1, 
	"FF_TRIGGER_CONTROL" NUMBER(*,0), 
	"ITEMCLASS" VARCHAR2(50 CHAR) DEFAULT 'DEFAULT', 
	"INVOPTIMIZERTYPE" NUMBER DEFAULT 1, 
	"DEFAULTUOM" NUMBER(*,0) DEFAULT 18, 
	"ALLOCPOLICY" NUMBER(1,0) DEFAULT 1, 
	"CALCCUMLEADTIMESW" NUMBER(1,0) DEFAULT 0, 
	"SUPSNGROUPNUM" NUMBER DEFAULT -1, 
	"U_MATERIALCODE" VARCHAR2(10 CHAR), 
	"U_QUALITYBATCH" VARCHAR2(20 CHAR), 
	"U_STOCK" VARCHAR2(1 CHAR), 
	"U_FREIGHT_FACTOR" NUMBER DEFAULT 0.0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
--------------------------------------------------------
--  DDL for Index ITEM_SUPSN_PLNLVL_IDX
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."ITEM_SUPSN_PLNLVL_IDX" ON "SCPOMGR"."ITEM" ("PLANLEVEL", "SUPSNGROUPNUM", "ITEM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
--------------------------------------------------------
--  DDL for Index ITEM_UOM_FK
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."ITEM_UOM_FK" ON "SCPOMGR"."ITEM" ("DEFAULTUOM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
--------------------------------------------------------
--  DDL for Index XIE1ITEM
--------------------------------------------------------

  CREATE INDEX "SCPOMGR"."XIE1ITEM" ON "SCPOMGR"."ITEM" ("ALLOCPOLICY") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
--------------------------------------------------------
--  DDL for Index ITEM_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCPOMGR"."ITEM_PK" ON "SCPOMGR"."ITEM" ("ITEM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA" ;
--------------------------------------------------------
--  Constraints for Table ITEM
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "CHK_U_STOCK" CHECK (U_STOCK IN ('A', 'B', 'C')) DISABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "ITEM_PK" PRIMARY KEY ("ITEM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCPODATA"  ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "ALLOCPOLICY2" CHECK (ALLOCPOLICY IN (1, 2, 3)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "INVOPTIMIZERTYPE" CHECK (InvOptimizerType IN (1, 2, 3)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "BOOL_ITEM_DDSRCCOSTSW" CHECK (DDSRCCOSTSW IN (0, 1)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "BOOL_ITEM_DDSKUSW" CHECK (DDSKUSW IN (0, 1)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "BOOL_ITEM_PERISHABLESW" CHECK (PERISHABLESW IN (0, 1)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "BOOL_ITEM_ENABLESW" CHECK (EnableSw IN (0, 1)) ENABLE;
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("SUPSNGROUPNUM" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("CALCCUMLEADTIMESW" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("ALLOCPOLICY" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DEFAULTUOM" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("INVOPTIMIZERTYPE" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("ITEMCLASS" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DYNDEPQTY" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DYNDEPPUSHOPT" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DYNDEPOPTION" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DYNDEPDECIMALS" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DDSRCCOSTSW" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DDSKUSW" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("RESTRICTPLANMODE" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("PRIORITY" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("PRIITEMPRIORITY" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("PERISHABLESW" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("ENABLESW" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("PLANLEVEL" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("UNITPRICE" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("CANCELDEPTHLIMIT" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("UNITSPERALTSHIP" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("UNITSPERPALLET" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("VOL" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("WGT" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("UOM" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("DESCR" NOT NULL ENABLE);
  ALTER TABLE "SCPOMGR"."ITEM" MODIFY ("ITEM" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table ITEM
--------------------------------------------------------

  ALTER TABLE "SCPOMGR"."ITEM" ADD CONSTRAINT "ITEM_UOM_FK1" FOREIGN KEY ("DEFAULTUOM")
	  REFERENCES "SCPOMGR"."UOM" ("UOM") ENABLE;
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
/
ALTER TRIGGER "SCPOMGR"."ITEMPROTECTPHTRIG" ENABLE;
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
/
ALTER TRIGGER "SCPOMGR"."TIU_PLANNETCHG_ITEM" ENABLE;
