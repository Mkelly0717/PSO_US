--------------------------------------------------------
--  File created - Wednesday-September-09-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View UDV_P1_REPORT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_P1_REPORT" ("DATE", "RANK", "LS_PRIORITY", "LS_ITEM", "LS_DEST", "LS_SRC", "CT_SOURCE_PC", "CT_DEST_PC", "CT_COST", "CT_TLT", "LS_TLT", "SM_SOURCING", "SM_VALUE", "CT_ET", "CT_DIR") AS 
  with src_metric (sourcing, item, dest, src, qty, rank)
as (
/* Sourcing Metric Piece */
select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,round(sum(value),0) qty
      ,rank() 
           over ( partition by sourcing, item, dest
                  order by sum(value)desc
                 ) as rank
from sourcingmetric sm, loc l
where sm.category=418
  and sm.dest=l.loc --and loc='4000108628'
  and l.loc_type=3
group by  sm.sourcing
         ,sm.item
         ,sm.dest
         ,sm.source
order by sourcing, item, dest, rank asc
),
cost_transit as
(
/* Cost transit Piece */
select direction
      ,dest_pc
      ,source_pc
      ,cost_pallet
      ,u_equipment_type
      ,transittime
from udt_cost_transit
),
llamasoft as
(
select item    
      ,source
      ,source_pc
      ,dest
      ,dest_pc
      ,transleadtime
      ,priority
from udt_llamasoft_data
)
select sysdate, sm.rank
      ,ls.priority         ls_priority
      ,ls.item             ls_item
      ,ls.dest             ls_dest
      ,ls.source           ls_src
      ,ct.source_pc        ct_source_pc
      ,ct.dest_pc          ct_dest_pc
      ,ct.cost_pallet      ct_cost
      ,ct.transittime      ct_tlt
      ,ls.transleadtime    ls_tlt
      ,sm.sourcing         sm_sourcing
      ,sm.qty              sm_value
      ,ct.u_equipment_type ct_et
      ,ct.direction        ct_dir
from llamasoft ls, cost_transit ct, src_metric sm, loc l
where ls.dest=l.loc
  and l.U_equipment_type=ct.u_equipment_type
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
