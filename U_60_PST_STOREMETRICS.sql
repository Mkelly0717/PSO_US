--------------------------------------------------------
--  DDL for Procedure U_60_PST_STOREMETRICS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_60_PST_STOREMETRICS" as

begin

execute immediate 'truncate table udt_skumetric_wk';

insert into udt_skumetric_wk

select *  
from skumetric;

commit;

execute immediate 'truncate table udt_sourcingmetric_wk';

insert into udt_sourcingmetric_wk

select *  
from sourcingmetric;

commit;

execute immediate 'truncate table udt_productionmetric_wk';

insert into udt_productionmetric_wk

select *  
from productionmetric;

commit;

--about five minutes; must run this before running u_60_pst_validation

execute immediate 'truncate table udt_resmetric_wk';

insert into udt_resmetric_wk  
select *  
from resmetric;

commit;

execute immediate 'truncate table udt_productionresmetric_wk';

insert into  udt_productionresmetric_wk  

select *  
from productionresmetric;

commit;



execute immediate 'truncate table udt_sourcingresmetric_wk';
insert into udt_sourcingresmetric_wk  
select *  
from sourcingresmetric;

commit;

end;
