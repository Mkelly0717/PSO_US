--------------------------------------------------------
--  DDL for View UDV_P1_CMP_REPORT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_P1_CMP_REPORT" ("RDATE", "%CT1_to_LS1_Match", "%SM1_to_CT1_Match") AS 
  with c1_ls1_match as
    (select RDATE
      , count(1) match
    from udt_p1_data
    where ct_rank =1
        and ls_priority = ct_rank
    group by RDATE
    )
  , c1_ls1_no_match as
    (select RDATE
      , count(1) no_match
    from udt_p1_data
    where ct_rank =1
        and ls_priority <> ct_rank
    group by RDATE
    )
  , sm1_cs1_match as
    (select RDATE
      , count(1) match
    from udt_p1_data
    where sm_rank =1
        and sm_rank = ct_rank
    group by RDATE
    )
  , sm1_cs1_no_match as
    (select RDATE
      , count(1) no_match
    from udt_p1_data
    where sm_rank =1
        and sm_rank <> ct_rank
    group by RDATE
    )
select ctm.RDATE
  , round(ctm.match/(ctm.match+ctnm.no_match)*100,2) as "%CT1_to_LS1_Match"
  ,round(smm.match /(smm.match+smnm.no_match)*100,2) as "%SM1_to_CT1_Match"
from c1_ls1_match ctm
  ,c1_ls1_no_match ctnm
  ,sm1_cs1_match smm
  ,sm1_cs1_no_match smnm
where ctm.RDATE=ctnm.RDATE
    and smm.RDATE=ctm.RDATE
