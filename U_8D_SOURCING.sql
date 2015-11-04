--------------------------------------------------------
--  DDL for Procedure U_8D_SOURCING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_SOURCING" as

--about 12 minutes, (line 35 almost all)

begin

execute immediate 'truncate table optimizersourcingexception';

execute immediate 'truncate table sourcingconstraint';

execute immediate 'truncate table sourcingcost';

execute immediate 'truncate table sourcingdraw';

execute immediate 'truncate table sourcingyield';

execute immediate 'truncate table sourcingleadtime';

execute immediate 'truncate table sourcingmetric';

execute immediate 'truncate table sourcingresmetric';

execute immediate 'truncate table sourcingpenalty';

execute immediate 'truncate table sourcingtarget';

execute immediate 'truncate table marginalpriceandslacksrcng';

execute immediate 'truncate table reducedcostsourcing';

execute immediate 'truncate table sourcingproj';

execute immediate 'truncate table sourcingrequirement';

commit;

delete sourcing;

commit;

end;
