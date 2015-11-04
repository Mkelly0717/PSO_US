--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_MISSING" ("ITEM", "LOC", "TOTALDEMAND", "TOTALSRC", "LOC_TYPE", "POSTALCODE", "U_3DIGITZIP", "COUNTRY", "U_AREA", "U_MAX_SRC", "U_MAX_DIST", "ENABLESW", "VALID_POSTAL", "VALID_3ZIP", "IS_IN_GIDLIMITS_NA", "IS_MANDATORY_LOC", "IS_EXCLUSIVE_LOC", "IS_FORBIDDEN_LOC", "IS_LOC_VALID", "SKU_EXISTS", "IS_5DIGIT_LANE_EXISTS", "#_valid_5zip_lanes", "IS_3DIGIT_LANE_EXISTS", "#_valid_3zip_lanes", "IS_5ZIP_GT_MAX_DIST", "IS_3ZIP_GT_MAX_DIST", "IS_SKUEFF_IN_EFFECT") AS 
  select item
      , loc
      , totaldemand
      , totalsrc
      , loc_type
      ,postalcode
      ,u_3digitzip
      ,country
      ,u_area
      ,u_max_src
      ,u_max_dist
      ,enablesw
      , case is_5digit(postalcode)
            when 1
            then 'Y'
            else 'N'
        end valid_postal
      , case is_3digit(u_3digitzip)
            when 1
            then 'Y'
            else 'N'
        end valid_3zip
      , case is_in_gidlimits_na(loc)
            when 1
            then 'Y'
            else 'N'
        end is_in_gidlimits_na
      , case is_mandatory_loc(loc)
            when 1
            then 'Y'
            else 'N'
        end is_mandatory_loc
      , case is_exclusive_loc(loc)
            when 1
            then 'Y'
            else 'N'
        end is_exclusive_loc
      , case is_forbidden_loc(loc)
            when 1
            then 'Y'
            else 'N'
        end is_forbidden_loc
      , case is_loc_valid(loc)
            when 1
            then 'Y'
            else 'N'
        end is_loc_valid
      , case v_sku_exists(loc, item)
            when 1
            then 'Y'
            else 'N'
        end sku_exists
      , case is_5digit_lane_exists(loc)
            when 1
            then 'Y'
            else 'N'
        end is_5digit_lane_exists
      , v_number_valid_5zip_lanes(loc) "#_valid_5zip_lanes"
      , case is_3digit_lane_exists(loc)
            when 1
            then 'Y'
            else 'N'
        end is_3digit_lane_exists
      , v_number_valid_3zip_lanes(loc) "#_valid_3zip_lanes"
      , case is_5zip_gt_max_dist(loc)
            when 1
            then 'Y'
            else 'N'
        end is_5zip_gt_max_dist
      , case is_3zip_gt_max_dist(loc)
            when 1
            then 'Y'
            else 'N'
        end is_3zip_gt_max_dist
      , case is_skueff_in_effect(loc, item)
            when 1
            then 'Y'
            else 'N'
        end is_skueff_in_effect
    from udv_skuconstr_src_all
    where totalsrc=0
    order by totaldemand desc
