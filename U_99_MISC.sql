--------------------------------------------------------
--  DDL for Procedure U_99_MISC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_MISC" as

begin

insert into item (item,    descr,   uom,  wgt, vol,  unitsperpallet,   unitsperaltship, canceldepthlimit,  unitprice,  planlevel,   enablesw, perishablesw,  priitempriority, priority,  restrictplanmode, ddskusw,     
    ddsrccostsw,  dyndepdecimals,  dyndepoption,   dyndeppushopt, dyndepqty,    ff_trigger_control,  itemclass,  invoptimizertype, defaultuom,  allocpolicy,  calccumleadtimesw,    supsngroupnum,      
    u_materialcode,   u_qualitybatch,      u_stock,     u_delete,     u_freight_factor )

select u.item,      ' ' descr,      ' ' uom,     0 wgt,     0 vol,     1 unitsperpallet,     1 unitsperaltship,     0 canceldepthlimit,     0 unitprice,     -1 planlevel,     1 enablesw,     0 perishablesw,     0 priitempriority,     1 priority,     1 restrictplanmode,     0 ddskusw,     
    0 ddsrccostsw,     0 dyndepdecimals,     1 dyndepoption,     1 dyndeppushopt,     1 dyndepqty,      '' ff_trigger_control,     'DEFAULT' itemclass,     1 invoptimizertype,     18 defaultuom,     1 allocpolicy,     0 calccumleadtimesw,     -1 supsngroupnum,      
    u.matcode u_materialcode,      u.qb u_qualitybatch,      u.u_stock,     0 u_delete,     1 u_freight_factor 
from

(select distinct f.dmdunit item, substr(f.dmdunit, 1, 4) matcode, substr(f.dmdunit, 5, 55) qb, 
    case when substr(f.dmdunit, 5, 55) = 'AI' then 'A'
            when substr(f.dmdunit, 5, 55) = 'AR' then 'B' else 'C' end u_stock
from fcst f, loc l
where f.loc = l.loc
and l.u_area = 'NA'
group by f.dmdunit) u;

commit;

insert into loc (loc, descr,  ohpost,   frzstart,    sourcecal,    destcal,   type,    altplantid,    cust,    transzone,  lat,  lon, enablesw,   ff_trigger_control,     
    loc_type,    vendid,    companyid,    workingcal,     seqintexportdur,     seqintimportdur,  seqintlastexportedtoseq,  seqintlastimportedfromseq,     postalcode,    country,     
   currency,    wddarea,   borrowingpct,    hierarchylevel,    u_loctype,    u_city,    u_countrydes,    u_geocode,    u_salesdir,    u_salesdirdes,    u_salesman,     
   u_salesmandes,    u_3digitzip,    u_state,     u_area,    u_region,    u_parent,    u_parent_des,    u_subaffil,    u_grandparent,    u_grandparent_des,    u_affil,    u_custtype,    u_cgroup,    u_industry,    u_mktsector,     
   u_mktsector_des,    u_closingdate,     u_max_src,     u_max_dist,    u_territory,    u_product_speciality)

select y.loc,  ' ' descr,     TO_DATE('01/01/1970','MM/DD/YYYY') ohpost,     TO_DATE('01/01/1970','MM/DD/YYYY') frzstart,     ' ' sourcecal,     ' ' destcal,     1 type,     ' ' altplantid,     ' ' cust,     ' ' transzone,     0 lat,     0 lon,     1 enablesw,      '' ff_trigger_control,     
    2 loc_type,     ' ' vendid,     ' ' companyid,     ' ' workingcal,     0 seqintexportdur,     0 seqintimportdur,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastexportedtoseq,     TO_DATE('01/01/1970','MM/DD/YYYY') seqintlastimportedfromseq,     0 postalcode,     'US' country,     
    ' ' currency,     ' ' wddarea,     0 borrowingpct,     ' ' hierarchylevel,     ' ' u_loctype,     ' ' u_city,     ' ' u_countrydes,     ' ' u_geocode,     ' ' u_salesdir,     ' ' u_salesdirdes,     ' ' u_salesman,     
    ' ' u_salesmandes,     ' ' u_3digitzip,     ' ' u_state,     'NA' u_area,     ' ' u_region,     ' ' u_parent,     ' ' u_parent_des,     ' ' u_subaffil,     ' ' u_grandparent,     ' ' u_grandparent_des,     ' ' u_affil,     ' ' u_custtype,     ' ' u_cgroup,     ' ' u_industry,     ' ' u_mktsector,     
    ' ' u_mktsector_des,     ' ' u_closingdate,     3 u_max_src,     110 u_max_dist,     ' ' u_territory,     ' ' u_product_speciality
from loc l, 

(select distinct loc from udt_yield) y

where y.loc = l.loc(+)
and l.loc is null;

commit;

insert into udt_cost_transit (source_co, dest_co, distance, cost_pallet, primary_key_col)

