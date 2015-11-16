--------------------------------------------------------
--  DDL for View UDV_DEFAULT_ZIP_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_DEFAULT_ZIP_MISSING" ("ZIPCODE", "#Locs", "DEMAND_QTY") AS 
  select trim(v_get_loc_postalcode(cc.loc)) zipcode
  , count(1) "#Locs"
  , round(sum(cc.qty)) demand_qty
from udv_constrained_collection cc
where cc.loc <> 'Coll Qty Demand'
group by v_get_loc_postalcode(cc.loc)
order by 3 desc

   COMMENT ON TABLE "SCPOMGR"."UDV_DEFAULT_ZIP_MISSING"  IS 'This view reads the view UDT_CONSTRAINED_COLLECTIONS and
list the uniqe zipcodes for the list of locaitons in it.
This shows how much demand is assigned to each of the zip code wehter they are invalid or not.'
