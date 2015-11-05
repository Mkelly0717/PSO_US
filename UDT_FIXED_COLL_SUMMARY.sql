/* Count of records in UDT_FIXED_COLL */
select count(1) from udt_fixed_coll;
select * from udt_fixed_coll;

/* UDT_FIXED_COLL: Distribution*LocType of Plants */
select l.loc_type, count(distinct fc.plant)
from udt_fixed_coll fc, loc l
where l.loc=fc.plant
  and l.u_area='NA'
group by rollup(l.loc_type)
order by l.loc_type;

/* UDT_FIXED_COLL: Distribution*LocType of Plants */
select fc.plant, l.loc_type, count(1)
from udt_fixed_coll fc, loc l
where l.loc=fc.plant
  and l.u_area='NA'
group by fc.plant, l.loc_type
order by fc.plant, l.loc_type;

/* UDT_FIXED_COLL: Distinct Plants with cat 10 demand Records */
select l.loc, count(1) as Weeks
from udt_fixed_coll fc, loc l, skuconstraint skc
where l.loc=fc.plant
  and l.u_area='NA'
  and l.loc_type in (2,4)
  and skc.loc=l.loc
  and skc.category=10
  and skc.qty > 0
group by l.loc
order by l.loc;

/* SKUCONSTRAINT: Distinct Plants with Demand */ --232
select distinct skc.loc
from skuconstraint skc, loc l
where skc.item='4001AI'
  and skc.category=10
  and skc.qty > 0
  and l.loc=skc.loc
  and l.loc_type <> 3
  and l.u_area='NA';
  
/* SKUCONSTRAINT: Distinct Plants with Demand and Exist in UDT_FIXED_COLL */  -- 117
select distinct skc.loc
from skuconstraint skc, loc l, udt_fixed_coll fc
where skc.item='4001AI'
  and skc.category=10
  and skc.qty > 0
  and l.loc=skc.loc
  and l.loc_type <> 3
  and l.u_area='NA'
  and fc.plant=skc.loc;

select distinct skc.loc
from skuconstraint skc, loc l, udt_fixed_coll fc
where skc.item='4001AI'
  and skc.category=10
  and skc.qty > 0
  and l.loc=skc.loc
  and l.loc_type <> 3
  and l.u_area='NA'
  and fc.plant=skc.loc
  and exists ( select 1 from sourcing s where s.dest=skc.loc and skc.item=s.item) ;
  
  

/* UDT_FIXED_COLL: Distinct Plants with Demand*Sourcing Records */
select l.loc, l.loc_type, count(1) as Weeks
from udt_fixed_coll fc
   , loc l
   , skuconstraint skc
   , sourcing src
where l.loc=fc.plant
  and l.u_area='NA'
  and l.loc_type  in (2,4)
  and src.source=skc.loc
  and src.item=skc.item
  and src.dest=fc.plant
  and skc.category=10
  and skc.qty > 0
group by l.loc, l.loc_type
order by l.loc, l.loc_type;

