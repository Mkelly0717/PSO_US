    select direction
      ,dest_pc
      ,source_pc
      ,cost_pallet
      ,u_equipment_type
      ,transittime
      ,dense_rank() over (partition by direction, u_equipment_type, dest_pc order by cost_pallet asc) rank
    from udt_cost_transit
    where trim(source_pc) is not null
    order by direction
      , u_equipment_type
      , Dest_Pc
      , rank