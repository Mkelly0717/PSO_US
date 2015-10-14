create or replace view udv_resource_util_new as
WITH INFO AS (   
   SELECT  RC.RES, RC.EFF, CASE
                             WHEN RM.VALUE > 0 THEN RC.QTY/RM.VALUE
                             ELSE 0
                           end wk_avg
     from resmetric rm
      , RESCONSTRAINT RC
    WHERE RM.CATEGORY(+)=401
        AND RC.CATEGORY=12
        AND RM.EFF(+)=RC.EFF
        AND RM.RES(+)=RC.RES
        and rc.eff between to_date('092715','mmddyy') and to_date('101115','mmddyy')
)
SELECT RES, COUNT(1) AS N, ROUND(SUM(WK_AVG),2) AS TOTAL, ROUND(AVG(WK_AVG),2) AS AVG_UTIL
       ,round(sum(wk_avg)/count(1),2) as my_avg_calc
FROM INFO I
group by res