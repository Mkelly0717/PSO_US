  select rm.res
      , round(avg(rm.value),2)
    from resmetric rm
    where rm.category=401 and res like '%@USE1'
    group by res
    order by rm.res