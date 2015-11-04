
define plant='USCY';

select is_plant_valid('&plant')
 from dual;
 
 select *
 from res
 where loc='&plant';
 
 select *
 from udt_yield
 where loc='&plant'
   and productionmethod='INS';
 
 
select *
from productionmethod
where loc='&plant';


select *
from productionstep
where loc='&plant'

select *
from bom
where loc='&plant';