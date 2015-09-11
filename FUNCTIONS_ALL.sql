--------------------------------------------------------
--  File created - Friday-September-11-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View UDV_COSTTRANSIT_VALIDATION
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_COSTTRANSIT_VALIDATION" ("Validtion Checked", "Record Count") AS 
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
);
--------------------------------------------------------
--  DDL for View UDV_INTJOBS_TABLE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_INTJOBS_TABLE" ("JOBID", "INT_TABLENAME", "TABLENAME", "INSERTCT", "UPDATECT", "TOTALROWSCT", "LASTEXEC", "ERRORCODE", "ERRORTEXT") AS 
  select "JOBID","INT_TABLENAME","TABLENAME","INSERTCT","UPDATECT","TOTALROWSCT","LASTEXEC","ERRORCODE","ERRORTEXT"
from igpmgr.intjobs
where int_tablename like '%BOM%' 
   or int_tablename like '%CAL%'
   or int_tablename like '%COST%'
   or int_tablename like '%CUST%'
   or int_tablename like '%DFU%'
   or int_tablename like '%HIST%'
   or int_tablename like '%INV%'
   or int_tablename like '%ITEM%'
   or int_tablename like '%LOC%'
   or int_tablename like '%PLAN%'
   or int_tablename like '%PROD%'
   or int_tablename like '%PURCH%'
   or int_tablename like '%RES%'   
   or int_tablename like '%SKU%'
   or int_tablename like '%SOURCING%'
   or int_tablename like '%UDT%'
order by lastexec desc;
--------------------------------------------------------
--  DDL for View UDV_MISSING_CT_LANES_WHOLE_ZIP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_MISSING_CT_LANES_WHOLE_ZIP" ("PC_SOURCE", "PC_DEST") AS 
  SELECT DISTINCT l.postalcode AS pc_source,
    l2.postalcode              AS pc_dest
  FROM scpomgr.loc l,
    sourcing s,
    loc l2
  WHERE s.source=l.loc
  AND s.dest    =l2.loc
  AND NOT EXISTS
    (SELECT '1'
    FROM udt_cost_transit ct
    WHERE ct.source_pc=l.postalcode
    AND ct.dest_pc=l2.postalcode
    );
--------------------------------------------------------
--  DDL for View UDV_NO_5OR3_CTLANES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_NO_5OR3_CTLANES" ("ITEM", "LOC", "U_EQUIPMENT_TYPE", "TOTALDEMAND", "POSTALCODE", "3Zip") AS 
  select n5z.item
       ,n5z.loc
       ,n5z.u_equipment_type
       ,n5z.totaldemand
       ,n5z.postalcode
       ,substr(n5z.postalcode,1,3) as "3Zip"
   from udv_skuconstr_no_5zip_costtrn n5z
  where exists
    (
         select 1
           from udv_skuconstr_no_3zip_costtrn n3z
          where n3z.loc             =n5z.loc
            and n3z.item            =n5z.item
            and n3z.u_equipment_type=n5z.u_equipment_type
    );
--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_COLL_NA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_NOLANE_TMP_COLL_NA" ("LOC", "PLANT") AS 
  select distinct tcoll.loc, tcoll.plant
from scpomgr.tmp_coll_na tcoll, scpomgr.loc l1, scpomgr.loc l2
where tcoll.loc=l1.loc
  and tcoll.plant=l2.loc
  and exists ( select '1' 
                 from udt_cost_transit ct
                 where ct.source_pc=l1.postalcode
                   and ct.dest_pc=l2.postalcode
             );
--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_NA_ZIP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_NOLANE_TMP_NA_ZIP" ("LOC", "POSTALCODE") AS 
  select distinct tz.loc, tz.postalcode
from tmp_na_zip tz, loc l
where tz.loc=l.loc
  and not exists
          ( select '1'
              from udt_cost_transit ct
             where ct.source_pc = l.postalcode
               and ct.dest_pc=tz.postalcode
          );
