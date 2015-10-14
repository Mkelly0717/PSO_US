--------------------------------------------------------
--  DDL for View UDV_RESOURCE_UTILIZATION_AVG
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_RESOURCE_UTILIZATION_AVG" ("RES", "AVG_PERCENT_UTIL", "STDEV") AS 
  select rm.res
      , round(avg(rm.value   /rc.qty*100),2) avg_percent_util
      , round(stddev(rm.value/rc.qty*100),2) stdev
    from resmetric rm
      , resconstraint rc
    where rm.category=401
        and rc.category=12
        and rm.eff=rc.eff
        and rm.res=rc.res
        and rc.qty > 0
    group by rm.res
      , rm.res
    order by rm.res
