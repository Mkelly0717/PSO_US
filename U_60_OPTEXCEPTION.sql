--------------------------------------------------------
--  DDL for View U_60_OPTEXCEPTION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_60_OPTEXCEPTION" ("ITEM", "LOC", "TYPEX", "SEVERITYLEVEL", "EXCEPTIONID", "MESSAGE", "WHEN") AS 
  SELECT item,
            loc,
            typex,
            severitylevel,
            exceptionid,
            MESSAGE,
            when
       FROM (SELECT s.item,
                    s.loc,
                    '1SKU: ' typex,
                    x.severitylevel,
                    x.exceptionid,
                    x.MESSAGE,
                    x.when
               FROM optimizerexception x, optimizerskuexception s
              WHERE     x.serviceid = s.serviceid
                    AND x.functionnum = s.functionnum
                    AND x.exceptionid = s.exceptionid
             UNION
             SELECT s.item,
                    s.loc,
                    '2PM: ' || s.productionmethod typex,
                    x.severitylevel,
                    x.exceptionid,
                    x.MESSAGE,
                    x.when
               FROM optimizerexception x, optimizerprodexception s
              WHERE     x.serviceid = s.serviceid
                    AND x.functionnum = s.functionnum
                    AND x.exceptionid = s.exceptionid
             UNION
             SELECT ' ' item,
                    ' ' loc,
                    '3RES: ' || s.RES typex,
                    x.severitylevel,
                    x.exceptionid,
                    x.MESSAGE,
                    x.when
               FROM optimizerexception x, optimizerresexception s
              WHERE     x.serviceid = s.serviceid
                    AND x.functionnum = s.functionnum
                    AND x.exceptionid = s.exceptionid)
   ORDER BY typex,
            item,
            loc,
            exceptionid
