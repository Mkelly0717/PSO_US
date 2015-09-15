--------------------------------------------------------
--  DDL for Procedure U_30_SRC_DAILY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_30_SRC_DAILY" as

begin

--sourcing for issues

scpomgr.u_8d_sourcing;

/******************************************************************
** Part 1: create one sourcing record for each exclusive TPM SKU  * 
*******************************************************************/
insert into intups_sourcing ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw, yieldfactor
                      ,supplyleadtime, costpercentage, supplytransfercost
                      ,nonewsupplydate, shipcal, ff_trigger_control
                      ,pullforwarddur, splitqty, loaddur, unloaddur, reviewcal
                      ,uselookaheadsw, convenientshipqty, convenientadjuppct
                      ,convenientoverridethreshold, roundingfactor, ordergroup
                      ,ordergroupmember, lotsizesenabledsw
                      ,convenientadjdownpct
                      )
select distinct 'U_30_SRC_DAILY_PART1', u.item, u.dest, u.source
      , 'TRUCK' transmode, v_init_eff_date eff
      ,1 factor, ' ' arrivcal, 0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw
      ,0 shrinkagefactor, 0 maxshipqty, ' ' abbr, 'ISS1EXCL' sourcing
      ,v_init_eff_date disc, 1440 * 365 * 100 maxleadtime, 0 minleadtime
      ,1 priority, 1 enablesw, 100 yieldfactor, 0 supplyleadtime
      ,100 costpercentage, 0 supplytransfercost, v_init_eff_date nonewsupplydate
      ,' ' shipcal, ''  ff_trigger_control, 0 pullforwarddur, 0 splitqty
      ,0 loaddur, 0 unloaddur, ' ' reviewcal, 1 uselookaheadsw
      ,0 convenientshipqty, 0 convenientadjuppct, 0 convenientoverridethreshold
      ,0 roundingfactor, ' ' ordergroup, ' ' ordergroupmember
      ,0 lotsizesenabledsw, 0 convenientadjdownpct
from sourcing c, sku ss, sku sd, 

            (select distinct g.item, g.loc dest, g.exclusive_loc source
            from udt_gidlimits_na g, loc l
            where g.exclusive_loc = l.loc
            and l.loc_type = 4
            and g.exclusive_loc is not null
            and g.de = 'E'
            
            union
            
            select distinct g.item, g.loc, g.mandatory_loc 
            from udt_gidlimits_na g, loc l
            where g.mandatory_loc = l.loc
            and l.loc_type = 2
            and g.mandatory_loc is not null
            ) u
    
where u.item = ss.item
and u.source = ss.loc
and u.item = sd.item
and u.dest = sd.loc
and u.item = c.item(+)
and u.dest = c.dest(+)
and c.item is null;

commit;

