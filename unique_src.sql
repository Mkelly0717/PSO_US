Select Source, item, Count( Unique Dest ) NDESTS, round(sum(value)) Qty_Shipped
From Sourcingmetric Sm, Loc L, Loc L1
Where sm.category=418
  and sm.value > 0
  And Sm.Source=L.Loc
  And L.Loc_Type In (1,2,4,5)
  And Sm.Dest=L1.Loc
  And L1.Loc_Type=3
Group By Source, Item 
Order By Source Asc, Item Asc;