--------------------------------------------------------
--  DDL for View UDV_NOLANE_TMP_NA_ZIP-2
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_NOLANE_TMP_NA_ZIP-2" ("LOC", "POSTALCODE") AS 
  SELECT DISTINCT tz.loc,
    tz.postalcode
  FROM tmp_na_zip tz,
    loc l
  WHERE tz.loc=l.loc
  AND NOT EXISTS
    (SELECT '1'
    FROM udt_cost_transit ct
    WHERE ct.source_pc = tz.postalcode
    AND ct.dest_pc     =  l.postalcode
    );
--------------------------------------------------------
--  DDL for View UDV_NOSKU_TMP_COLL_NA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_NOSKU_TMP_COLL_NA" ("PLANT", "ITEM") AS 
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
--------------------------------------------------------
--  DDL for View UDV_P1_CMP_REPORT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_P1_CMP_REPORT" ("DATE", "%CT1_to_LS1_Match", "%SM1_to_CT1_Match") AS 
  with c1_ls1_match as
    (
         select "DATE" , count(1) match
           from udt_p1_data
          where ct_rank     =1
            and ls_priority = ct_rank
       group by "DATE"
    )
  , c1_ls1_no_match as
    (
         select "DATE" , count(1) no_match
           from udt_p1_data
          where ct_rank      =1
            and ls_priority <> ct_rank
       group by "DATE"
    )
  , sm1_cs1_match as
    (
         select "DATE" , count(1) match
           from udt_p1_data
          where sm_rank      =1
            and sm_rank = ct_rank
       group by "DATE"
    )
  , sm1_cs1_no_match as
    (
         select "DATE" , count(1) no_match
           from udt_p1_data
          where sm_rank      =1
            and sm_rank <> ct_rank
       group by "DATE"
    )
 select ctm."DATE"
       , round(ctm.match/(ctm.match+ctnm.no_match)*100,2) as "%CT1_to_LS1_Match"
       ,round(smm.match/(smm.match+smnm.no_match)*100,2) as "%SM1_to_CT1_Match"
   from c1_ls1_match ctm 
   ,c1_ls1_no_match ctnm
   ,sm1_cs1_match  smm
   ,sm1_cs1_no_match smnm
  where ctm."DATE"=ctnm."DATE"
    and smm."DATE"=ctm."DATE";
--------------------------------------------------------
--  DDL for View UDV_P1_REPORT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_P1_REPORT" ("DATE", "SM_RANK", "LS_PRIORITY", "CT_RANK", "LS_ITEM", "LS_DEST", "LS_SRC", "CT_SOURCE_PC", "CT_DEST_PC", "CT_COST", "CT_TLT", "LS_TLT", "SM_SOURCING", "SM_VALUE", "CT_ET", "CT_DIR") AS 
  with src_metric (sourcing, item, dest, src, qty, rank) as
    (
    /* Sourcing Metric Piece */
    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,round(sum(value),0) qty
      ,rank() over ( partition by sourcing, item, dest order by sum(value)desc ) as rank
    from sourcingmetric sm
      , loc l
    where sm.category=418
        and sm.dest=l.loc --and loc='4000108628'
        and l.loc_type=3
    group by sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
    order by sourcing
      , item
      , dest
      , rank asc
    )
  , cost_transit as
    (
    /* Cost transit Piece */
    select direction
      ,dest_pc
      ,source_pc
      ,cost_pallet
      ,u_equipment_type
      ,transittime
      ,rank() over (partition by direction, u_equipment_type, dest_pc order by cost_pallet asc) rank
    from udt_cost_transit
    where trim(source_pc) is not null
    order by direction
      , u_equipment_type
      , dest_pc
      , rank
    )
  , llamasoft as
    (select item
      ,source
      ,source_pc
      ,dest
      ,dest_pc
      ,transleadtime
      ,priority
    from udt_llamasoft_data
    )
