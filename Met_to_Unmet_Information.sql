select sum(met.totalmet)
  , sum(met.totaldemand)
  , sum(met.delta)
  , round(sum(met.totalmet)/sum(met.totaldemand)*100) percent_met
  ,sum(unmet.totalmet)
  , sum(unmet.totaldemand)
  , sum(unmet.delta)
  , round(sum(unmet.totalmet)/sum(unmet.totaldemand)*100) percent_met
  , sum(met.totalmet)/sum(unmet.totaldemand) as met_to_Unmet_ratio
from udv_demand_met met, udv_demand_unmet unmet;



select sum(totalmet)
  , sum(totaldemand)
  , sum(delta)
  , round(sum(totalmet)/sum(totaldemand)*100) percent_met
from ;