/*******************************************************************************
** Part 2: Find all possible sources within loc.u_max_dist nullu_max_srcs 
**         where udt_cost_transit matches source_pc and dest_pc
**     ==> This should Exclude exclusive TPM SKU's which where handled in Part 1.
**         Make sure that: Get all possible matches of Source Plants to each GLID
**           1) where it is not an exclusive or forbidded lanes
**           2) udt_cost_transist.distance <- loc.u_max_dist 
**           3) Number of sources ranked by cost < loc.u_max_src
*******************************************************************************/
--  First do the 5digit zip to 5 digit zip. because union takes too long
insert into igpmgr.intins_sourcing 
                    ( integration_jobid
                      ,item, dest, source, transmode, eff,     factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw,shrinkagefactor
                      ,maxshipqty, abbr, sourcing, disc, maxleadtime, minleadtime
                      ,priority, enablesw, yieldfactor, supplyleadtime
                      ,costpercentage, supplytransfercost, nonewsupplydate
                      ,shipcal, ff_trigger_control, pullforwarddur, splitqty
                      ,loaddur, unloaddur, reviewcal, uselookaheadsw
                      ,convenientshipqty, convenientadjuppct
                      ,convenientoverridethreshold, roundingfactor, ordergroup
                      ,ordergroupmember, lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART2'
      ,ranked_lanes.item, ranked_lanes.dest,ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      , 1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      , ''  ff_trigger_control, 0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /******************************************************************** 
     ** Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc
     ** ,max_dist, max_src, distance, rownum 
     *********************************************************************/
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
           over ( partition by all_lanes.item, all_lanes.dest 
                  order by cost_pallet, source asc
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
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
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
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
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
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item, dv.loc, max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
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
        and lanes.u_max_dist      <= lane_cost.distance
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank < ranked_lanes.u_max_src
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;
-- Next do the 3 digit zip to 3 digit zip
insert into igpmgr.intins_sourcing 
                     ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw
                      ,yieldfactor, supplyleadtime, costpercentage
                      ,supplytransfercost, nonewsupplydate, shipcal
                      ,ff_trigger_control, pullforwarddur, splitqty, loaddur
                      ,unloaddur, reviewcal, uselookaheadsw, convenientshipqty
                      ,convenientadjuppct, convenientoverridethreshold
                      ,roundingfactor, ordergroup, ordergroupmember
                      ,lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART2B'
      ,ranked_lanes.item, ranked_lanes.dest, ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      ,1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      ,''  ff_trigger_control,0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /***********************************************************************
     ** Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc
     ** ,max_dist, max_src, distance, rownum 
     ************************************************************************/
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
           over ( partition by all_lanes.item, all_lanes.dest 
                  order by cost_pallet, source asc
                 ) as rank
    from  
    /**************************************************************************
    ** Getting All Lanes: item, dest, dest_pc, source, source_pc max_dist
    ** , max_src, dist and  cost(999 if null)
    ***************************************************************************/
    (select /*+ use_hash(lane_cost, lanes) parallel (lane_cost,4) parallel (lanes,4) */
            lanes.item, lanes.dest, lanes.dest_pc, lanes.source
            ,lanes.source_pc, lanes.u_max_dist, lanes.u_max_src
            ,lane_cost.distance, nvl(lane_cost.cost_pallet, 999) cost_pallet
            ,lane_cost.direction, lane_cost.u_equipment_type
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
             /***********************************************************
             ** Lanes based on matching the source for producitonyield
             ** and dest for sku constraint. dest sku, max_dist, max_src
             ** ,dest_pc ,source, source_pc 
             *************************************************************/            
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
                    (select distinct sku.item, i.u_materialcode matcode
                           ,sku.loc, l.u_max_dist, l.u_max_src
                           ,l.postalcode dest_pc
                           ,l.u_equipment_type u_equipment_type
                           ,l.u_3digitzip dest_geo
                    from skuconstraint sku
                        ,loc l
                        ,item i
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
                      and trim(l.postalcode ) is not null
                      and trim(l.u_3digitzip ) is not null
                    and not exists ( select '1' from udt_gidlimits_na gl 
                                      where gl.loc  = sku.loc 
                                        and gl.item = sku.item 
                                        and gl.mandatory_loc is not null )  
                    ) dest,
                    /***************************************************
                    ** Allowed Sources based on PRODUCITONYIELD (PLant).
                    ** sku, postalcode for the SOURCE SKU
                    ****************************************************/
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
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
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item
                           ,dv.loc
                           ,max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction     = ' '
        and lanes.dest_geo          = lane_cost.dest_geo
        and lanes.source_geo        = lane_cost.source_geo
        and lanes.u_max_dist       <= lane_cost.distance
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank < ranked_lanes.u_max_src
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;

/*******************************************************************************
** Part 3: where no sourcing find closest loc_type = 2 location  ; less than 4k
**         Here, since I am looking for something not matched before
**===> I am doing this at the GeoCode level. If we want to do this at the 
**     5 digit zip code level, This code needs to be repeated at that level!!!!
*******************************************************************************/

insert into igpmgr.intins_sourcing 
                     ( integration_jobid
                      ,item, dest, source, transmode, eff, factor, arrivcal
                      ,majorshipqty, minorshipqty, enabledyndepsw
                      ,shrinkagefactor, maxshipqty, abbr, sourcing, disc
                      ,maxleadtime, minleadtime, priority, enablesw
                      ,yieldfactor, supplyleadtime, costpercentage
                      ,supplytransfercost, nonewsupplydate, shipcal
                      ,ff_trigger_control, pullforwarddur, splitqty, loaddur
                      ,unloaddur, reviewcal, uselookaheadsw, convenientshipqty
                      ,convenientadjuppct, convenientoverridethreshold
                      ,roundingfactor, ordergroup, ordergroupmember
                      ,lotsizesenabledsw, convenientadjdownpct
                     )

select distinct 'U_30_SRC_DAILY_PART3'
      ,ranked_lanes.item, ranked_lanes.dest, ranked_lanes.source
      ,'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal
      ,0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw, 0 shrinkagefactor
      ,0 maxshipqty, ' ' abbr, 'ISS2MAXDISTSRC' sourcing, v_init_eff_date disc
      ,1440 * 365 * 100 maxleadtime, 0 minleadtime, 1 priority, 1 enablesw
      ,100 yieldfactor, 0 supplyleadtime, 100 costpercentage
      ,0 supplytransfercost, v_init_eff_date nonewsupplydate, ' ' shipcal
      ,''  ff_trigger_control, 0 pullforwarddur, 0 splitqty, 0 loaddur
      ,0 unloaddur, ' ' reviewcal, 1 uselookaheadsw, 0 convenientshipqty
      ,0 convenientadjuppct, 0 convenientoverridethreshold, 0 roundingfactor
      ,' ' ordergroup, ' ' ordergroupmember, 0 lotsizesenabledsw
      ,0 convenientadjdownpct
from sourcing src, 
     /* Ranked Lanes Piece: Source Item, dest, dest_pc, source, source_pc, max_dist, max_src, distance, rownum */
    (select all_lanes.item, all_lanes.dest, all_lanes.dest_pc, all_lanes.source
           ,all_lanes.source_pc, all_lanes.u_max_dist, all_lanes.u_max_src
           ,all_lanes.distance, row_number()
               over (partition by all_lanes.item, all_lanes.dest 
                       order by cost_pallet, source asc
                     ) as rank
    from  
    /* Geting All Lanes: item, dest, dest_pc, source, source_pc max_dist, max_src, dist and  cost(999 if null) */
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
             order by direction, u_equipment_type, source_pc
                     ,dest_pc, source_geo, dest_geo
            )  lane_cost, 
             /* Lanes based on matching the source for producitonyield and dest for sku constraint. 
                 dest sku, max_dist, max_src, dest_pc , source, source_pc 
             */            
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
                    /* Allowed Destinations (GLID) Based on SKUCONSTRAINT ( OR ACTUAL DEMAND)
                       Sku, max _dist, max _src, Postal Code
                    */
                    (select distinct sku.item, i.u_materialcode matcode
                           ,sku.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                           ,l.u_equipment_type u_equipment_type, l.u_3digitzip dest_geo
                    from skuconstraint sku, loc l, item i
                    where sku.category = 1
                      and sku.loc = l.loc
                      and l.loc_type = 3
                      and l.U_AREA='NA'
                      and sku.item = i.item
                      and i.u_stock = 'C'
                      and sku.qty > 0
                      and sku.eff <= trim(sysdate)
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
                    (select distinct p_yield.outputitem item
                          ,p_yield.loc
                          ,l.postalcode source_pc
                          ,l.u_3digitzip source_geo
                          ,ps.status flatbed_status                        
                    from productionyield p_yield
                        ,item i
                        ,loc l
                        ,udt_plant_status ps                              
                    where p_yield.outputitem = i.item
                    and i.u_stock = 'C' 
                    and p_yield.loc = l.loc
                    and l.U_AREA='NA'
                    and l.loc_type = 2
                    and trim(l.postalcode )  is not null
                    and trim(l.u_3digitzip ) is not null
                    and ps.loc=p_yield.loc
                    and ps.res= 'SOURCEFLATBED'
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
                    where l1.loc_type = 2
                      and i1.u_stock='C'
                      and sku.item=i1.item
                      and sku.oh > 0
                      and sku.loc=l1.loc
                      and trim(l1.postalcode )  is not null
                      and trim(l1.u_3digitzip ) is not null
                      and l1.U_AREA='NA'                       
                      and l1.loc=ps.loc
                      and ps.res= 'SOURCEFLATBED'
                    ) source_sku,
                    /* Get the sku and the max number of dfu groups */      
                    (select distinct dv.dmdunit item, dv.loc, max(dv.u_dfu_grp) u_dfu_grp
                    from dfuview dv
                        ,loc l
                        ,skuconstraint sku
                    where dv.loc = l.loc
                      and l.loc_type = 3
                      and dv.dmdgroup in ('ISS', 'CPU')
                      and l.U_AREA='NA'
                      and trim(l.postalcode )  is not null
                      and trim(l.u_3digitzip ) is not null
                      and sku.loc=dv.loc
                      and sku.item=dv.dmdunit
                      and sku.eff <= trim(sysdate)
                      and sku.qty > 0
                    group by dv.dmdunit, dv.loc
                    ) demand_group

            where dest.item = demand_group.item
              and dest.loc = demand_group.loc
              and dest.loc <> source_sku.loc
              and dest.item = source_sku.item
              and ( ( u_equipment_type='FB'and source_sku.flatbed_status=1) 
                   or 
                    (u_equipment_type <> 'FB')
                  )
         ) lanes
        
      where lanes.u_equipment_type = lane_cost.u_equipment_type
        and lane_cost.direction     = ' '
        and lanes.dest_geo          = lane_cost.dest_geo
        and lanes.source_geo        = lane_cost.source_geo
        ) all_lanes
    ) ranked_lanes
/*******************************************************************************
**                      End of In Line Views
*******************************************************************************/
where ranked_lanes.rank = 1
and   ranked_lanes.item = src.item(+)
and   ranked_lanes.dest = src.dest(+)
and   ranked_lanes.source = src.source(+)
/* added by MAK */
and not exists ( select '1' 
                   from udt_gidlimits_na gl1 
                  where gl1.loc  = src.dest
                    and gl1.item = src.item 
                    and gl1.forbidden_loc = src.source )  
and src.item is null;

commit;

/*******************************************************************************
** Part 4: where LOC:U_RUNEW_CUST = 1 for GID find the closest 
**         MFG location (LOC_TYPE = 1) and assign as a single source for RUNEW.
*******************************************************************************/
insert into intins_sourcing ( integration_jobid
    ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)

select distinct 'U_30_SRC_DAILY_PART4'
    ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'ISS4MFG' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
    
from sourcing c, 

    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
    from  

    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
        from
                    
            (select distinct lpad(source_pc, 5, 0) source_pc, lpad(dest_pc, 5, 0) dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
            from udt_cost_transit  
            group by lpad(source_pc, 5, 0), lpad(dest_pc, 5, 0), source_co, dest_co
            )  pc, 
                        
            (select f.item, f.loc dest, f.u_max_dist, f.u_max_src, f.dest_pc, p.loc source, p.source_pc
            from

                    (select s.item, s.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                    from sku s, loc l
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.u_runew_cust = 1
                    and l.loc_type = 3
                    ) f,

                    (select s.item, s.loc, l.postalcode source_pc
                    from sku s, loc l, item i
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.loc_type = 1
                    and s.item = i.item
                    and i.u_stock = 'C'
                    ) p
                    
            where f.item = p.item 
            ) c
                    
        where c.dest_pc = pc.dest_pc(+)
        and c.source_pc = pc.source_pc(+) 
        
        ) u
        
   --where u.distance < u.u_max_dist
   
    ) u
    
