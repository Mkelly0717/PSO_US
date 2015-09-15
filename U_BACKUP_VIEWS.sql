--------------------------------------------------------
--  DDL for Procedure U_BACKUP_VIEWS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_BACKUP_VIEWS" 
as 

begin

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_COLL_MISSING';

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_NO_3DIGIT_COLL';

execute immediate 'drop table   MAK_SKUCONSTR_NO_3ZIP_COSTTRN';

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_SUMMARY';

execute immediate 'drop table   MAK_SKUCONSTR_NO_5ZIP_COL';

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN';

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_NO_PC_SUMMARY';

execute immediate 'drop table   SCPOMGR.MAK_SKUCONSTR_SRC_MISSING';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_COLL_MISSING
as select * from SCPOMGR.SKUCONSTR_COLL_MISSING';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_3DIGIT_COLL
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_COLL';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_COSTTRN';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_3ZIP_SUMMARY
as select * from SCPOMGR.SKUCONSTR_NO_3DIGIT_SUMMARY';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COLL
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COLLECTION';


execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COSTTRN';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_5ZIP_COSTTRN
as select * from SCPOMGR.SKUCONSTR_NO_5DIGIT_COSTTRN';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_NO_PC_SUMMARY
as select * from SCPOMGR.SKUCONSTR_NO_PC_SUMMARY';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_SRC_ALL
as select * from SCPOMGR.SKUCONSTR_SRC_ALL';

execute immediate 'create table SCPOMGR.MAK_SKUCONSTR_SRC_MISSING
as select * from SCPOMGR.SKUCONSTR_SRC_MISSING';

end;
