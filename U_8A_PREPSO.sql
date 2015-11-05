REM ---------------------------------------------------------------------
REM     NAME:      U_8A_PREPSO.sql
REM     CONTENTS: 
REM     PURPOSE:   This script modifies database statistics and Index structures prior to running PSO
REM		
REM	    NOTES:     Execute as SCPO owner
REM                An optional plsql block at the end of this script can be executed to disable the referential integrity constraints
REM                on the metric tables. Depending on the model and duration this will reduce the runtime of PSO by between 5 and 20 minutes.
REM                The constraints should be re-enabled in the post script
REM         
REM     PARAMETER: none
REM     Usage:     U_8A_PREPSO.sql
REM     Examples:  U_8A_PREPSO.sql
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

SELECT 'Starting U_8A_PREPROD.sql @:'|| TO_CHAR(sysdate, 'MM-DD-YYYY HH24:MI:SS')
  FROM DUAL;

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

--Stage Loader Indexes and remove indexes from base tables that are delaying loading of Map tables
CREATE INDEX XIF5SOURCINGREQUIREMENT ON SOURCINGREQUIREMENT (RES,ITEM,SOURCE,DEST) TABLESPACE SCPODATA;
DROP INDEX XIF4SOURCINGREQUIREMENT;
DROP INDEX XIF3SOURCINGREQUIREMENT;
DROP INDEX XIF2SOURCINGREQUIREMENT;
DROP INDEX OPTIMIZERSKUMAP_IDX1;
DROP INDEX OPTIMIZERSOURCINGMAP_IDX1;
DROP INDEX OPTIMIZERRESMAP_IDX1;

--Modify existing index structures to eliminate table lookups
CREATE UNIQUE INDEX OPTIMIZERSKUMAP_IDX1 ON SCPOMGR.OPTIMIZERSKUMAP (INSTANCEID, SERVICEID,ITEM,LOC) TABLESPACE SCPODATA;
CREATE UNIQUE INDEX OPTIMIZERSOURCINGMAP_IDX1 ON SCPOMGR.OPTIMIZERSOURCINGMAP (INSTANCEID, SERVICEID,SOURCING,ITEM,DEST,SOURCE) TABLESPACE SCPODATA;
CREATE UNIQUE INDEX SCPOMGR.OPTIMIZERRESMAP_IDX1 ON SCPOMGR.OPTIMIZERRESMAP(INSTANCEID, SERVICEID,RES) TABLESPACE SCPODATA;

--Dropping these indexes to accelerate loading of Metrics tables
DROP INDEX XIF1RESMETRIC;
DROP INDEX XIF2RESMETRIC;
DROP INDEX XIF3RESMETRIC;
DROP INDEX XIF4RESMETRIC;
DROP INDEX XIF5RESMETRIC;
DROP INDEX XIF6RESMETRIC;

DROP INDEX XIF3SOURCINGMETRIC;
DROP INDEX XIF5SOURCINGMETRIC;
DROP INDEX XIF1SOURCINGMETRIC;
DROP INDEX XIF4SOURCINGMETRIC;

DROP INDEX XIF4SOURCINGRESMETRIC;
DROP INDEX XIF2SOURCINGRESMETRIC;
DROP INDEX XIF5SOURCINGRESMETRIC;
DROP INDEX XIF1SOURCINGRESMETRIC;
DROP INDEX XIF3SOURCINGRESMETRIC;

DROP INDEX XIF4SKUMETRIC;
DROP INDEX XIF1SKUMETRIC;
DROP INDEX XIF3SKUMETRIC;
DROP INDEX XIF2SKUMETRIC;

--Import Batch Statistics - The 14 day statistics work best with both models
--Summary - These statistics are optimized and contain the statistics for the modified index structures created by this script
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSKUMAP',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERSOURCINGMAP',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERRESMAP',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERPRODUCTIONMAP',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERLOCMAP',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASIS',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'OPTIMIZERBASISCOUNT',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_PRODUCTIONMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PRODUCTIONRESMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SOURCINGMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGRESMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKUMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
--exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'UDT_SKUMETRIC_WK',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESMETRIC',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCING',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGDRAW',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGYIELD',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGREQUIREMENT',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SOURCINGCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKU',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'SKUCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESCONSTRAINT',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'CUSTORDER',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PLANARRIV',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'PLANORDER',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'DFUTOSKUFCST',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'FCST',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RES',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'COST',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'COSTTIER',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');
exec dbms_stats.import_table_stats(ownname=>'SCPOMGR',tabname=>'RESCOST',stattab=>'PSO_DB_STATS',statid=>'BATCH2_14_DAY',cascade=>TRUE,statown=>'SCPOMGR');

--Lock the table statistics 
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
  --execute immediate('alter table '||vrec.table_name||' disable constraint '||vrec.constraint_name);
--END LOOP;
--END;
--/

SELECT 'End of U_8A_PREPSO.sql @:'|| TO_CHAR(sysdate, 'MM-DD-YYYY HH24:MI:SS')
  FROM DUAL;

EXIT 0;


