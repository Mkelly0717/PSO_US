select rc.eff, rc.qty, rc.category, rc.res, rm.eff, rm.value, rm.category, rm.res
from resconstraint rc, resmetric rm
where rc.category=12
    and rc.qty > 0
    and rc.res like '%@U%'
    and rm.category=401
    and rm.res like '%@U%'
    and rc.eff=rm.eff(+)
    and rc.res=rm.res
order by rc.res;

select eff, value, category, res -- distinct substr(res,1,instr(res,'@'))
from resmetric rm
where rm.category=401
  and rm.res like '%@U%'  
order by 1 asc;
