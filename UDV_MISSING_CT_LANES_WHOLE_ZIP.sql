--------------------------------------------------------
--  DDL for View UDV_MISSING_CT_LANES_WHOLE_ZIP
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_MISSING_CT_LANES_WHOLE_ZIP" ("PC_SOURCE", "PC_DEST") AS 
  SELECT DISTINCT l.postalcode AS pc_source,
    l2.postalcode              AS pc_dest
  FROM scpomgr.loc l,
    sourcing s,
    loc l2
  WHERE s.source=l.loc
  AND s.dest    =l2.loc
  AND NOT EXISTS
    (SELECT '1'
    FROM udt_cost_transit ct
    WHERE ct.source_pc=l.postalcode
    AND ct.dest_pc=l2.postalcode
    )
