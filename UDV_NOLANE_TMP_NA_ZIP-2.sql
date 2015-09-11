--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_NA_ZIP-2
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_NOLANE_TMP_NA_ZIP-2" ("LOC", "POSTALCODE") AS 
  SELECT DISTINCT tz.loc,
    tz.postalcode
  FROM tmp_na_zip tz,
    loc l
  WHERE tz.loc=l.loc
  AND NOT EXISTS
    (SELECT '1'
    FROM udt_cost_transit ct
    WHERE ct.source_pc = tz.postalcode
    AND ct.dest_pc     =  l.postalcode
    );
