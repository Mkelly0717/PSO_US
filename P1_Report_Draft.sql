Select                          --V1.Sourcing Srcing
   V1.Item        Sm_Item
  , V1.Dest        Sm_Dest
  , V1.Dest_5zip   Sm_Dest_5zip
  , V1.Src         SM_Src
  , V2.Src         Sm1_Src
  , V1.Src_5zip    Sm_Src_5zip
  , V2.Src_5zip    Sm1_Src_5zip
  , V1.Et          Sm_Et
  , V1.Qty         Sm_Qty
  , V1.Rank        SM_Rank
  , V2.Qty         Sm1_Qty
  , V2.Rank        Sm1_Rank
  , V1.P1          Sm_P1
  , V1.Cost_Pallet SM_Cost
  , V2.cost_pallet SM1_cost
from UDV_P1_SM_LS V1
  , UDV_P1_SM_LS V2
where V1.p1 is not null
    and V1.rank <> V1.p1
    and V1.item=V2.item
    and V1.dest=V2.dest
    and V1.et=V2.et
    and V1.sourcing=V2.sourcing
    And V2.Rank=1
    And V2.Cost_Pallet < V1.Cost_Pallet
order by V1.item asc, V1.dest asc