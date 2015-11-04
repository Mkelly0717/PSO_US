
define plant='USCY';

select is_plant_valid('&plant')
 from dual;
 
 select *
 from res
 where loc in ( select loc from mak_scratch1)
   and res like '%REP%';
 
 select distinct loc, item, maxcap, yield
 from udt_yield
 where loc in ( select loc from mak_scratch1)
   and productionmethod='REP'
   and (maxcap = 0 or yield=0)
order by loc, item asc;
 
 
select *
from productionmethod
where loc in ( select loc from mak_scratch1)
   and productionmethod='REP';


select *
from productionstep
where loc in ( select loc from mak_scratch1)
   and productionmethod='REP';

select *
from bom
where loc in ( select loc from mak_scratch1)
      and subord like '%AR%';


select *
from sourcingmetric;


 select distinct loc
 from udt_yield
 where loc in ( select loc from mak_scratch1)
   and productionmethod='REP'
   and (maxcap = 0 or yield=0)
order by loc;


select count(1)
from mak_scratch1;

select is_plant_valid(loc)
from mak_scratch1
where is_plant_valid(loc)=0;