where u.rank = 1
and u.item = c.item(+)
and u.dest = c.dest(+)
and c.item is null;

commit;

/*******************************************************************************
** Part 5: where U_RUNEW_CUST = 1 and forecast exists for other 
**         non-RUNEW items then allow sourcing to LOC_TYPE = 1 
**         where substitution logic can be used to satisfy demand 
**         with RUNEW proxy
*******************************************************************************/
insert into intins_sourcing ( integration_jobid
   ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)

select distinct 'U_30_SRC_DAILY_PART5'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'ISS5MFG' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
    
from 

    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
    from  

    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
        from
                    
            (select distinct lpad(source_pc, 5, 0) source_pc, lpad(dest_pc, 5, 0) dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
            from udt_cost_transit  
            group by lpad(source_pc, 5, 0), lpad(dest_pc, 5, 0), source_co, dest_co
            )  pc, 
                        
            (select f.item, f.loc dest, f.u_max_dist, f.u_max_src, f.dest_pc, p.loc source, p.source_pc
            from

                    (select k.item, k.loc, k.u_max_dist, k.u_max_src, k.dest_pc
                    from

                        (select c.item, c.dest, c.source
                        from sourcing c, loc l
                        where c.source = l.loc
                        and l.loc_type = 1
                        ) c,

                        (select distinct k.item, k.loc, l.u_max_dist, l.u_max_src, l.postalcode dest_pc
                        from skuconstraint k, loc l, item i
                        where k.loc = l.loc
                        and l.u_area = 'NA'
                        and l.u_runew_cust = 1
                        and k.item <> '4055RUNEW'
                        and k.item = i.item
                        and i.u_stock = 'C'
                        ) k

                    where k.item = c.item(+)
                    and k.loc = c.dest(+)
                    and c.item is null
                    ) f,

                    (select s.item, s.loc, l.postalcode source_pc
                    from sku s, loc l, item i
                    where s.loc = l.loc
                    and l.u_area = 'NA'
                    and l.loc_type = 1
                    and s.item = i.item
                    and i.u_stock = 'C'
                    ) p
                    
            where f.item = p.item 
            ) c
                    
        where c.dest_pc = pc.dest_pc(+)
        and c.source_pc = pc.source_pc(+) 
        
        ) u
        
   --where u.distance < u.u_max_dist
   
    ) u
    
