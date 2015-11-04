/* Select Statement for the conversion and update statement
The update statement should be changed to reflect the changes in
the select statement
*/
select loc
  , loc_type
  , descr
  ,country
  ,u_state
  , case u_plant_network_type
        when 'STORAGE'
        then 5
        when 'DTPM - WM'
        then 4
        when 'DTPM - NON-WM'
        then 4
        when 'ETPM'
        then 4
        when 'SC'
        then 2
        when 'OTHER'
        then 6
        when 'AUTOMOTIVE'
        then 6
        else 6
    end calc_type
  , u_plant_network_type network_type
from loc@scpomgr_chpprddb
where loc_type in (2,4,5)
    and u_area='NA' ;
select distinct u_plant_network_type
from loc@scpomgr_chpprddb
where length(loc)= 4
    and u_area='NA';
    
update loc l
set l.loc_type = (
    case l.u_plant_network_type
        when 'STORAGE'         then 5
        when 'DTPM - WM'       then 4
        when 'DTPM - NON-WM'   then 4
        when 'ETPM'            then 2
        when 'SC'              then 2
        when 'OTHER'           then 6
        when 'AUTOMOTIVE'      then 6
        else 6
    end  ) 
where length(loc)=4 and u_plant_network_type is not null;
