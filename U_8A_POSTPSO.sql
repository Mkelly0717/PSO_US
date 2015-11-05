REM ---------------------------------------------------------------------
REM     NAME:      U_8A_POSTPSO.sql
REM     CONTENTS: 
REM     PURPOSE:   This script restores runtime database statistics and rebuilds Index structures after to running PSO
REM		
REM	    NOTES:     Execute as SCPO owner
REM                An optional plsql block to enable constraints must be executed in this script if the constraints are
REM                disabled in the pre script
REM         
REM     PARAMETER: none
REM     Usage:     U_8A_POSTPSO.sql   
REM     Examples:  U_8A_POSTPSO.sql 
REM              
REM ## MODIFICATION LOG ######################################################################
REM ## 
REM ## VERS     DATE              REF           DESCRIPTION
REM ## 1.0      Aug 13	          JDA	          Initial Script
REM ##########################################################################################

SET ECHO OFF;
SET ESCAPE ON;
SET FEEDBACK ON;
SET HEADING OFF;
SET TIMING ON;
SET VERIFY OFF;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;
WHENEVER OSERROR EXIT SQL.OSCODE   ROLLBACK;

SELECT 'Current environment is User= '||user||'   DB= '||name||
       '   Date= '|| SYSDATE
FROM V$DATABASE;

SELECT 'Starting U_8A_POSTPSO.sql @:'|| TO_CHAR(sysdate, 'MM-DD-YYYY HH24:MI:SS')
  FROM DUAL;

--Enable parallel DML
--ALTER SESSION ENABLE PARALLEL DML;

--Unlock Statistics
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSKUMAP');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERRESMAP');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERPRODUCTIONMAP');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERLOCMAP');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASIS');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASISCOUNT');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONMETRIC');
--exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_PRODUCTIONMETRIC_WK');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONRESMETRIC');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGMETRIC');
--exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SOURCINGMETRIC_WK');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGRESMETRIC');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SKUMETRIC');
--exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SKUMETRIC_WK');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'RESMETRIC');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCING');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGDRAW');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGYIELD');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGREQUIREMENT');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGCONSTRAINT');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SKU');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'SKUCONSTRAINT');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'RESCONSTRAINT');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'CUSTORDER');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'PLANARRIV');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'PLANORDER');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'DFUTOSKUFCST');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'FCST');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'RES');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'COST');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'COSTTIER');
exec dbms_stats.unlock_table_stats(ownname=>'SCPOMGR',tabname=>'RESCOST');

--Drop Indexes created for Batch
drop index OPTIMIZERSKUMAP_IDX1;
drop index OPTIMIZERSOURCINGMAP_IDX1;
drop index OPTIMIZERRESMAP_IDX1;
drop index XIF5SOURCINGREQUIREMENT;

--Restore 25 Prod Indexes
CREATE INDEX SCPOMGR.XIF2SOURCINGREQUIREMENT ON SCPOMGR.SOURCINGREQUIREMENT (RES) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