where u.rank = 1;

commit;

/*******************************************************************************
** Part 6: collections
**         Find all possible sources within loc.u_max_dist & loc.u_max_srcs 
**         where udt_cost_transit matches source_pc and dest_pc or source_geo 
**         and dest_geo; 16k
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
  ,item, dest, source, transmode, eff, factor, arrivcal, majorshipqty, minorshipqty
  ,enabledyndepsw,shrinkagefactor, maxshipqty, abbr, sourcing, disc, maxleadtime
  ,minleadtime, priority, enablesw, yieldfactor, supplyleadtime, costpercentage
  ,supplytransfercost, nonewsupplydate, shipcal, ff_trigger_control
  ,pullforwarddur, splitqty, loaddur, unloaddur, reviewcal, uselookaheadsw
  ,convenientshipqty, convenientadjuppct, convenientoverridethreshold
  ,roundingfactor, ordergroup, ordergroupmember, lotsizesenabledsw
  ,convenientadjdownpct
)
select distinct 'U_30_SRC_DAILY_PART6'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'COLL0FIXED' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
from (select i.item item 
      ,l1.loc source
      ,l1.postalcode source_pc
      ,l2.loc dest
      ,l2.postalcode dest_pc
      ,l1.u_max_dist max_dist
      ,l1.u_max_src  max_src
from udt_fixed_coll coll, item i, loc l1, loc l2
where (  ( i.u_stock = 'A'
           and coll.loc=l1.loc
           and l1.loc_type in ('2','3','4')
          )
       or
         ( i.u_stock = 'B'
           and coll.loc=l1.loc
           and l1.loc_type in ('2','4')
         )
      )
  and coll.plant = l2.loc
  and l2.loc_type='2'
  and exists ( select '1'
                from skuconstraint skc 
               where skc.loc=l1.loc 
                 and skc.item=i.item
                 and skc.category=10
                 and skc.qty>0
             )
                        
    ) u
where exists (select 1 
              from sku sku1, sku sku2 
             where sku1.item=u.item 
               and sku1.loc=u.dest
               and sku2.item=u.item 
               and sku2.loc=u.source)
and not exists ( select 1
                   from sourcing src
                  where src.item=u.item
                    and src.source=u.source
                    and src.dest=u.dest
                );
commit;

--where unmatched try to find single lowest cost freight

--insert into sourcing (item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
--    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
--    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
--    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)
--
--select distinct u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
--    ' ' abbr, 'COLL1UNMATCHED' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
--    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
--    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
--    0 convenientadjdownpct
--from 
--
--    (select u.item, u.dest, u.dest_pc, u.source, u.source_pc, u.u_max_dist, u.u_max_src, u.distance, u.cost_pallet, row_number()
--                            over (partition by u.item, u.dest order by cost_pallet, source asc) as rank
--    from 
--
--    (select c.item, c.dest, c.dest_pc, c.source, c.source_pc, c.u_max_dist, c.u_max_src, pc.distance,nvl(pc.cost_pallet, 999) cost_pallet
--        from
--                    
--            (select distinct source_pc, dest_pc, source_co, max(distance) distance, max(cost_pallet) cost_pallet 
--            from udt_cost_transit  
--            group by source_pc, dest_pc, source_co, dest_co
--            )  pc, 
--            
--            (select distinct c.item, c.loc source, c.u_max_dist, c.u_max_src, c.source_pc, s.loc dest, s.dest_pc
--             from
--                                     
--                    (select distinct k.item, k.loc, l.u_max_dist, l.u_max_src, l.postalcode source_pc
--                    from skuconstraint k, loc l, item i, sourcing c
--                    where k.category = 10
--                    and k.loc = l.loc
--                    and l.loc_type = 3
--                    and k.item = i.item
--                    and i.u_stock = 'A'
--                    and k.qty > 0
--                    and k.item = c.item(+)
--                    and k.loc = c.source(+)
--                    and c.item is null
--                    ) c,
--                    
--                    (select s.item, s.loc, l.postalcode dest_pc
--                    from sku s, loc l, item i
--                    where s.loc = l.loc
--                    and l.loc_type = 2
--                    and s.item = i.item
--                    and i.u_stock = 'A'
--                    and s.item = i.item
--                    ) s
--                
--                where c.item = s.item
--                ) c
--                    
--        where c.dest_pc = pc.dest_pc(+)
--        and c.source_pc = pc.source_pc(+)
--
--        ) u
--        
--    --where u.distance < u.u_max_dist 
--    
--    ) u
--    
--
--where u.rank = 1;
--
--commit;

--if still unmatched use the zip code to default plant table

/*******************************************************************************
** Part 7: 
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
    ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct
)
select distinct 'U_30_SRC_DAILY_PART7'
   ,u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'COLL3ZIPCODE' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
from 

    (SELECT k.item, k.loc source, k.postalcode, z.loc dest, k.qty
         FROM sourcing c, udt_default_zip z, sku s,
         
              (  SELECT DISTINCT k.item, k.loc, lpad(l.postalcode, 5, 0) postalcode, SUM (qty) qty
                   FROM skuconstraint k, item i, loc l
                  WHERE     k.category = 10
                        AND k.item = i.item
                        AND i.u_stock = 'A'
                        AND k.loc = l.loc
                        AND l.loc_type = 3
               GROUP BY k.item, k.loc, l.postalcode
                 HAVING SUM (qty) > 0
                 ) k
                 
        WHERE k.item = c.item(+) 
        AND k.loc = c.source(+)
        and k.postalcode = lpad(z.postalcode, 5, 0)
        and k.item = s.item
        and z.loc = s.loc 
        AND c.item IS NULL
    ) u;

commit;

/*******************************************************************************
** Part 8: TPM relocations (modified 06/19/2015)
*******************************************************************************/
insert into igpmgr.intins_sourcing
( integration_jobid
   ,item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct
)
with 
source_skus ( source,  postal_code, item, stocktype)
 as
  ( select l.loc source, lpad(l.postalcode,5,0) postalcode, i.item, ps.u_stock
  from scpomgr.loc l, scpomgr.udt_plant_status ps, item i, sku sku
     where l.loc_type in ('2','4')
       and l.u_area='NA'
       and l.loc=ps.loc
       and (ps.res like '%RUSOURCE' or ps.res like '%ARSOURCE')
       and ps.status=1
       and ps.u_materialcode=i.u_materialcode
       and ps.u_stock in ('B','C')
       and ps.u_stock=i.u_stock
       and sku.item=i.item
       and sku.loc=l.loc
   ),
