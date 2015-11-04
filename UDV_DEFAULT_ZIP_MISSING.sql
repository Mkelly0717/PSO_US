--------------------------------------------------------
--  DDL for View UDV_DEFAULT_ZIP_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEFAULT_ZIP_MISSING" ("ZIPCODE", "#Locs", "DEMAND_QTY") AS 
  select nvl(trim(v_get_loc_postalcode(cc.loc)),'Coll Qty Demand') zipcode
      , count(1) "#Locs"
      , round(sum(cc.qty)) demand_qty
    from udv_constrained_collection cc
    where cc.loc <> 'Coll Qty Demand'
    group by rollup(v_get_loc_postalcode(cc.loc))
    order by 3 desc
