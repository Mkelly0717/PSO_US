--------------------------------------------------------
--  DDL for View UDV_COSTTRANSIT_VALIDATION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_COSTTRANSIT_VALIDATION" ("Validtion Checked", "Record Count") AS 
  SELECT 'Number of 5 Digit to 5 Digit Cost Transit lanes ' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is not null
    and trim(source_pc) is not null
    and  trim(source_geo) is null
    and    trim(dest_geo) is null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
)
union
SELECT 'Number of 3 Digit to 3 Digit Cost Transit lanes ' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_geo) is not null
    and trim(source_geo) is not null
    and  trim(source_pc) is null
    and    trim(dest_pc) is null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
)
union
SELECT 'Number of 5 digit Cost Transit lanes with 0 cost' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is not null
    and trim(source_pc) is not null
    and  trim(source_geo) is null
    and    trim(dest_geo) is null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and cost_pallet = 0
)
union
SELECT 'Number of 5 digit Cost Transit lanes with 0 transit time' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is not null
    and trim(source_pc) is not null
    and  trim(source_geo) is null
    and    trim(dest_geo) is null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and transittime = 0
)
union
SELECT 'Number of 5 digit Cost Transit lanes with 0 Distance ' as "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is not null
    and trim(source_pc) is not null
    and  trim(source_geo) is null
    and    trim(dest_geo) is null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and transittime = 0
)
union
SELECT 'Number of 3 digit Cost Transit lanes with 0 cost ' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is null
    and trim(source_pc) is null
    and  trim(source_geo) is not null
    and    trim(dest_geo) is not null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and cost_pallet = 0
)
union
SELECT 'Number of 3 digit Cost Transit lanes with 0 transit time' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is null
    and trim(source_pc) is null
    and  trim(source_geo) is not null
    and    trim(dest_geo) is not null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and transittime = 0
)
union
SELECT 'Number of 3 digit Cost Transit lanes with 0 Distance ' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is null
    and trim(source_pc) is null
    and  trim(source_geo) is not null
    and    trim(dest_geo) is not null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and transittime = 0
)
union
SELECT 'Number of Bad Direction Cost Transit lanes with 0 Distance' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is null
    and trim(source_pc) is null
    and  trim(source_geo) is not null
    and    trim(dest_geo) is not null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and direction <> ' '
)
union
SELECT 'Number of Bad Equipment Cost Transit lanes with 0 Distance ' as  "Validation Check", count(1)
FROM(
  select *
  from udt_cost_transit
  where   trim(dest_pc) is null
    and trim(source_pc) is null
    and  trim(source_geo) is not null
    and    trim(dest_geo) is not null
    and  trim(direction) is null
    and(trim(source_co)  is null or source_co='US')
    and(trim(dest_co)    is null or   dest_co='US')
    and u_equipment_type not in ('VN','FB')
)
union
SELECT 'Number of SKU lanes lanes ' as  "Validation Check", count(1)
FROM(
  select *
  from sku
)
