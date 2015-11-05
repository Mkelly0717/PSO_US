/* SKUCONSTRAINT #Periods, Start & End Dates */
select count(distinct(eff)) "NPeriods"
      ,to_char(min(skc.eff),'MM-DD-YYYY') eff
      ,to_char(max(skc.eff),'MM-DD-YYYY')  EndDate
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA';
  
  
/* skcst Period Histogram */
select skc.eff, count(1)
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA'
group by skc.eff
order by skc.eff asc;

/* skcst LOC*LocType Histogram */
select loc_type, count(1)
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA'
group by l.loc_type
order by l.loc_type;

/* skcst item Histogram */
select skc.item, count(1)
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA'
group by skc.item
order by skc.item asc;

/* SkuConstraint Item*Loc_Type Histogram */
select skc.item, l.loc_type, skc.category, count(1)
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA'
group by skc.item, l.loc_type, skc.category
order by skc.item, l.loc_type, skc.category;





--select dv.u_dfulevel, l.loc_type, count(1)
--from skuconstraint skc, dfuview dv, loc l
--where skc.dmdgroup=dv.dmdgroup
--  and skc.item=dv.dmdunit
--  and skc.loc=dv.loc
--  and  l.loc=skc.loc
--  and l.u_area='NA'
--group by dv.u_dfulevel, l.loc_type
--order by dv.u_dfulevel, l.loc_type;


/* skcst DMDGROUP Histogram */
select skc.dmdgroup, count(1)
from skuconstraint skc, loc l
where l.loc=skc.loc
  and l.u_area='NA'
group by skc.dmdgroup
order by skc.dmdgroup asc;

--/* skcst DMDGROUP*item Histogram */
--select skc.dmdgroup, skc.item, count(1)
--from skuconstraint skc, loc l
--where l.loc=skc.loc
--  and l.u_area='NA'
--group by skc.dmdgroup, skc.item
--order by skc.dmdgroup, skc.item asc;
--
--
--/* skcst DMDGROUP*item*skcULEVEL Histogram */
--select skc.dmdgroup, skc.item, dv.u_dfulevel, count(1)
--from skuconstraint skc, dfuview dv, loc l
--where skc.dmdgroup=dv.dmdgroup
--  and skc.item=dv.dmdunit
--  and skc.loc=dv.loc
--  and  l.loc=skc.loc
--  and l.u_area='NA'
--group by skc.dmdgroup, skc.item, dv.u_dfulevel
--order by skc.dmdgroup, skc.item asc, dv.u_dfulevel;
--
--/* skcst DMDGROUP*item*skcULEVEL*LOC_TYPE Histogram */
--select skc.dmdgroup, skc.item, dv.u_dfulevel, l.loc_type, count(1)
--from skuconstraint skc, dfuview dv, loc l
--where skc.dmdgroup=dv.dmdgroup
--  and skc.item=dv.dmdunit
--  and skc.loc=dv.loc
--  and skc.loc=l.loc
--  and l.u_area='NA'
--group by skc.dmdgroup, skc.item, dv.u_dfulevel, l.loc_type
--order by skc.dmdgroup, skc.item asc, dv.u_dfulevel, l.loc_type;
--
--
