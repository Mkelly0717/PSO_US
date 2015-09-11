--------------------------------------------------------
--  DDL for View UDV_RANK_CMP
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_RANK_CMP" ("SM_RANK", "CT_RANK", "COUNT", "%Total_P1") AS 
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
