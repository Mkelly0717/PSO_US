/* Sourcing Lanes into USZR */
select *
from sourcing
where dest='USZR';

/* Sourcing Lanes COUNT(1) into USZR */
select count(1)
from sourcing
where dest='USZR';

/* UDT_FIXED_COLL records for USZR */
select *
from udt_fixed_coll
where plant='USZR';

/* UDT_FIXED_COLL count(1) Distinct Loc*Plant records for USZR */
select count(distinct(loc || plant))
from udt_fixed_coll
where plant='USZR';

/* UDT_FIXED_COLL list of locs */
select loc
from udt_fixed_coll
where plant='USZR';

/* SkuConstraint Sum Qty Disregarding percentages */
select sum(qty)
from skuconstraint skc
where skc.loc in (select loc
from udt_fixed_coll
where plant='USZR')
and eff = to_date('110115','MMDDYY');


/* SkuConstraint Sum Qty WithOut Loc of 70% */
select sum(qty)
from skuconstraint skc
where skc.loc in (select loc
from udt_fixed_coll
where plant='USZR')
and eff = to_date('110115','MMDDYY')
and loc <> '4000270362';

/* SkuConstraint Sum Qty For Only Loc of 70% */
select sum(qty)
from skuconstraint skc
where skc.loc in (select loc
from udt_fixed_coll
where plant='USZR')
and eff = to_date('110115','MMDDYY')
and loc = '4000270362';