dest_skus ( dest,  postal_code,  item, max_dist, max_src, stocktype)
 as  
  ( select l.loc, lpad(l.postalcode,5,0) postalcode, i.item, l.u_max_dist, l.u_max_src, ps.u_stock
  from scpomgr.loc l, scpomgr.udt_plant_status ps, item i, sku sku
     where l.loc_type in ('2','4')
       and l.u_area='NA'
       and l.loc=ps.loc
       and (ps.res like '%RUDEST' or ps.res like '%ARDEST')
       and ps.status=1
       and ps.u_materialcode=i.u_materialcode
       and ps.u_stock in ('B','C')
       and ps.u_stock=i.u_stock
       and sku.item=i.item
       and sku.loc=l.loc
),
lanes (source, dest, item, max_src, cost_pallet)
   as   
   (  
  select src.source, dest.dest, src.item, dest.max_src, max(ct.cost_pallet)
   from source_skus src, dest_skus dest, udt_cost_transit ct
  where src.source <> dest.dest
    and src.item=dest.item
    and src.stocktype=dest.stocktype
    and lpad(src.postal_code,5,0)  = lpad(ct.source_pc,5,0)
    and lpad(dest.postal_code,5,0) = lpad(ct.dest_pc,5,0)
    having max(ct.distance) < 800 -- dest.max_dist
      group by src.source, dest.dest, src.item, dest.max_src
 ),
