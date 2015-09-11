--------------------------------------------------------
--  DDL for View UDV_NOSKU_TMP_COLL_NA
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_NOSKU_TMP_COLL_NA" ("PLANT", "ITEM") AS 
  select distinct tmp.plant, i.item
from tmp_coll_na tmp, item i, loc l
where i.u_stock = 'A'
  and i.item like '4%AI'
  and l.loc=tmp.plant
  and l.loc_type='2'
  and not exists ( select 1 
                     from sku sku
                    where sku.loc=tmp.plant
                      and sku.item = i.item
                  )
order by tmp.plant asc, i.item asc;
