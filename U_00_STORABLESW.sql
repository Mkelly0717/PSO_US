--------------------------------------------------------
--  DDL for View U_00_STORABLESW
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_STORABLESW" ("QB", "STORABLESW", "LOC_TYPE", "CNT", "ELEMENT") AS 
  select substr(item, 6, 2) qb, storablesw, loc_type, count(*) cnt,
    case when storablesw = 0 and loc_type in (1, 3) then 'Never store at MFG or GID'
            when storablesw = 1 and loc_type in (2) then 'Always allow storage at SC' else '?' end element
from sku s, loc l
where s.loc = l.loc and l.loc_type <> 6
group by substr(item, 6, 2) , storablesw, loc_type
order by substr(item, 6, 2) , storablesw, loc_type