CREATE INDEX SCPOMGR.XIF3SOURCINGREQUIREMENT ON SCPOMGR.SOURCINGREQUIREMENT (SOURCING, ITEM, SOURCE, DEST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

CREATE INDEX SCPOMGR.XIF4SOURCINGREQUIREMENT ON SCPOMGR.SOURCINGREQUIREMENT (QTYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

CREATE INDEX SCPOMGR.OPTIMIZERSKUMAP_IDX1 ON SCPOMGR.OPTIMIZERSKUMAP (INSTANCEID, SERVICEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

CREATE INDEX SCPOMGR.OPTIMIZERSOURCINGMAP_IDX1 ON SCPOMGR.OPTIMIZERSOURCINGMAP (INSTANCEID, SERVICEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

CREATE INDEX SCPOMGR.OPTIMIZERRESMAP_IDX1 ON SCPOMGR.OPTIMIZERRESMAP (INSTANCEID, SERVICEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

 CREATE INDEX SCPOMGR.XIF1RESMETRIC ON SCPOMGR.RESMETRIC (CATEGORY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF2RESMETRIC ON SCPOMGR.RESMETRIC (RES) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF3RESMETRIC ON SCPOMGR.RESMETRIC (CURRENCYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF4RESMETRIC ON SCPOMGR.RESMETRIC (QTYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF5RESMETRIC ON SCPOMGR.RESMETRIC (TIMEUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF6RESMETRIC ON SCPOMGR.RESMETRIC (SETUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA;

  CREATE INDEX SCPOMGR.XIF1SOURCINGMETRIC ON SCPOMGR.SOURCINGMETRIC (CATEGORY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF3SOURCINGMETRIC ON SCPOMGR.SOURCINGMETRIC (SOURCING, ITEM, SOURCE, DEST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF4SOURCINGMETRIC ON SCPOMGR.SOURCINGMETRIC (CURRENCYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF5SOURCINGMETRIC ON SCPOMGR.SOURCINGMETRIC (QTYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF3SKUMETRIC ON SCPOMGR.SKUMETRIC (CURRENCYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF4SKUMETRIC ON SCPOMGR.SKUMETRIC (QTYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;
  
  CREATE INDEX SCPOMGR.XIF1SKUMETRIC ON SCPOMGR.SKUMETRIC (CATEGORY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF2SKUMETRIC ON SCPOMGR.SKUMETRIC (LOC, ITEM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF1SOURCINGRESMETRIC ON SCPOMGR.SOURCINGRESMETRIC (CATEGORY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF2SOURCINGRESMETRIC ON SCPOMGR.SOURCINGRESMETRIC (RES) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF3SOURCINGRESMETRIC ON SCPOMGR.SOURCINGRESMETRIC (SOURCING, ITEM, SOURCE, DEST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF4SOURCINGRESMETRIC ON SCPOMGR.SOURCINGRESMETRIC (CURRENCYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

  CREATE INDEX SCPOMGR.XIF5SOURCINGRESMETRIC ON SCPOMGR.SOURCINGRESMETRIC (QTYUOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 81920 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SCPODATA ;

--Import Runtime Statistics
--Summary - These are the runtime statistics for the fully populated table structures
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSKUMAP',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSOURCINGMAP',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERRESMAP',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERPRODUCTIONMAP',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERLOCMAP',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASIS',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASISCOUNT',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_PRODUCTIONMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONRESMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SOURCINGMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGRESMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKUMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SKUMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESMETRIC',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCING',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGDRAW',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGYIELD',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGREQUIREMENT',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKU',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKUCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'CUSTORDER',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PLANARRIV',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PLANORDER',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'DFUTOSKUFCST',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'FCST',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RES',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'COST',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'COSTTIER',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESCOST',stattab=>'PSO_DB_STATS',statid=>'TEST2',cascade=>TRUE,statown=>'SCPOMGR');
--lock Statistics
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSKUMAP');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERRESMAP');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERPRODUCTIONMAP');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERLOCMAP');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASIS');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASISCOUNT');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONMETRIC');
--exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_PRODUCTIONMETRIC_WK');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONRESMETRIC');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGMETRIC');
--exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SOURCINGMETRIC_WK');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGRESMETRIC');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SKUMETRIC');
--exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SKUMETRIC_WK');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'RESMETRIC');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCING');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGDRAW');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGYIELD');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGREQUIREMENT');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGCONSTRAINT');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SKU');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'SKUCONSTRAINT');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'RESCONSTRAINT');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'CUSTORDER');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'PLANARRIV');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'PLANORDER');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'DFUTOSKUFCST');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'FCST');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'RES');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'COST');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'COSTTIER');
exec dbms_stats.lock_table_stats(ownname=>'SCPOMGR',tabname=>'RESCOST');

--*OPTIONAL - this will reduce the output to the metrics tables by 5 to 20 minutes depending on the model and duration
--DECLARE
--CURSOR c1 IS SELECT table_name,constraint_name from user_constraints where constraint_type ='R' and table_name in('SKUMETRIC','RESMETRIC','SOURCINGMETRIC','SOURCINGRESMETRIC') ORDER BY table_name;
--BEGIN
--FOR vrec in c1 LOOP
  --execute immediate('alter table '||vrec.table_name||' enable novalidate constraint '||vrec.constraint_name);
--END LOOP;
--END;
--/

SELECT 'End of U_8A_POSTPSO.sql @:'|| TO_CHAR(sysdate, 'MM-DD-YYYY HH24:MI:SS')
  FROM DUAL;

EXIT 0;  