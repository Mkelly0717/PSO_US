--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_MISSING" ("ITEM", "LOC", "TOTALDEMAND", "TOTALSRC", "LOC_TYPE", "POSTALCODE", "U_3DIGITZIP", "COUNTRY", "U_AREA", "VALID_POSTAL", "VALID_3ZIP", "IS_MAND_LOC", "SKU_EXISTS") AS 
  select item
      , loc
      , totaldemand
      , totalsrc
      , loc_type
      ,postalcode
      ,U_3DIGITZIP
      ,COUNTRY
      ,u_area
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
      , case is_mandatory_loc(loc)
            when 1
            then 'Y'
            else 'N'
        end is_mand_loc
      , case v_sku_exists(loc, item)
            when 1
            then 'Y'
            else 'N'
        end sku_exists
    FROM UDV_SKUCONSTR_SRC_ALL
    where totalsrc=0
order by totaldemand desc
