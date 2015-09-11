--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_NA_ZIP
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_NOLANE_TMP_NA_ZIP" ("LOC", "POSTALCODE") AS 
  select distinct tz.loc, tz.postalcode
from tmp_na_zip tz, loc l
where tz.loc=l.loc
  and not exists
          ( select '1'
              from udt_cost_transit ct
             where ct.source_pc = l.postalcode
               and ct.dest_pc=tz.postalcode
          );
