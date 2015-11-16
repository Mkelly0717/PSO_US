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

   COMMENT ON TABLE "SCPOMGR"."UDV_CONSTRAINED_COLLECTION"  IS '
This view lists all of the locaiton in SKUCONSTRAINT (Category=10, qty > 0) 
for which:
1) Location does not exist in the UDT_FIXED_COLL table
    AND...
2) The postal code for the location is not in the UDT_DEFAULT_ZIP table.

Note that the reason many of these may not be found could be do to an invalid postal code on the location record.


'