ranked_lanes ( source, dest, item, max_src, rank)
  as 
   (
 select lane.source, lane.dest, lane.item, lane.max_src
 ,row_number() over (partition by lane.item, lane.dest order by lane.cost_pallet, lane.source asc) as rank
 from lanes lane
)
select distinct 'U_30_SRC_DAILY_PART8' 
   ,rl.item, rl.dest, rl.source, 'TRUCK' transmode, v_init_eff_date eff, 1 factor, ' ' arrivcal, 0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
    ' ' abbr, 'TPM_RELOC' sourcing, v_init_eff_date disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
    100 costpercentage,     0 supplytransfercost,  v_init_eff_date nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
    0 convenientadjdownpct
   from ranked_lanes rl
   where rl.rank <= rl.max_src
   order by rl.dest, rl.item;
      
commit;

--insert into sourcing (item, dest, source, transmode, eff,     factor, arrivcal,     majorshipqty,     minorshipqty,     enabledyndepsw,     shrinkagefactor,     maxshipqty,     abbr,     sourcing,     disc,     
--    maxleadtime,     minleadtime,     priority,     enablesw,     yieldfactor,     supplyleadtime,     costpercentage,     supplytransfercost,     nonewsupplydate,     shipcal,     
--    ff_trigger_control,     pullforwarddur,     splitqty,     loaddur,     unloaddur,     reviewcal,     uselookaheadsw,     convenientshipqty,     convenientadjuppct,     convenientoverridethreshold,     
--    roundingfactor,     ordergroup,     ordergroupmember,     lotsizesenabledsw,     convenientadjdownpct)
--
--select distinct u.item, u.dest, u.source, 'TRUCK' transmode, TO_DATE('01/01/1970','MM/DD/YYYY') eff,     1 factor,    ' ' arrivcal,     0 majorshipqty,     0 minorshipqty,     1 enabledyndepsw,     0 shrinkagefactor,     0 maxshipqty,     
--    ' ' abbr, 'TPM_RELOC' sourcing,     TO_DATE('01/01/1970','MM/DD/YYYY') disc,     1440 * 365 * 100 maxleadtime,     0 minleadtime,     1 priority,     1 enablesw,     100 yieldfactor,     0 supplyleadtime,     
--    100 costpercentage,     0 supplytransfercost,     TO_DATE('01/01/1970','MM/DD/YYYY') nonewsupplydate,     ' ' shipcal,    ''  ff_trigger_control,     0 pullforwarddur,     0 splitqty,     0 loaddur,     0 unloaddur,     
--    ' ' reviewcal,     1 uselookaheadsw,     0 convenientshipqty,     0 convenientadjuppct,     0 convenientoverridethreshold,     0 roundingfactor,     ' ' ordergroup,     ' ' ordergroupmember,     0 lotsizesenabledsw,     
--    0 convenientadjdownpct
--from 
--
--(select t.item, t.matcode, t.source, p.dest
--from 
--
--    (select s.item, s.loc source, r.dest, r.matcode
--    from sku s, item i, udt_tpm_relocation_na r
--    where s.loc = r.source 
--    and s.item = i.item
--    and i.u_materialcode = r.matcode
--    ) t,
--
--    (
--    select s.item, s.loc dest, r.matcode, r.source
--    from udt_tpm_relocation_na r, loc l,
--
--        (select distinct s.item, s.loc, i.u_materialcode
--        from sku s, item i, productionmethod p
--        where s.item = i.item
--        and s.item = p.item
--        and s.loc = p.loc
--        ) s
--
--    where r.dest = l.loc
--    and l.loc_type in (2, 4)
--    and r.dest = s.loc
--    and r.matcode = s.u_materialcode
--    ) p
--
--where t.item = p.item
--and t.source = p.source
--and t.dest = p.dest
--) u;
--
--commit;

