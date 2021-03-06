select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,ALL_LANES.SOURCE_PC, ALL_LANES.U_MAX_DIST, ALL_LANES.U_MAX_SRC
           ,all_lanes.distance, dense_rank()
           OVER ( PARTITION BY ALL_LANES.ITEM, ALL_LANES.DEST 
                  order by cost_pallet asc
                 ) as rank
    from  
    /*********************************************************************
    ** Getting All Lanes: item, dest, dest_pc, source, source_pc max_dist
    ** ,max_src, dist and  cost(999 if null) 
    **********************************************************************/
    (select /*+ use_hash(lane_cost, lanes) parallel (lane_cost,4) parallel (lanes,4) */
            lanes.item, lanes.dest, lanes.dest_pc, lanes.source, lanes.source_pc
            ,lanes.u_max_dist, lanes.u_max_src, lane_cost.distance
            ,nvl(lane_cost.cost_pallet, 999) cost_pallet, lane_cost.direction
            ,lane_cost.u_equipment_type
        from
            /* Cost for the lanes from UDT_COST_TRANSIT */ 
            (select direction
                   ,u_equipment_type u_equipment_type
                   ,source_pc        source_pc
                   ,source_geo       source_geo
                   ,dest_pc          dest_pc
                   ,dest_geo         dest_geo
                   ,source_co
                   ,distance         distance
                   ,cost_pallet      cost_pallet 
             from udt_cost_transit
             order by direction, u_equipment_type, source_pc, dest_pc, source_geo, dest_geo
            )  lane_cost, 
             /***************************************************************
             ** Lanes based on matching the source for producitonyield and 
             ** dest for sku constraint. dest sku, max_dist, max_src, dest_pc
             ** ,source, source_pc 
             *****************************************************************/            
            (select /*+ use_hash(dest, source_sku, demand_group) parallel (dest,4)parallel (sku_source,4 ) */
                    ' ' direction
                   ,dest.item
                   ,dest.loc dest
                   ,dest.u_max_dist
                   ,dest.u_max_src
                   ,dest.dest_pc
                   ,dest.dest_geo
                   ,source_sku.loc source
                   ,source_sku.source_pc
                   ,source_sku.source_geo
                   ,case when dest.u_equipment_type='FB' then 'FB' 
                         else 'VN' 
                    end u_equipment_type
            
            from
                    /**********************************************************
                    ** Allowed Destinations (GLID) Based on SKUCONSTRAINT 
                    ** ( OR ACTUAL DEMAND) Sku, max _dist, max _src, Postal Code
                    ***********************************************************/
                    (select distinct sku.item
                                    ,i.u_materialcode matcode
                                    ,sku.loc
                                    ,l.u_max_dist
                                    ,l.u_max_src
                                    ,l.postalcode dest_pc
                                    ,l.u_equipment_type u_equipment_type
                                    ,l.u_3digitzip dest_geo
                    from skuconstraint sku
                        ,loc l
                        ,item i
                    where sku.category in (1,6)
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= v_demand_start_date
                      and trim(l.postalcode ) is not null
                      and trim(l.u_3digitzip ) is not null
                    /* added by MAK */
                    and not exists ( select '1' from udt_gidlimits_na gl 
                                      where gl.loc  = sku.loc 
                                        and gl.item = sku.item 
                                        and gl.mandatory_loc is not null )  
                    ) dest,
                    /* Allowed Sources based on PRODUCITONYIELD (PLant).
                       sku, postalcode 
                       for the SOURCE SKU
                    */
                    (select distinct i.item
                          ,l.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from item i
                        ,loc l
                        ,sku sku
                        ,udt_plant_status ps                              
                    where l.loc=sku.loc
                    and l.loc_type in (2,4,5)
                    and l.U_AREA='NA'
                    and l.postalcode  is not null
                    and l.u_3digitzip is not null
                    and is_5digit(l.postalcode) = 1
                    and is_3digit(l.u_3digitzip) = 1
                    and l.enablesw=1
                    and i.item=sku.item
                    and i.u_stock = 'C'
                    and i.enablesw=1
                    and ps.loc=sku.loc
                    and ps.res= 'SOURCEFLATBED'
                    and not exists
                         (select '1'
                            from udt_gidlimits_na gl
                           where   gl.exclusive_loc = sku.loc
                             and gl.item = sku.item
                         )
                    union 
                    select sku.item
                          ,sku.loc
                          ,l1.postalcode source_pc
                          ,l1.u_3digitzip source_geo
                          ,ps.status flatbed_status
                    from sku sku
                        ,loc l1
                        ,item i1
                        ,udt_plant_status ps       
                    where l1.loc_type in (2,4,5)
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED' 
                      and not exists
                         (select '1'
                            from udt_gidlimits_na gl
                           where   gl.exclusive_loc = sku.loc
                             and gl.item = sku.item
                         )
                  ) source_sku
            where dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction    = ' '
        and lanes.dest_pc          = lane_cost.dest_pc
        and lanes.source_pc        = lane_cost.source_pc
        and lanes.u_max_dist      >= lane_cost.distance
        ) all_lanes