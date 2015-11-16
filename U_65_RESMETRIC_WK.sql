--------------------------------------------------------
--  DDL for View U_65_RESMETRIC_WK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_RESMETRIC_WK" ("RES", "LOC", "MATCODE", "PRODUCTIONMETHOD", "WEEKS_BELOW_MINCAP", "WEEKS_AT_MINCAP", "WEEKS_AT_MAXCAP", "WEEKS_ABOVE_MAXCAP", "AVG_PERCEN_UTIL") AS 
  select distinct res, loc, matcode, productionmethod, sum(weeks_below_mincap) weeks_below_mincap, sum(weeks_at_mincap) weeks_at_mincap, 
    sum(weeks_at_maxcap) weeks_at_maxcap, sum(weeks_above_maxcap) weeks_above_maxcap, round(avg(percen_util), 2) avg_percen_util
from

(select m.eff, m.res, r.loc, substr(r.res, 8, 2) matcode, substr(r.res, 1, 3) productionmethod, m.value util, minc.qty minc, maxc.qty maxc,
    case when m.value < minc.qty then 1 else 0 end weeks_below_mincap,
    case when m.value = minc.qty then 1 else 0 end weeks_at_mincap,
    case when m.value = maxc.qty then 1 else 0 end weeks_at_maxcap,
    case when m.value > maxc.qty then 1 else 0 end weeks_above_maxcap, 
    case when nvl(maxc.qty, 0) = 0 then 0 else round(m.value/maxc.qty, 4) end percen_util
from res r, resmetric m,
 
    (select eff, res, qty
    from resconstraint
    where category = 11
    ) minc,
    
    (select eff, res, qty
    from resconstraint
    where category = 12
    ) maxc

where m.category = 401
and m.res = r.res
and r.type = 4 --and m.res = 'INSCAP@03ES72'
and m.res = minc.res
and m.eff = minc.eff
and m.res = maxc.res
and m.eff = maxc.eff
)
group by res, loc, matcode, productionmethod