select sysdate
  , sm.rank sm_rank
  ,ls.priority ls_priority
  ,ct.rank ct_rank
  ,ls.item ls_item
  ,ls.dest ls_dest
  ,ls.source ls_src
  ,ct.source_pc ct_source_pc
  ,ct.dest_pc ct_dest_pc
  ,ct.cost_pallet ct_cost
  ,ct.transittime ct_tlt
  ,ls.transleadtime ls_tlt
  ,sm.sourcing sm_sourcing
  ,sm.qty sm_value
  ,ct.u_equipment_type ct_et
  ,ct.direction ct_dir
from llamasoft ls
  , cost_transit ct
  , src_metric sm
  , loc l
where ls.dest=l.loc
    and l.u_equipment_type=ct.u_equipment_type
    and ls.source_pc=ct.source_pc
    and ls.dest_pc = ct.dest_pc
    and ls.source=sm.src
    and ls.dest=sm.dest
    and ls.item=sm.item
order by sysdate asc
  ,ls.item asc
  ,ls.dest
  ,ls.source
  ,sm.rank asc
  ,ls.priority;
--------------------------------------------------------
--  DDL for View UDV_RANK_CMP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_RANK_CMP" ("SM_RANK", "CT_RANK", "COUNT", "%Total_P1") AS 
  with sm_p1_total (sm_rank, total_recs)
as
(
select sm_rank, count(1)
from udt_p1_data
group by sm_rank
),
sm1_prank_counts (sm_rank, ct_rank, count)
as
(
select p1d.sm_rank, p1d.ct_rank, count(1)
from udt_p1_data p1d
group by p1d.sm_rank, p1d.ct_rank
order by p1d.sm_rank asc
)select smc.sm_rank
       ,smc.ct_rank
       ,smc.count
       ,round(smc.count/smt.total_recs*100,3) as "%Total_P1"
from sm1_prank_counts smc, sm_p1_total smt
where smc.sm_rank=smt.sm_rank
and smc.ct_rank <=10;
--------------------------------------------------------
--  DDL for View UDV_RANK_COSTTRANSIT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_RANK_COSTTRANSIT" ("DIRECTION", "DEST_PC", "SOURCE_PC", "COST_PALLET", "U_EQUIPMENT_TYPE", "TRANSITTIME", "RANK") AS 
  select direction
      ,dest_pc
      ,source_pc
      ,cost_pallet
      ,u_equipment_type
      ,transittime
      ,rank() over (partition by direction, u_equipment_type, dest_pc order by cost_pallet asc) rank
    from udt_cost_transit
    where trim(source_pc) is not null
    and dest_pc='06249'
    order by direction
      , u_equipment_type
      , dest_pc
      , rank;
--------------------------------------------------------
--  DDL for View UDV_RANK_SOURCINGMETRIC
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_RANK_SOURCINGMETRIC" ("SOURCING", "ITEM", "DEST", "SOURCE", "QTY", "RANK") AS 
  select sm.sourcing        ,sm.item ,sm.dest ,sm.source
      ,round(sum(value),0) qty ,rank() over ( partition by sourcing, item, dest
        order by sum(value)desc ) as rank
       from sourcingmetric sm , loc l
      where sm.category=418
        and sm.dest    =l.loc
        and l.loc_type =3
   group by sm.sourcing ,sm.item ,sm.dest ,sm.source
   order by sourcing    , item   , dest   , rank asc;
--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_INVALID
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_INVALID" ("LOC", "U_EQUIPMENT_TYPE") AS 
  select l.loc, l.u_equipment_type
from loc l
where l.country='US'
  and trim(l.u_equipment_type) is not null
  and not exists ( select '1' from udt_equipment_type eqt
                 where l.u_equipment_type=eqt.u_equipment_type
              );
--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_IS_NULL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_IS_NULL" ("LOC") AS 
  select l.loc
from loc l
where trim(l.u_equipment_type) is null
  and l.country='US';
--------------------------------------------------------
--  DDL for View UDV_SEIBEL_EQP_TYPE_MISSING
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SEIBEL_EQP_TYPE_MISSING" ("LOC", "U_EQUIPMENT_TYPE") AS 
  select l.loc, l.u_equipment_type
