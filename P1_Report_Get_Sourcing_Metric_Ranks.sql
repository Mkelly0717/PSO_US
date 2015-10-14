    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,ls.postalcode
      ,ld.postalcode
      ,ld.u_3digitzip
      ,ls.u_3digitzip
      ,ld.u_equipment_type
      ,round(sum(value),0) qty
      ,dense_rank() over ( partition by item, dest order by sum(value)desc ) as rank
    from sourcingmetric sm
      , loc ls
      , loc ld
    where sm.category=418
        and sm.dest=ld.loc
        and ld.loc_type=3
        And Sm.Source=Ls.Loc
    group by sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,ls.postalcode
      ,ld.postalcode
      ,ld.u_3digitzip
      ,ls.u_3digitzip
      ,ld.u_equipment_type
    order by item
      , dest
      , Rank Asc
      , ld.postalcode