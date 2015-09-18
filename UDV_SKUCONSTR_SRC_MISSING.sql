--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_MISSING" ("ITEM", "LOC", "SUMQTY", "TOTALSRC") AS 
  select item, loc, sumqty, totalsrc
from skuconstr_src_all
where totalsrc=0
