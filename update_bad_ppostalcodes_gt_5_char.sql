insert into igpmgr.intups_loc
(loc, postalcode, u_3digitzip )
select l.loc
     , substr(l.postalcode,1,5)
      ,substr(l.postalcode,1,3)
from loc l
where l.country='US' and loc_type in (1,2,3,4,5,6) and u_area='NA' and enablesw=1
and is_5digit(l.postalcode)=0 
and length(trim(l.postalcode))> 5
and instr(l.postalcode,'-') =6;