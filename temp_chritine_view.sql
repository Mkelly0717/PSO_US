With Shipped ( sm_source, sm_item, sm_ndests, sm_Qty_Shipped)
As
(
Select Source, item, Count( Unique Dest ) NDESTS, round(sum(value)) Qty_Shipped
From Sourcingmetric Sm, Loc L, Loc L1
Where sm.category=418
  and sm.value > 0
  And Sm.Source=L.Loc
  And L.Loc_Type In (1,2,4,5)
  And Sm.Dest=L1.Loc
  And L1.Loc_Type=3
Group By Source, Item 
Order By Source Asc, Item Asc
), 
Src (Src_Source, Src_Item, Src_Ndests )
As
( Select Src.Source, Src.Item, Count( Unique Src.Dest) Src_Ndests
From Shipped Shipped, Sourcing Src, loc l
Where Shipped.Sm_Source=Src.Source
  And Shipped.Sm_Item=Src.Item
  And Src.Dest=L.Loc
  and l.loc_type=3
Group By Src.Source, Src.Item
Order By Source Asc, Item Asc
),
Dests (src_source, Src_Item, Src_Dest)
As
(
Select distinct src.source, Src.Item, src.dest
From Shipped Shipped, Sourcing Src, loc l
Where Shipped.Sm_Source=Src.Source
  And Shipped.Sm_Item=Src.Item
  And Src.Dest=L.Loc
  And L.Loc_Type=3
Order By Src.Dest, Item Asc
),
Total_Cust_Demand (src_dest, src_item,  Total_Demand )
As
(
Select Dests.Src_Dest,Dests.Src_Item, Round(Sum(qty)) Total_Demand
From Dests Dests, Skuconstraint Skc 
Where Skc.Category=1
  and Skc.loc=Dests.Src_Dest
  And Skc.Item=Dests.Src_Item
Group By Dests.Src_Dest,Dests.Src_Item
)
Select sm_source, sm_item, sm_ndests, src_ndests, sm_Qty_Shipped
From Shipped Shp, Src Src
Where Shp.Sm_Source=Src_Source
  And Shp.Sm_Item= Src.Src_Item
order by sm_source asc, sm_item asc