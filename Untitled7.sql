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
    and rm.res like '%USE1'
group by rm.res
  , rm.res
order by rm.res;


select res
  , round(avg(value),2)
from resmetric rm
where res like '%@USE1' and category=401
group by res;

select res, avg(qty) from resconstraint rc where rc.res like '%USE1' and category=12 group by res;