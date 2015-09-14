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

--execute immediate 'truncate table tmp_resmetric';
--
--insert into tmp_resmetric  
--
--select *  
--from resmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_skumetric';
--
--insert into tmp_skumetric 
--
--select *  
--from skumetric;
--
--commit;
--
--execute immediate 'truncate table tmp_productionmetric';
--
--insert into tmp_productionmetric 
--
--select *  
--from productionmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_productionresmetric';
--
--insert into  tmp_productionresmetric  
--
--select *  
--from productionresmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_sourcingmetric';
--
--insert into tmp_sourcingmetric  
--
--select *  
--from sourcingmetric;
--
--commit;
--
--execute immediate 'truncate table tmp_sourcingresmetric';
--
--insert into tmp_sourcingresmetric  
--
--select *  
--from sourcingresmetric;
--
--commit;

end;