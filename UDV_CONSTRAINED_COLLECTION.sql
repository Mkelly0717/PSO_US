--------------------------------------------------------
--  DDL for View UDV_CONSTRAINED_COLLECTION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_CONSTRAINED_COLLECTION" ("LOC", "QTY") AS 
  select distinct LOC,SUM (QTY) QTY 
from skuconstraint k
where K.category = '10'
  and not exists ((select LOC 
                     from UDT_FIXED_COLL T 
                    where K.LOC=T.LOC
                  )
                  union 
                  (select LOC 
                     from UDT_DEFAULT_ZIP Z 
                    where K.LOC=Z.LOC
                   )
                  )
group by LOC
having SUM(QTY) >0;
