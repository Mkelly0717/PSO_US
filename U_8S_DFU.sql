--------------------------------------------------------
--  DDL for Procedure U_8S_DFU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S_DFU" as

Begin

DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUVIEW');
DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'DFUVIEW');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUVIEW',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'DFUVIEW');
DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'LOC');
DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'LOC');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'LOC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'LOC');
DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PROCESSSKU');
DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PROCESSSKU');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PROCESSSKU',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PROCESSSKU');

DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESPENALTY');
DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RESPENALTY');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESPENALTY',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESPENALTY');

DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUPENALTY');
DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SKUPENALTY');
DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUPENALTY',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUPENALTY');

End;