select c.source_co, c.dest_co, c.distance, c.cost_pallet, c.rk_co+u.pk pk
from

    (select max(primary_key_col) pk from udt_cost_transit
    ) u, 

    (select source_co, dest_co, distance, cost_pallet, row_number()
            over (partition by 1 order by source_co, dest_co asc) as rk_co 
    from 
    tmp_cost
    ) c;

commit;

--populates various LOC columns from staging table

declare
  cursor cur_selected is
        select l2.loc, l2.descr, l2.country, l2.postalcode, l2.u_geocode, l2.u_city 
        from tmp_loc l2, loc l
        where l2.loc = l.loc
    for update of l.descr;
begin
  for cur_record in cur_selected loop
  
    update loc l
    set l.descr = cur_record.descr
    where current of cur_selected;
    
    update loc l
    set l.country = cur_record.country
    where current of cur_selected;
    
    update loc l
    set l.postalcode = cur_record.postalcode
    where current of cur_selected;
    
    update loc l
    set l.u_geocode = cur_record.u_geocode
    where current of cur_selected;
    
    update loc l
    set l.u_city = cur_record.u_city
    where current of cur_selected;
    
  end loop;
  commit;
end;

-- sets loc_type and storablesw

update loc set loc_type = 6;

commit;

update loc set loc_type = 2 where loc in (select distinct loc from productionmethod);

commit;

update loc set loc_type = 3 where loc in (select distinct dest from sourcing where dest in (select loc from loc where loc_type <> 2));

commit;

update sku set storablesw = 1 where loc in (select loc from loc where loc_type = 2 and substr(loc, -2) <> 'AI');

commit;

update sku set storablesw = 0 where loc in (select loc from loc where loc_type = 3) or substr(loc, -2) = 'AI';

commit;

-- sets loc_type from 2 to 0 if there is no way to assign a production method due to absence of dfuview u_defplant

update loc set loc_type = 0 where loc in (

select u.loc   --, d.u_defplant
from

    (select distinct dmdunit, u_defplant from dfuview ) d,

    (select u.loc
    from

        (select distinct from_loc loc
        from tmp_distance d, loc l
        where from_loc = loc
        and l.loc_type = 2) u,

        (select distinct loc from productionmethod) p

    where u.loc = p.loc(+)
    and p.loc is null) u

where u.loc = d.u_defplant(+)
and d.U_defplant is null);

commit;

--deletes loc_type = 3 SKU that have no sku constraint 

delete sku where item||loc in 

(select s.item||s.loc
from sku s, loc l,

    (select distinct item, loc from skuconstraint) k

where s.loc = l.loc
and l.loc_type = 3
and s.item = k.item(+)
and s.loc = k.loc(+)
and k.item is null);

commit;

--create placeholder customer orders for PSO to test forecast adjustment logic

insert into custorder (item, loc, shipdate, status,     orderid,     fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,   margin,     maxlatedur,     
    promiseddate,   revenue,       headerextref,       lineitemextref,       arrivtranszone,  maxearlydur,    lifecyclestatus,       arrivtransmode,     
    arrivleadtime,     promisedqty,     shipcompletesw,     cost,     unitprice,     orderlineitem,    project,   substlevel,     substoperator,     shipsw,     firmsw,     
    cust,   supersedesw,      ff_trigger_control,  priorityseqnum, atpexcludesw,  ordertype,  fcsttype,   workscope,  dmdunit,  dmdgroup,     overridefcsttypesw, orderseqnum)

select c.item, c.loc, shipdate, o.status,     o.orderid,     o.fcstsw,     o.qty,     o.reservation,     o.resexp,     o.priority,     o.calcpriority,   o.margin,     o.maxlatedur,     
    o.promiseddate,   o.revenue,       o.headerextref,       o.lineitemextref,       o.arrivtranszone,  o.maxearlydur,    o.lifecyclestatus,       o.arrivtransmode,     
    o.arrivleadtime,     o.promisedqty,     o.shipcompletesw,     o.cost,     o.unitprice,     o.orderlineitem,    o.project,   o.substlevel,     o.substoperator,     o.shipsw,     o.firmsw,     
    o.cust,   o.supersedesw,      o.ff_trigger_control,  o.priorityseqnum, o.atpexcludesw,  o.ordertype,  o.fcsttype,   o.workscope,  o.dmdunit,  o.dmdgroup,     o.overridefcsttypesw,
    row_number()
                over (partition by o.status order by c.item, c.loc, shipdate ) as orderseqnum