from loc l
where (  l.u_equipment_type='X'
            or 
            trim( l.u_equipment_type) is null
           )
  and l.country='US';
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_COLL_ALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_COLL_ALL" ("ITEM", "LOC", "TOTALDEMAND", "TOTALDEST") AS 
  with total_collection ( item, loc, totaldemand) as
    (select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totaldemand
    from skuconstraint skc
    where skc.category=10
        and skc.qty > 0
    group by skc.item
      , skc.loc
    )
  , total_dest (item, loc, totaldest) as
    (select skc1.item
      , skc1.loc
      , nvl(count(1),0)
    from sourcing src
      , total_collection skc1
    where skc1.item=src.item(+)
        and skc1.loc=src.source(+)
        and src.item is not null
    group by skc1.item
      , skc1.loc
    union
    select skc1.item
      , skc1.loc
      ,0
    from sourcing src
      , total_collection skc1
    where skc1.item=src.item(+)
        and skc1.loc=src.source(+)
        and src.item is null
    )
select tc.item
  , tc.loc
  , tc.totaldemand
  , ts.totaldest
from total_collection tc
  , total_dest ts
where tc.item=ts.item
    and tc.loc=ts.loc;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_COLL_MISSING
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_COLL_MISSING" ("ITEM", "LOC", "SUMQTY", "TOTALDEST") AS 
  select item
      ,loc
      ,sumqty
      ,totaldest
  from skuconstr_coll_all 
where totaldest=0;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_INTER
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_INTER" ("POSTALCODE", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  select pc.postalcode, geo."3DigitZip", pc.u_equipment_type
from udv_skuconstr_no_pc_summary pc, udv_skuconstr_no_3zip_summary geo
where substr(pc.postalcode,1,3) = geo."3DigitZip"
  and pc.u_equipment_type=geo.u_equipment_type;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_3DIGIT_COLL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_3DIGIT_COLL" ("ITEM", "LOC", "TOTALCOLLECTION", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  with total_collection ( item, loc, totalcollection) as
    (select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totalcollection
    from skuconstraint skc
    where skc.category=10
        and skc.qty > 0
    group by skc.item
      , skc.loc
    )
select tc.item
  ,tc.loc
  ,tc.totalcollection
  ,l.u_3digitzip "3DigitZip"
  ,l.u_equipment_type
from total_collection tc
  , loc l
  , udt_cost_transit ct
where tc.loc=l.loc
    and l.u_3digitzip=ct.source_geo(+)
    and ct.source_geo is null;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_3ZIP_COSTTRN
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_3ZIP_COSTTRN" ("ITEM", "LOC", "TOTALDEMAND", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
)
select td.item
      ,td.loc
      ,td.totaldemand
      ,l.u_3digitzip "3DigitZip"
      ,l.u_equipment_type
from total_demand td, loc l, udt_cost_transit ct
where td.loc=l.loc
  and l.u_3digitzip=ct.dest_geo(+)
  and ct.dest_geo is null;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_3ZIP_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_3ZIP_SUMMARY" ("3DigitZip", "U_EQUIPMENT_TYPE", "NUMBERGLIDS") AS 
  select "3DigitZip", u_equipment_type, count(1) NumberGlids
from udv_skuconstr_no_3zip_costtrn
group by "3DigitZip", u_equipment_type;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_5ZIP_COLL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_5ZIP_COLL" ("ITEM", "LOC", "TOTALCOLLECTION", "POSTALCODE", "U_EQUIPMENT_TYPE") AS 
  with total_collection ( item, loc, totalcollection) as
    (select skc.item
      ,skc.loc
      ,round(sum(skc.qty),1) as totalcollection
    from skuconstraint skc
    where skc.category=10
        and skc.qty > 0
    group by skc.item
      , skc.loc
    )
select tc.item
  ,tc.loc
  ,tc.totalcollection
  ,l.postalcode
  ,l.u_equipment_type
from total_collection tc
  , loc l
  , udt_cost_transit ct
