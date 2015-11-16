--------------------------------------------------------
--  DDL for View U_90_REBALANCE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_90_REBALANCE" ("DEST", "DESCR", "COUNTRY", "POSTALCODE", "SRC_CAND", "SRC_DESCR", "SRC_COUNTRY", "SRC_POSTALCODE") AS 
  SELECT a.loc dest,
          a.descr,
          a.country,
          a.postalcode,
          b.loc src_cand,
          b.descr src_descr,
          b.country src_country,
          b.postalcode src_postalcode
     FROM (SELECT loc,
                  descr,
                  country,
                  postalcode
             FROM loc
            WHERE loc_type = 2) a,
          (SELECT loc,
                  descr,
                  country,
                  postalcode
             FROM loc
            WHERE loc_type = 2) b
    WHERE a.loc <> b.loc AND a.loc = 'ES22'
