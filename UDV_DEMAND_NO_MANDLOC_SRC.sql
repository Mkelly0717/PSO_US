--------------------------------------------------------
--  DDL for View UDV_DEMAND_NO_MANDLOC_SRC
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEMAND_NO_MANDLOC_SRC" ("Problem", "Demand_Location", "Demand_Item", "Total_Demand", "GL_LOC", "GL_MANADATORY_LOC") AS 
  with demand as
    (select skc.loc
      , skc.item
      , sum(skc.qty) qty
    from skuconstraint skc
      , loc l
      , item i
    where category=1
        and l.loc=skc.loc
        and l.u_area='NA'
        and l.enablesw=1
        and i.item=skc.item
        and i.enablesw=1
    group by skc.loc
      , skc.item
    having sum(skc.qty) > 0
    )
    ( /* Find Records with No Sourcing */
      select distinct 'No Sourcing' problem
      ,dmd.loc   Demand_Location
      , dmd.item Demand_Item
      , dmd.qty  Total_Demand
      , gl.loc   GL_LOC
      , gl.mandatory_loc GL_MANADATORY_LOC
    from demand dmd
      , udt_gidlimits_na gl
    where dmd.loc=gl.loc
        and gl.item=dmd.item
        and gl.mandatory_loc is not null
        and not exists
        ( select 1 from sourcing src where src.dest=dmd.loc and src.item=dmd.item
        )
    union
    /* Find Records where the mandatory Mand_loc is invalid */
    select distinct 'Mandatory Mand_Loc Invalid' problem
      ,dmd.loc   Demand_Location
      , dmd.item Demand_Item
      , dmd.qty  Total_Demand
      , gl.loc   GL_LOC
      , gl.mandatory_loc GL_MANADATORY_LOC
    from demand dmd
      , udt_gidlimits_na gl
    where dmd.loc=gl.loc
        and gl.item=dmd.item
        and gl.mandatory_loc is not null
        and not exists
        (select 1
        from loc l
        where l.loc=gl.mandatory_loc
            and l.loc_type in (2,4,5)
            and ( is_5digit(l.postalcode)=1
            or is_3digit(u_3digitzip)=1 )
        )
    union
   /* Find Records where the mandatory loc is invalid */
    select distinct 'Mandatory Loc Invalid' problem
      ,dmd.loc   Demand_Location
      , dmd.item Demand_Item
      , dmd.qty  Total_Demand
      , gl.loc   GL_LOC
      , gl.mandatory_loc GL_MANADATORY_LOC
    from demand dmd
      , udt_gidlimits_na gl
    where dmd.loc=gl.loc
        and gl.item=dmd.item
        and gl.mandatory_loc is not null
        and not exists
        (select 1
        from loc l
        where l.loc=gl.mandatory_loc
            and l.loc_type in (2,4,5)
            and ( is_5digit(l.postalcode)=1
            or is_3digit(u_3digitzip)=1 )
        )
    union
   /* Find Records where the mandatory Mand_loc has No SKU */
    select distinct 'Mandatory Mand_loc SKU Missing' problem
      ,dmd.loc   Demand_Location
      , dmd.item Demand_Item
      , dmd.qty  Total_Demand
      , gl.loc   GL_LOC
      , gl.mandatory_loc GL_MANADATORY_LOC
    from demand dmd
      , udt_gidlimits_na gl
    where dmd.loc=gl.loc
        and gl.item=dmd.item
        and gl.mandatory_loc is not null
        and not exists
        (select 1
        from sku sku
        where sku.loc=gl.mandatory_loc
          and sku.item=dmd.item
        )
union
   /* Find Records where the mandatory loc has No SKU */
    select distinct 'Mandatory Loc SKU Missing' problem
      ,dmd.loc   Demand_Location
      , dmd.item Demand_Item
      , dmd.qty  Total_Demand
      , gl.loc   GL_LOC
      , gl.mandatory_loc GL_MANADATORY_LOC
    from demand dmd
      , udt_gidlimits_na gl
    where dmd.loc=gl.loc
        and gl.item=dmd.item
        and gl.mandatory_loc is not null
        and not exists
        (select 1
        from sku sku
        where sku.loc=gl.loc
          and sku.item=dmd.item
        )
    )
order by 1 asc
  , 2 asc
