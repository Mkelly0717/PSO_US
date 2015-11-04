insert into igpmgr.intups_loc
(loc, u_state )
select l.loc
  , t.u_state
from loc l
  , loc@scpomgr_chpprddb t
where l.country='US'
    and l.loc_type in (1,2,3,4,5,6)
    and l.u_area='NA'
    and exists
    ( select 1 from dfuview dv where dv.loc=loc and dv.u_dfulevel = 0
    )
    and t.loc=l.loc;