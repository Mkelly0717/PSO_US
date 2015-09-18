--------------------------------------------------------
--  DDL for View UDV_SOURCING_RECS_NO_CT_LANES
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SOURCING_RECS_NO_CT_LANES" ("PC_SOURCE", "PC_DEST") AS 
  select distinct l.postalcode as pc_source,l2.postalcode as pc_dest
from scpomgr.loc l, sourcing s, loc l2
where s.source=l.loc
  and s.dest=l2.loc
  and not exists ( select '1'
                    from udt_cost_transit ct
                   where substr(ct.source_pc,1,5)=substr(l.postalcode,1,5)
                     and substr(ct.dest_pc,1,5)=substr(l2.postalcode,1,5)
                  )
