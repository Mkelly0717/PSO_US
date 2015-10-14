    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,round(sum(value),0) qty
      ,dense_rank() over ( partition by item, dest order by sum(value)desc ) as rank
    from sourcingmetric sm
      , loc l
    where sm.category=418
        and sm.dest=l.loc
        and l.loc_type=3
    group by sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
    order by item
      , Dest
      , rank asc