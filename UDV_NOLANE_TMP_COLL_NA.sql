--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_COLL_NA
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_NOLANE_TMP_COLL_NA" ("LOC", "PLANT") AS 
  select distinct tcoll.loc, tcoll.plant
from scpomgr.tmp_coll_na tcoll, scpomgr.loc l1, scpomgr.loc l2
where tcoll.loc=l1.loc
  and tcoll.plant=l2.loc
  and exists ( select '1' 
                 from udt_cost_transit ct
                 where ct.source_pc=l1.postalcode
                   and ct.dest_pc=l2.postalcode
             );
