select /* use_hash(resc, resm) */
   resc.res
  , resm.res
  , resc.qty rc_qty
  , round(resm.qty,2) rm_qty
  , round(resc.avg,2) rc_avg
  , round(resm.avg,2) rm_avg
  , round(resm.qty/resc.qty,4)
  , round(resm.avg/resc.avg,4)
from
    (select rc.res res
      ,sum(rc.qty) qty
      ,avg(rc.qty) avg
    from resconstraint rc
    where rc.category=12
        and rc.qty > 0
        and rc.res like '%@U%'
    group by rc.res
    ) resc
  , (select rm.res res
      , sum(value) qty
      ,avg(rm.value) avg
    from resmetric rm
    where rm.category=401
        and rm.res like '%@U%'
    group by rm.res
    ) resm
where resm.res=resc.res
--   and resm.res like '%USE1' ;