where tc.loc=l.loc
    and l.postalcode=ct.source_pc(+)
    and ct.source_pc is null;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_5ZIP_COSTTRN
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_5ZIP_COSTTRN" ("ITEM", "LOC", "TOTALDEMAND", "POSTALCODE", "U_EQUIPMENT_TYPE") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
)
select td.item
      ,td.loc
      ,td.totaldemand
      ,l.postalcode
      ,l.u_equipment_type
from total_demand td, loc l, udt_cost_transit ct
where td.loc=l.loc
  and l.postalcode=ct.dest_pc(+)
  and ct.dest_pc is null;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO_PC_SUMMARY
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO_PC_SUMMARY" ("POSTALCODE", "U_EQUIPMENT_TYPE", "NUMBERGLIDS") AS 
  select Postalcode, u_equipment_type, count(1) NumberGlids
from udv_skuconstr_no_5zip_costtrn
group by postalcode, u_equipment_type;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_NO3ZIP_COSTTRN
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_NO3ZIP_COSTTRN" ("ITEM", "LOC", "TOTALDEMAND", "3DigitZip", "U_EQUIPMENT_TYPE") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
)
select td.item
      ,td.loc
      ,td.totaldemand
      ,l.u_3digitzip "3DigitZip"
      ,l.u_equipment_type
from total_demand td, loc l, udt_cost_transit ct
where td.loc=l.loc
  and l.u_3digitzip=ct.dest_geo(+)
  and ct.dest_geo is null;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_ALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_ALL" ("ITEM", "LOC", "TOTALDEMAND", "TOTALSRC") AS 
  with total_demand ( item, loc, TotalDemand)
as 
(select skc.item
       ,skc.loc
       ,round(sum(skc.qty),1) as TotalDemand
from skuconstraint skc
where skc.category=1
    and skc.qty > 0
group by skc.item, skc.loc
),
total_src (item, loc, TotalSrc)
as 
( select skc1.item, skc1.loc, nvl(count(1),0)
    from sourcing src, total_demand skc1
   where skc1.item=src.item(+)
     and skc1.loc=src.dest(+)
     and src.item is not null
   group by skc1.item, skc1.loc
  union
  select skc1.item, skc1.loc,0
    from sourcing src, total_demand skc1
   where skc1.item=src.item(+)
     and skc1.loc=src.dest(+)
     and src.item is null
)
select td.item, td.loc, td.TotalDemand, ts.TotalSrc
from total_demand td, total_src ts
where td.item=ts.item
  and td.loc=ts.loc;
--------------------------------------------------------
--  DDL for View UDV_SKUCONSTR_SRC_MISSING
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUCONSTR_SRC_MISSING" ("ITEM", "LOC", "SUMQTY", "TOTALSRC") AS 
  select item, loc, sumqty, totalsrc
from skuconstr_src_all
where totalsrc=0;
--------------------------------------------------------
--  DDL for View UDV_SKUS_WITHOUT_DEMAND
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SKUS_WITHOUT_DEMAND" ("LOC", "ITEM", "LOC_TYPE") AS 
  select distinct sku.loc
      , sku.item
      , l.loc_type
    from sku sku, loc l
    where sku.loc=l.loc
      and not exists
        (select 1
        from skuconstraint sc
        where sku.loc=sc.loc
            and sku.item= sc.item
            and category=1
            and qty > 0
        )
    order by sku.loc asc
      , sku.item asc;
--------------------------------------------------------
--  DDL for View UDV_SOURCING_RECS_NO_CT_LANES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_SOURCING_RECS_NO_CT_LANES" ("PC_SOURCE", "PC_DEST") AS 
  select distinct l.postalcode as pc_source,l2.postalcode as pc_dest
from scpomgr.loc l, sourcing s, loc l2
where s.source=l.loc
  and s.dest=l2.loc
  and not exists ( select '1'
                    from udt_cost_transit ct
                   where substr(ct.source_pc,1,5)=substr(l.postalcode,1,5)
                     and substr(ct.dest_pc,1,5)=substr(l2.postalcode,1,5)
                  );
