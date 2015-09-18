--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_COLL_MISSING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SKUCONSTR_COLL_MISSING" ("ITEM", "LOC", "SUMQTY", "TOTALDEST") AS 
  select item
      ,loc
      ,sumqty
      ,totaldest
  from skuconstr_coll_all 
where totaldest=0