/*******************************************************************************
** Part 9: Update Sourcing Min LeadTime
*******************************************************************************/
declare
  cursor cur_selected is
    select c.item, c.dest, c.source, c.sourcing, t.transittime,
    case when t.transittime < 1 then 0 else round(t.transittime, 0)*1440 end transittime_new
    from sourcing c, u_42_src_costs t
    where c.item = t.item
    and c.dest = t.dest
    and c.source = t.source 
for update of c.minleadtime;

begin
  for cur_record in cur_selected loop
  
    update sourcing
    set minleadtime = cur_record.transittime_new
    where current of cur_selected;
    
  end loop;
  commit;
end;

/*******************************************************************************
** Part 10: Add Sourcing Draw Records
*******************************************************************************/
insert into igpmgr.intins_sourcingdraw 
( integration_jobid, sourcing, eff, item, dest, source, drawqty, qtyuom)
select 'U_30_SRC_DAILY_PART10'
       ,c.sourcing, v_init_eff_date eff, c.item, c.dest, c.source
       ,1 drawqty, 18 qtyuom 
from sourcing c, sourcingdraw d
where c.item = d.item(+)
and c.dest = d.dest(+)
and c.source = d.source(+)
and c.sourcing = d.sourcing(+)
and d.item is null;

commit;

/*******************************************************************************
** Part 11: Add Sourcing Yield Records
*******************************************************************************/
insert into igpmgr.intins_sourcingyield 
( integration_jobid, sourcing, eff, item, dest, source, yieldqty, qtyuom)
select 'U_30_SRC_DAILY_PART11'
       ,c.sourcing, v_init_eff_date eff, c.item, c.dest, c.source
       ,1 yieldqty, 18 qtyuom 
from sourcing c, sourcingyield d
where c.item = d.item(+)
and c.dest = d.dest(+)
and c.source = d.source(+)
and c.sourcing = d.sourcing(+)
and d.item is null;

commit;

/*******************************************************************************
** Part 12: Add Res Records
*******************************************************************************/
insert into igpmgr.intins_res 
(integration_jobid, loc, type,     res,    cal,  cost,     descr,  avgskuchg
  ,avgfamilychg,  avgskuchgcost,  avgfamilychgcost,     levelloadsw,     
    levelseqnum,  criticalitem, checkmaxcap,  unitpenalty,  adjfactor,  source,  enablesw,  subtype,   qtyuom,   currencyuom,     productionfamilychgoveropt
)
select distinct 'U_30_SRC_DAILY_PART12'
   ,u.dest loc, 5 type,     u.res,     ' '  cal,     0 cost,     ' '  descr,     0 avgskuchg,     0 avgfamilychg,     0 avgskuchgcost,     0 avgfamilychgcost,     0 levelloadsw,     
    1 levelseqnum,     ' '  criticalitem,     1 checkmaxcap,     0 unitpenalty,     1 adjfactor,  u.source,     1 enablesw,     6 subtype,     18 qtyuom,     11 currencyuom,     0 productionfamilychgoveropt
from res r,

    (select distinct c.source, c.dest , c.source||'->'||c.dest res from sourcing c
    ) u

where u.res = r.res(+)
and r.res is null;

commit;

/*******************************************************************************
** Part 13: Add SourcingRequirement Records
*******************************************************************************/
insert into igpmgr.intins_sourcingreq
( integration_jobid, stepnum,     nextsteptiming,     rate,     leadtime,     offset,     enablesw,     sourcing,     eff,     res,     item,     dest,     source,     qtyuom
)

select 'U_30_SRC_DAILY_PART13'
       ,1 stepnum,     3 nextsteptiming,     1 rate,     0 leadtime,     0 offset,     1 enablesw,     u.sourcing,     to_date('01/01/1970', 'MM/DD/YYYY') eff,     u.res,     u.item,     u.dest,     u.source,     18 qtyuom
from sourcingrequirement r, 

    (select c.item, c.dest, c.source, c.sourcing, c.source||'->'||c.dest res from sourcing c
    ) u
    
where u.item = r.item(+)
and u.dest = r.dest(+)
and u.source = r.source(+)
and u.sourcing = r.sourcing(+)
and r.item is null;

commit;

