/* TPM At level 1 aggregated by dmdgroup */
select f.dmdunit, f.dmdgroup, f.loc, f.startdate
 from fcst f
  , loc l
  , item i
  , dfuview dv
where f.loc=l.loc
    and l.u_area='NA'
    and l.country='US'
    and l.enablesw=1
    and f.dmdgroup ='TPM'
    and f.startdate between v_demand_start_date 
                    and v_demand_start_date  + 30
    and f.dmdunit=i.item
    and dv.dmdunit=f.dmdunit
    and dv.dmdgroup=f.dmdgroup
    and dv.loc=f.loc
    and dv.u_dfulevel=0
order by f.dmdgroup, f.dmdunit, i.u_stock;