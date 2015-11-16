--------------------------------------------------------
--  DDL for View UDC_LOC_HAS_NO_LANE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDC_LOC_HAS_NO_LANE" ("POSTALCODE") AS 
  select distinct l.postalcode
from scpomgr.loc l, udt_cost_transit ct
where u_loctype='C'
  and u_area='NA'
  and l.postalcode = ct.dest_pc(+)
  and trim(ct.dest_pc) is null
