--------------------------------------------------------
--  DDL for Procedure U_60_PST_STORE_USER_VIEWS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_60_PST_STORE_USER_VIEWS" as

begin

execute immediate 'truncate table udt_demand_detail_report';
insert into udt_demand_detail_report
select * from udv_demand_detail_report;

commit;

end;
