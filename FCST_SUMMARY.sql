/* Fcst #Periods, Start & End Dates */
select count(distinct(startdate)) "NPeriods"
      ,to_char(min(fc.startdate),'MM-DD-YYYY') StartDate
      ,to_char(max(fc.startdate),'MM-DD-YYYY')  EndDate
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA';


/* Fcst Period Histogram */
select fc.startdate, count(1)
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA'
group by fc.startdate
order by fc.startdate asc;

/* Fcst LOC*LocType Histogram */
select loc_type, count(1)
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA'
group by l.loc_type
order by l.loc_type;

/* Fcst DMDUNIT Histogram */
select fc.dmdunit, count(1)
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA'
group by fc.dmdunit
order by fc.dmdunit asc;

/* Fcst DfuLevel*Loc_Type Histogram */
select dv.u_dfulevel, l.loc_type, count(1)
from fcst fc, dfuview dv, loc l
where fc.dmdgroup=dv.dmdgroup
  and fc.dmdunit=dv.dmdunit
  and fc.loc=dv.loc
  and  l.loc=fc.loc
  and l.u_area='NA'
group by dv.u_dfulevel, l.loc_type
order by dv.u_dfulevel, l.loc_type;


/* Fcst DMDGROUP Histogram */
select fc.dmdgroup, count(1)
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA'
group by fc.dmdgroup
order by fc.dmdgroup asc;

/* Fcst DMDGROUP*DMDUNIT Histogram */
select fc.dmdgroup, fc.dmdunit, count(1)
from fcst fc, loc l
where l.loc=fc.loc
  and l.u_area='NA'
group by fc.dmdgroup, fc.dmdunit
order by fc.dmdgroup, fc.dmdunit asc;


/* Fcst DMDGROUP*DMDUNIT*fcULEVEL Histogram */
select fc.dmdgroup, fc.dmdunit, dv.u_dfulevel, count(1)
from fcst fc, dfuview dv, loc l
where fc.dmdgroup=dv.dmdgroup
  and fc.dmdunit=dv.dmdunit
  and fc.loc=dv.loc
  and  l.loc=fc.loc
  and l.u_area='NA'
group by fc.dmdgroup, fc.dmdunit, dv.u_dfulevel
order by fc.dmdgroup, fc.dmdunit asc, dv.u_dfulevel;

/* Fcst DMDGROUP*DMDUNIT*fcULEVEL*LOC_TYPE Histogram */
select fc.dmdgroup, fc.dmdunit, dv.u_dfulevel, l.loc_type, count(1)
from fcst fc, dfuview dv, loc l
where fc.dmdgroup=dv.dmdgroup
  and fc.dmdunit=dv.dmdunit
  and fc.loc=dv.loc
  and fc.loc=l.loc
  and l.u_area='NA'
group by fc.dmdgroup, fc.dmdunit, dv.u_dfulevel, l.loc_type
order by fc.dmdgroup, fc.dmdunit asc, dv.u_dfulevel, l.loc_type;