from

    (select distinct item, dest loc
    from sourcing
    where source = 'ES1J'
    and dest not in (select distinct loc from custorder)) c,

    (select item, shipdate, 1 status,     orderid,     1 fcstsw,     qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')
    union
    select item, to_date('05/11/2014', 'MM/DD/YYYY') shipdate, 1 status,     orderid,     1 fcstsw,     qty+12 qty,     0 reservation,     to_date('01/01/1970', 'MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     0 maxlatedur,     
        to_date('01/01/1970', 'MM/DD/YYYY') promiseddate,     -1 revenue,       headerextref,       lineitemextref,       arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,       arrivtransmode,     
        0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,       project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,     
        50309795 orderseqnum,       cust,     0 supersedesw,      ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,   ' '    workscope,     ' '  dmdunit,       ' ' dmdgroup,     1 overridefcsttypesw
    from custorder
    where item||loc in ('00001RUSTD5000437666', '00003RUSTD5000437666', '00008RUSTD5000437693')) o

where c.item = o.item;

commit;

--another custorder insert  .... 

insert into custorder (item, loc, shipdate, dfuloc,    status,    fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,  margin,     
    maxlatedur,  promiseddate,   revenue,   headerextref,   lineitemextref,   arrivtranszone,     maxearlydur,  lifecyclestatus,   arrivtransmode,     
    arrivleadtime,  promisedqty,     shipcompletesw,     cost,  unitprice,   orderlineitem,    project,     substlevel,  substoperator,   shipsw,  firmsw,         
    cust,    supersedesw,   ff_trigger_control,  priorityseqnum,  atpexcludesw,  ordertype,  fcsttype,    workscope,    dmdunit,    dmdgroup,    overridefcsttypesw,     
    u_sales_document,    u_ship_condition,   u_dmdgroup_code, orderseqnum, orderid)

select item, loc, shipdate, ' ' dfuloc,    1 status,    fcstsw,     qty,     0 reservation,     TO_DATE('01/01/1970','MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     
    0 maxlatedur,     TO_DATE('01/01/1970','MM/DD/YYYY') promiseddate,     -1 revenue,     ' ' headerextref,     ' ' lineitemextref,     ' ' arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,     ' ' arrivtransmode,     
    0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,     ' ' project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,         
    ' ' cust,     0 supersedesw,     '' ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,     ' ' workscope,     ' ' dmdunit,     ' ' dmdgroup,     1 overridefcsttypesw,     
    u_sales_document,     u_ship_condition,     u_dmdgroup_code, orderseqnum, orderid
 from 
(select item,  loc, orderid, shipdate, fcstsw,     qty,     
    u_sales_document,    u_ship_condition,    u_dmdgroup_code,  
        row_number()
              over (partition by 1 order by item, loc, shipdate ) as orderseqnum
from tmp_custorder);

commit;

declare
  cursor cur_selected is
    select l.loc, u.country, u.sq_miles, u.radius_miles, u.radius_km 
    from loc l,

        (select distinct l.country, u.sq_miles, sqrt(u.sq_miles/3.1412) radius_miles, round((sqrt(u.sq_miles/3.1412))*1.61, 0) radius_km 
        from skuconstraint k, loc l, 

            (select 32383 sq_miles, 'AT' country from dual union
            select 11787 sq_miles, 'BE' country from dual union
            select 42855 sq_miles, 'BG' country from dual union
            select 15940 sq_miles, 'CH' country from dual union
            select 30450 sq_miles, 'CZ' country from dual union
            select 137849 sq_miles, 'DE' country from dual union
            select 16440 sq_miles, 'DK' country from dual union
            select 17462 sq_miles, 'EE' country from dual union
            select 195363 sq_miles, 'ES' country from dual union
            select 130559 sq_miles, 'FI' country from dual union
            select 210026 sq_miles, 'FR' country from dual union
            select 93638 sq_miles, 'GB' country from dual union
            select 50999 sq_miles, 'GR' country from dual union
            select 300 sq_miles, 'HR' country from dual union
            select 35919 sq_miles, 'HU' country from dual union
            select 17959.5 sq_miles, 'IE' country from dual union
            select 116346 sq_miles, 'IT' country from dual union
            select 35519 sq_miles, 'JE' country from dual union
            select 36419 sq_miles, 'LT' country from dual union
            select 36169 sq_miles, 'LU' country from dual union
            select 16146 sq_miles, 'NL' country from dual union
            select 125000 sq_miles, 'NO' country from dual union
            select 120700 sq_miles, 'PL' country from dual union
            select 35655 sq_miles, 'PT' country from dual union
            select 148129 sq_miles, 'RO' country from dual union
            select 39617 sq_miles, 'RS' country from dual union
            select 43578 sq_miles, 'SE' country from dual union
            select 21789.17 sq_miles, 'SK' country from dual union
            select 300948 sq_miles, 'TR' country from dual  
            ) u

        where k.loc = l.loc
        and l.country = u.country(+)
        ) u

    where u.radius_km > 110
    and u.country = l.country
    for update of l.u_max_dist;
begin
  for cur_record in cur_selected loop
  
    update loc 
    set u_max_dist = cur_record.radius_km
    where current of cur_selected;
    
  end loop;
  commit;
end;

end;

/

