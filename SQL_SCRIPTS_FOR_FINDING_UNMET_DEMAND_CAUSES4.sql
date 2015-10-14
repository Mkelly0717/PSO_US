define mySRC = 'UT50';
define myDEST = '4000029931';
select distinct g.item
  , g.loc
  , g.mandatory_loc
from udt_gidlimits_na g
  , loc l
where g.mandatory_loc = l.loc
--    and l.loc_type = 2
    and g.mandatory_loc is not null
    and g.loc='&myDEST';
/