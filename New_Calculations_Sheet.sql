select item, loc, res, prodrate, productionmethod from productionstep ps;

select item, loc, productionmethod,yieldqty, py.outputitem from productionyield py;

select y.loc, y.maxcap, y.item, y.productionmethod, y.yield, y.maxhrsperday from udt_yield y where y.maxcap>0 or y.yield>0;

select res, avg_percent_util from UDV_RESOURCE_UTILIZATION_AVG;

select * from resmetric rm where rm.res like '%USE1';
select * from resconstraint rc where rc.res like '%USE1';




select ps.item,  py.outputitem
  , ps.loc
  , ps.res
  , ps.productionmethod
  , y.maxcap
  , y.maxhrsperday
  , y.maxhrsperday * 5 "maxhrsperweek"
  , ps.prodrate
  ,py.yieldqty
  ,pu.avg_percent_util "%AvgResUtil"
  ,pu.stdev
  , ps.prodrate * py.yieldqty * (pu.avg_percent_util/100)* y.maxhrsperday * 5 "Quantity_Made"
from productionstep ps
  , productionyield py
  ,udt_yield y
  , udv_resource_utilization_avg pu
where ps.item=py.item
    and ps.item=y.item
    and ps.loc=py.loc
    and ps.loc=y.loc
    and ps.productionmethod=y.productionmethod
    and ps.productionmethod=py.productionmethod
    and ps.res=pu.res
order by ps.item, ps.res asc, ps.loc 

