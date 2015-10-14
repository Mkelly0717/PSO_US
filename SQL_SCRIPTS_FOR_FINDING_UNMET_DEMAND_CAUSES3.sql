define mySRC = 'UT50';
define myDEST = '4000029931';

/* Get the location info for Both Locations */
select loc, loc_type, postalcode, u_3digitzip
from loc loc
where loc.loc in ('&myDEST', '&mySRC');
/

/* Do the Specific sku's exist */
select *
from sku sku
where loc in ('&myDEST', '&mySRC');
/

/* Do these specific locs exist in gid_limits */
select *
from udt_gidlimits_na gl
where gl.loc='&myDEST'
  and gl.mandatory_loc='&mySRC';
/

/* Are there any GLID LIMIT records for the dest? */
select *
from udt_gidlimits_na gl
where gl.loc='&myDEST';
/
   
/* Does the sourcing Lane exist */
select *
from sourcing src
where src.dest = '&myDEST'
  and src.source = '&mySRC';
/


/* Do Any sku's not exist */
select *
from udt_gidlimits_na gl, sku sku
where ( gl.mandatory_loc=sku.loc and sku.loc is null )
   or ( gl.loc=sku.loc and sku.loc is null );
/

select *
from udt_gidlimits_na gl
where gl.mandatory_loc is not null and gl.loc='&myDEST'
  and  not exists ( select 1 
                     from sourcing src
                    where src.dest=gl.loc
           --           and src.source=gl.mandatory_loc
                 );
/