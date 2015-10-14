with demand as (select loc, item, sum(qty) qty
from skuconstraint skc
where category=1
group by loc, item
having sum(qty) > 0
)
select dmd.loc, dmd.item, gl.loc, gl.item, dmd.qty
from demand dmd, udt_gidlimits_na gl
where dmd.loc=gl.loc
  and gl.item=dmd.item
  and gl.mandatory_loc is not null
  and not exists ( select 1
                    from sourcing src
                   where src.dest=dmd.loc 
                     and src.item=dmd.item
                 )
order by dmd.loc asc, dmd.item asc
