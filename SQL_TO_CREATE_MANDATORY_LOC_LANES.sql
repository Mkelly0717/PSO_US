select distinct u.item, u.dest, u.source
from sourcing c, sku ss, sku sd, 

            (select distinct g.item, g.loc dest, g.exclusive_loc source
            from udt_gidlimits_na g, loc l
            where g.exclusive_loc = l.loc
            and l.loc_type = 4
            and g.exclusive_loc is not null
          and g.de = 'E'
            
            union
            
            select distinct g.item, g.loc, g.mandatory_loc 
            from udt_gidlimits_na g, loc l
            where g.mandatory_loc = l.loc
            and l.loc_type = 2
            and g.mandatory_loc is not null
            ) u
    
where u.item = ss.item
and u.source = ss.loc
and u.item = sd.item
and u.dest = sd.loc
and u.item = c.item(+)
and u.dest = c.dest(+)