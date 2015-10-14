select item, dest, source, round(sum(value))
from sourcingmetric sm
where dest='3000024003'
and category=418
group by item, dest, source
order by sum(value) desc