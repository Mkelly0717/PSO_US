--------------------------------------------------------
--  DDL for View UDV_P1_LS_COMPARE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_P1_LS_COMPARE" ("SM_RANK", "LS_PRIORITY", "COUNT", "%Total_P1") AS 
  with sm_p1_total (sm_rank, total_recs) as
    ( select sm_rank, count(1) from udt_p1_data group by sm_rank
    )
  , sm1_prank_counts (sm_rank, ls_priority, count) as
    (select p1d.sm_rank
      , p1d.ls_priority
      , count(1)
    from udt_p1_data p1d
    group by p1d.sm_rank
      , p1d.ls_priority
    order by p1d.sm_rank asc
    )
select smc.sm_rank
  ,smc.ls_priority
  ,smc.count
  ,round(smc.count/smt.total_recs*100,3) as "%Total_P1"
from sm1_prank_counts smc
  , sm_p1_total smt
where SMC.SM_RANK=SMT.SM_RANK
    and smc.ls_priority <=10;
