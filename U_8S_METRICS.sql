--------------------------------------------------------
--  DDL for Procedure U_8S_METRICS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S_METRICS" as

v_count number;
Begin

--less than 1 minute

select count(*) into v_count from productionmetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PRODUCTIONMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONMETRIC');
end if;

select count(*) into v_count from udt_productionmetric_WK;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_PRODUCTIONMETRIC_WK');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_PRODUCTIONMETRIC_WK');
end if;

select count(*) into v_count from productionresmetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'PRODUCTIONRESMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'PRODUCTIONRESMETRIC');
end if;

select count(*) into v_count from sourcingmetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGMETRIC');
end if;

select count(*) into v_count from udt_sourcingmetric_WK;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_SOURCINGMETRIC_WK');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SOURCINGMETRIC_WK');
end if;

select count(*) into v_count from sourcingresmetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SOURCINGRESMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SOURCINGRESMETRIC');
end if;

select count(*) into v_count from skumetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'SKUMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'SKUMETRIC');
end if;

select count(*) into v_count from udt_skumetric_WK;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'UDT_SKUMETRIC_WK');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'UDT_SKUMETRIC_WK');
end if;

select count(*) into v_count from resmetric;
if v_count <>  0 then
  DBMS_STATS.UNLOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC');
  DBMS_STATS.DELETE_TABLE_STATS (OwnName => 'scpomgr',TabName => 'RESMETRIC');
  DBMS_STATS.GATHER_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC',estimate_percent => dbms_stats.auto_sample_size , method_opt =>'for all indexed columns size auto', degree => 4, cascade => true);
  DBMS_STATS.LOCK_TABLE_STATS(ownname => 'scpomgr', tabname => 'RESMETRIC');
end if;

End;
