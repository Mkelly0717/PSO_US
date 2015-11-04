--------------------------------------------------------
--  DDL for Procedure U_60_PST_STORE_FCST_TABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_60_PST_STORE_FCST_TABLES" as

begin

execute immediate 'truncate table udt_fcst_wk';
insert into udt_fcst_wk
select * from fcst;
commit;

execute immediate 'truncate table udt_dfutoskufcst_wk';

insert into udt_dfutoskufcst_wk
select * from udt_dfutoskufcst_wk;
commit;

end;
