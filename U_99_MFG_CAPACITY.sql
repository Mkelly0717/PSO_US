--------------------------------------------------------
--  DDL for Procedure U_99_MFG_CAPACITY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_MFG_CAPACITY" as

begin

delete resconstraint where res = 'MFG_CAPACITY';

commit;

insert into resconstraint (eff, policy, qty, dur, category, res, qtyuom, timeuom)

select eff, 2 policy, qty, 1440*7*1 dur, 12 category, 'MFG_CAPACITY' res, 18 qtyuom, 0 timeuom  --need to factor not by 5 days per week
from tmp_mfgcap;

commit;

end;

/

