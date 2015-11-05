/* DFUTOSKU #Periods, Start & End Dates */
select count(distinct(startdate)) "NPeriods"
      ,to_char(min(df.startdate),'MM-DD-YYYY') StartDate
      ,to_char(max(df.startdate),'MM-DD-YYYY')  EndDate
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA';


/* DFUTOSKU Period Histogram */
select df.startdate, count(1)
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA'
group by df.startdate
order by df.startdate asc;

/* DFUTOSKU LOC*LocType Histogram */
select loc_type, count(1)
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA'
group by l.loc_type
order by l.loc_type;

/* DFUTOSKU DMDUNIT Histogram */
select df.dmdunit, count(1)
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA'
group by df.dmdunit
order by df.dmdunit asc;

/* DFUTOSKU DMDGROUP Histogram */
select df.dmdgroup, count(1)
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA'
group by df.dmdgroup
order by df.dmdgroup asc;

/* DfuToSkuFcst DfuLevel*Loc_Type Histogram */
select dv.u_dfulevel, l.loc_type, count(1)
from dfutoskufcst df, dfuview dv, loc l
where df.dmdgroup=dv.dmdgroup
  and df.dmdunit=dv.dmdunit
  and df.dfuloc=dv.loc
  and  l.loc=df.dfuloc
  and l.u_area='NA'
group by dv.u_dfulevel, l.loc_type
order by dv.u_dfulevel, l.loc_type;


/* DFUTOSKU DMDGROUP*DMDUNIT Histogram */
select df.dmdgroup, df.dmdunit, count(1)
from dfutoskufcst df, loc l
where l.loc=df.dfuloc
  and l.u_area='NA'
group by df.dmdgroup, df.dmdunit
order by df.dmdgroup, df.dmdunit asc;


/* DFUTOSKU DMDGROUP*DMDUNIT*DFULEVEL Histogram */
select df.dmdgroup, df.dmdunit, dv.u_dfulevel, count(1)
from dfutoskufcst df, dfuview dv, loc l
where df.dmdgroup=dv.dmdgroup
  and df.dmdunit=dv.dmdunit
  and df.dfuloc=dv.loc
  and  l.loc=df.dfuloc
  and l.u_area='NA'
group by df.dmdgroup, df.dmdunit, dv.u_dfulevel
order by df.dmdgroup, df.dmdunit asc, dv.u_dfulevel;

/* DFUTOSKU DMDGROUP*DMDUNIT*DFULEVEL*LOC_TYPE Histogram */
select df.dmdgroup, df.dmdunit, dv.u_dfulevel, l.loc_type, count(1)
from dfutoskufcst df, dfuview dv, loc l
where df.dmdgroup=dv.dmdgroup
  and df.dmdunit=dv.dmdunit
  and df.dfuloc=dv.loc
  and df.dfuloc=l.loc
  and l.u_area='NA'
group by df.dmdgroup, df.dmdunit, dv.u_dfulevel, l.loc_type
order by df.dmdgroup, df.dmdunit asc, dv.u_dfulevel, l.loc_type;


