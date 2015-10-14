   select sm.item sm_item
      , sm.dest sm_dest
      , sm.dest_5zip sm_dest_5zip
      , sm.src sm_src
      , sm.src_5zip sm_src_5zip
      , sm.et sm_et
      , sm.qty sm_qty
      , sm.rank sm_rank
      , sm.p1 sm_p1
      , sm.cost_pallet sm_cost
      , smr1.rank sm1_rank
      , smr1.src sm1_src
      , smr1.src_5zip sm1_src_5zip
      , smr1.qty sm1_qty
      , smr1.cost_pallet sm1_cost
      , round(-1* smr1.qty * ( smr1.cost_pallet - sm.cost_pallet) /570,2) Money_Saved
    from udv_p1_sm_ls sm
      , udv_p1_sm_ls smr1
    where sm.p1 is not null
        and sm.rank <> sm.p1
        and sm.item=smr1.item
        and sm.dest=smr1.dest
        and sm.et=smr1.et
        and sm.sourcing=smr1.sourcing
        and smr1.rank=1
        and smr1.cost_pallet < sm.cost_pallet
    order by sm.item asc
      , sm.dest asc