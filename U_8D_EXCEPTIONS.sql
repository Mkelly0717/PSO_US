--------------------------------------------------------
--  DDL for Procedure U_8D_EXCEPTIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_EXCEPTIONS" as

begin

update sku set oh = 0 where item||loc in 

    (select s.item||s.loc
    from sku s, loc l
    where s.loc = l.loc
    and l.loc_type = 1
    );

commit;

execute immediate 'truncate table optimizerskuexception';

execute immediate 'truncate table optimizersourcingexception';

execute immediate 'truncate table optimizerprodexception';

execute immediate 'truncate table optimizercostexception';

execute immediate 'truncate table optimizercostexception';

execute immediate 'truncate table optimizerresexception';

delete optimizerexception;

execute immediate 'truncate table optimizerlocmap';

execute immediate 'truncate table optimizerresmap';

execute immediate 'truncate table optimizerskumap';

execute immediate 'truncate table optimizersourcingmap';

execute immediate 'truncate table optimizerproductionmap';

execute immediate 'truncate table processsku';

execute immediate 'truncate table optimizerbasiscount';

execute immediate 'truncate table optimizerbasis';

commit;

delete resexception;

commit;

execute immediate 'truncate table skumetric';

execute immediate 'truncate table resmetric';

execute immediate 'truncate table productionmetric';

execute immediate 'truncate table productionresmetric';

execute immediate 'truncate table sourcingresmetric';

execute immediate 'truncate table sourcingmetric';

end;

/

