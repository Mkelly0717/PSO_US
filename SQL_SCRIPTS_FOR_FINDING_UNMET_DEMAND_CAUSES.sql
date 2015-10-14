define mySRC = 'UT50';
define myDEST = '4000029931';

/* Is there Demand for this Location */
select item, sum(totaldemand)
from udv_demand_unmet udv
where udv.dest='&myDEST'
group by item;
/

/* Do Cost transit Lanes Exist */
select l.loc, l.postalcode, l.u_3digitzip, l.u_equipment_type, ct.dest_pc, ct.source_pc, ct.cost_pallet, ct.u_equipment_type
from loc l, udt_cost_transit ct
where l.loc='&myDEST'
  and ct.dest_pc=l.postalcode
  and ct.u_equipment_type=l.u_equipment_type
order by ct.cost_pallet asc;
/

select l.loc, l.postalcode, l.u_3digitzip, l.u_equipment_type, src.dest, src.source, src.item
from loc l, sourcing src
where l.loc='&myDEST'
  and l.loc=src.dest
  and src.item='4055RUCUST';
/  
  
select *
from udv_demand_unmet udmd, sourcing src
where udmd.dest=src.dest
  and udmd.item=src.item;
/  

select *
from udt_gidlimits_na gl;
/

/* All unmet demand with a mandatory loc record */
select distinct mandatory_loc, l.loc_type from
(select udmd.item, udmd.dest, gl.loc, gl.mandatory_loc, udmd.totaldemand
from udv_demand_unmet udmd, udt_gidlimits_na gl
where udmd.dest=gl.loc
  and gl.mandatory_loc is not null
order by totaldemand desc
), loc l
where mandatory_loc=l.loc;
/
