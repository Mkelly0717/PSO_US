select rm.res, avg(rm.value/rc.qty)
from resmetric rm
  , resconstraint rc
where rm.category=401
    and rc.category=12 
    and rc.res like '%@U%'
    and rm.res like '%@U%'
    and rm.eff=rc.eff
    and rm.res=rc.res
    and rc.qty > 0
group by rm.res
order by rm.res