/*******************************************************************************
** Part 14: Add Cost Records
*******************************************************************************/
insert into igpmgr.intins_cost 
( integration_jobid, cost,  enablesw,   cumulativesw,  groupedsw,  sharedsw
  ,  qtyuom,  currencyuom,   accumcal,  maxqty,     maxutilization
)
select distinct 'U_30_SRC_DAILY_PART14'
    ,'LOCAL:RES:'||u.res||'-202' cost,     1 enablesw,     0 cumulativesw
    ,     0 groupedsw,     0 sharedsw,     18 qtyuom,     11 currencyuom
    ,    ' '   accumcal,     0 maxqty,     0 maxutilization
from cost c, 

    (select c.item, c.dest, c.source, c.sourcing, c.source||'->'||c.dest res, 'LOCAL:RES:'||c.source||'->'||c.dest||'-202' cost  from sourcing c
    ) u
    
where u.cost = c.cost(+)
and c.cost is null;

commit;

/*******************************************************************************
** Part 15: Now insert costtier records for 5 digit lanes 
*******************************************************************************/
insert into igpmgr.intins_costtier 
(integration_jobid, breakqty, category, value, eff, cost)
    select distinct 'U_30_SRC_DAILY_PART15'
      ,0 breakqty
      ,303 category
      ,lane_5zip_costed.value
      ,v_init_eff_date eff
      ,lane_5zip_costed.cost
    from costtier costtier
      , cost cost
      , (select distinct lane_5zip.source source
          ,lane_5zip.dest dest
          ,'LOCAL:RES:'
            ||lane_5zip.source
            ||'->'
            ||lane_5zip.dest
            ||'-202' cost
          ,nvl(round(tranit_cost.cost_pallet/480, 3), 10) value
        from udt_cost_transit tranit_cost
          , (select distinct src.source
              ,src.dest
              ,ls.postalcode source_pc
              ,ld.postalcode dest_pc
              ,case
                    when ld.u_equipment_type = 'FB'
                    then 'FB'
                    else 'VN'
                end u_equipment_type
            from sourcing src
              , loc ls
              , loc ld
            where src.source = ls.loc
                and src.dest = ld.loc
            ) lane_5zip
        where tranit_cost.direction(+)=' '
            and tranit_cost.u_equipment_type(+)=lane_5zip.u_equipment_type
            and lane_5zip.dest_pc = tranit_cost.dest_pc(+)
            and lane_5zip.source_pc = tranit_cost.source_pc(+)
        order by source
          , dest
        ) lane_5zip_costed
    where cost.cost = lane_5zip_costed.cost
      and lane_5zip_costed.cost = costtier.cost(+)
      and costtier.cost is null;

commit;


/**********************************************************
** Part 16: Now insert costtier records for 3 digit lanes 
**          where the 5 digit lanes were defaulted 
**          or have a higher cost
***********************************************************/
insert into intups_costtier 
(integration_jobid, breakqty, category, value, eff, cost)
select distinct 'U_30_SRC_DAILY_PART16'
          ,0 breakqty
          ,303 category
          ,lane_3zip_costed.value
          ,v_init_eff_date eff
          ,lane_3zip_costed.cost
from costtier costtier, cost cost, 
    (select distinct lane_3zip.source source
             ,lane_3zip.dest dest
             ,'LOCAL:RES:'||lane_3zip.source||'->'||lane_3zip.dest||'-202' cost
             ,nvl(round(tranit_cost.cost_pallet/480, 3), 10) value
      from udt_cost_transit tranit_cost, 
        ( select distinct src.source
                   ,src.dest
                   ,ls.u_3digitzip source_geo
                   ,ld.u_3digitzip dest_geo
                   ,case 
                      when ld.u_equipment_type = 'FB' then 'FB'
                      else 'VN'
                    end u_equipment_type
           from sourcing src, loc ls, loc ld 
          where src.source = ls.loc
            and src.dest = ld.loc
          ) lane_3zip        
    where tranit_cost.direction(+)=' '
      and lane_3zip.u_equipment_type = tranit_cost.u_equipment_type(+)
      and lane_3zip.source_geo = tranit_cost.source_geo(+)
      and lane_3zip.dest_geo   = tranit_cost.dest_geo(+)
    order by source, dest
    ) lane_3zip_costed
    
where cost.cost = lane_3zip_costed.cost
and lane_3zip_costed.cost = costtier.cost(+)
and costtier.value >= 10;

commit;

/**********************************************************
** Part 17: Now Populate teh ResCost table
***********************************************************/
insert into  intups_rescost 
(integration_jobid, category, res, localcost, tieredcost)
select distinct 'U_30_SRC_DAILY_PART17'
      ,202 category, u.res, u.cost localcost, ' ' tieredcost
from rescost r, costtier t, 

    (select distinct c.dest
  , c.source
  , c.source
    ||'->'
    ||c.dest res
  , 'LOCAL:RES:'
    ||c.source
    ||'->'
    ||c.dest
    ||'-202' cost
from sourcing c
) u
    
where u.cost = t.cost
and u.cost = r.localcost(+)
and r.localcost is null;

commit;

end;
