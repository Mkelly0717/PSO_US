--------------------------------------------------------
--  DDL for View UDV_CONSTRAINED_COLLECTION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_CONSTRAINED_COLLECTION" ("LOC", "QTY") AS 
  select distinct nvl(loc, 'Coll Qty Demand') loc
      ,sum (qty) qty
    from skuconstraint k
    where k.category = '10'
        and k.qty > 0
        and not exists (
        (select '1' from udt_fixed_coll t where k.loc=t.loc
        )
    union
        (select '1'
        from udt_default_zip z
          , loc l
        where l.loc=k.loc
            and l.postalcode = z.postalcode
        ) )
    group by rollup(loc)
    having sum(qty) >0
    order by 2 desc
