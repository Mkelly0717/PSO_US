--------------------------------------------------------
--  DDL for View UDV_RESOURCE_UTIL_BY_WEEK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_RESOURCE_UTIL_BY_WEEK" ("EFF", "VALUE", "RES", "QTY", "PERCENT_UTIL", "POLICY") AS 
  select rm.eff
      , round(rm.value,2) value
      , rm.res
      , rc.qty
      , Round(Rm.Value/Rc.Qty*100,2) Percent_Util
      ,Rc.Policy
    from resmetric rm
      , resconstraint rc
    where rm.category=401
        and rm.value > 0
        and rm.eff=rc.eff
        and rm.res=rc.res
        and rc.qty > 0
    Order By Rm.Res
      , rm.eff
