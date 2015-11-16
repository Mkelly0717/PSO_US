--------------------------------------------------------
--  DDL for Procedure U_99_UPDATE_DATA_FROM_PRD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_99_UPDATE_DATA_FROM_PRD" as

begin
--
--declare
--  cursor cur_selected is
--        select p.loc, p.loc_type, p.u_loctype, p.country, p.u_area, p.u_geocode, p.u_custtype, p.postalcode, p.lon, p.lat,  p.u_max_dist, p.u_max_src  
--        from scpomgr.loc@scpomgr_chpprddb.jdadelivers.com p, loc l
--        where l.loc = p.loc
--        and p.u_area = 'NA'
--    for update of l.lon;
--begin
--  for cur_record in cur_selected loop
--  
--    update loc 
--    set loc_type = cur_record.loc_type
--    where current of cur_selected;
--    
--    update loc 
--    set u_loctype = cur_record.u_loctype
--    where current of cur_selected;
--    
--    update loc 
--    set u_area = cur_record.u_area
--    where current of cur_selected;
--    
--    update loc 
--    set postalcode = cur_record.postalcode
--    where current of cur_selected;
--    
--    update loc 
--    set u_geocode = cur_record.u_geocode
--    where current of cur_selected;
--    
--    update loc 
--    set u_custtype = cur_record.u_custtype  
--    where current of cur_selected;
--    
--    update loc 
--    set country = cur_record.country
--    where current of cur_selected;
--    
--    update loc 
--    set u_max_dist = cur_record.u_max_dist
--    where current of cur_selected;
--    
--    update loc 
--    set u_max_src = cur_record.u_max_src
--    where current of cur_selected;
--    
--  end loop;
--  commit;
--end;

insert into loc (loc, descr, ohpost, frzstart, sourcecal, destcal, type, altplantid, cust, transzone, lat, lon, enablesw, 
ff_trigger_control, loc_type, vendid, companyid, workingcal, seqintexportdur, seqintimportdur, seqintlastexportedtoseq, 
seqintlastimportedfromseq, postalcode, country, currency, wddarea, borrowingpct, hierarchylevel, u_loctype, u_city, u_countrydes,
u_geocode, u_salesdir, u_salesdirdes, u_salesman, u_salesmandes, u_3digitzip, u_state, u_area, u_region, u_parent, u_parent_des, 
u_subaffil, u_grandparent, u_grandparent_des, u_affil, u_custtype, u_cgroup, u_industry, u_mktsector, u_mktsector_des,  
u_max_src, u_max_dist, u_product_speciality, u_plant_network_type, u_sales_sector, u_territory, u_plantgroup, u_closingdate
)

select lp.loc, lp.descr, lp.ohpost, lp.frzstart, lp.sourcecal, lp.destcal, lp.type, lp.altplantid, lp.cust, lp.transzone, 
lp.lat, lp.lon, lp.enablesw, lp.ff_trigger_control, lp.loc_type, lp.vendid, lp.companyid, lp.workingcal, lp.seqintexportdur, 
lp.seqintimportdur, lp.seqintlastexportedtoseq, lp.seqintlastimportedfromseq, lp.postalcode, lp.country, lp.currency, lp.wddarea,
lp.borrowingpct, lp.hierarchylevel, lp.u_loctype, lp.u_city, lp.u_countrydes, lp.u_geocode, lp.u_salesdir, lp.u_salesdirdes, 
lp.u_salesman, lp.u_salesmandes, lp.u_3digitzip, lp.u_state, lp.u_area, lp.u_region, lp.u_parent, lp.u_parent_des, lp.u_subaffil, 
lp.u_grandparent, lp.u_grandparent_des, lp.u_affil, lp.u_custtype, lp.u_cgroup, lp.u_industry, lp.u_mktsector, lp.u_mktsector_des,
lp.u_max_src, lp.u_max_dist, lp.u_product_speciality, lp.u_plant_network_type, lp.u_sales_sector, lp.u_territory, lp.u_plantgroup,
lp.u_closingdate
from scpomgr.loc@scpomgr_chpprddb.jdadelivers.com lp , loc l
where lp.loc = l.loc(+)
and lp.u_area = 'NA'
and l.loc is null;

commit;

insert into dfuview

select vp.*
from scpomgr.dfuview@scpomgr_chpprddb.jdadelivers.com vp, dfuview v, scpomgr.loc@scpomgr_chpprddb.jdadelivers.com l
where vp.u_dfulevel in (0,1) 
and vp.loc = l.loc
and l.u_area = 'NA'
and vp.dmdunit = v.dmdunit(+)
and vp.dmdgroup = v.dmdgroup(+)
and vp.loc = v.loc(+)
and v.dmdunit is null;

commit;

insert into dfu (dmdunit,     dmdgroup,     loc,     histstart,     eff,     disc,     fcsthor,     dmdcal,     dmdpostdate,     modeldate,     statmse,     
maxhist,     totfcstlock,     lockdur,     refitdate,     mask,     mapused,     netfcstmse,     netfcstmsesmconst,     netfcsterror,     negfcstsw,     
model,     publishdate,     numyears,     seasonerrorlag,     seoutlieropt,     seoutlierfactor,     pickbestsw,     pickbestdate,     symmetricmape,     
runcalcmodelsw,     staticcfdescr,     staticcfvalue,     copyfromdmdunit,     copyfromdmdgroup,     copyfromloc,     copyfrommodel,     copydate,     
newdfusw,     msehistdur,     outlieropt,     storefittedhistopt,     obsoleteflag,     dcrank,     npiinddate,     npimeansmooth,     npitrendsmooth,     
npiscalingfactor,     npisw,     npifromdmdpostdate,     adjdmdpostdate,     npifrommse,     hwmodelsw,     inite3error,     e3error,     seasonprofile,     
include_in_slccurve,     inite3errordate,     e3errordate,     dfuattribgroup)

select dp.dmdunit,     dp.dmdgroup,     dp.loc,     dp.histstart,     dp.eff,     dp.disc,     dp.fcsthor,     dp.dmdcal,     dp.dmdpostdate,     dp.modeldate,     dp.statmse,     
dp.maxhist,     dp.totfcstlock,     dp.lockdur,     dp.refitdate,     dp.mask,     dp.mapused,     dp.netfcstmse,     dp.netfcstmsesmconst,     dp.netfcsterror,     dp.negfcstsw,     
dp.model,     dp.publishdate,     dp.numyears,     dp.seasonerrorlag,     dp.seoutlieropt,     dp.seoutlierfactor,     dp.pickbestsw,     dp.pickbestdate,     dp.symmetricmape,     
dp.runcalcmodelsw,     dp.staticcfdescr,     dp.staticcfvalue,     dp.copyfromdmdunit,     dp.copyfromdmdgroup,     dp.copyfromloc,     dp.copyfrommodel,     dp.copydate,     
dp.newdfusw,     dp.msehistdur,     dp.outlieropt,     dp.storefittedhistopt,     dp.obsoleteflag,     dp.dcrank,     dp.npiinddate,     dp.npimeansmooth,     dp.npitrendsmooth,     
dp.npiscalingfactor,     dp.npisw,     dp.npifromdmdpostdate,     dp.adjdmdpostdate,     dp.npifrommse,     dp.hwmodelsw,     dp.inite3error,     dp.e3error,     dp.seasonprofile,     
dp.include_in_slccurve,     dp.inite3errordate,     dp.e3errordate,     dp.dfuattribgroup
from dfuview vp, scpomgr.dfu@scpomgr_chpprddb.jdadelivers.com dp, dfu d, loc l
where vp.u_dfulevel in (0,1)    
and vp.dmdunit = dp.dmdunit
and vp.dmdgroup = dp.dmdgroup
and vp.loc = dp.loc
and vp.loc = l.loc
and l.u_area = 'NA'
and vp.dmdunit = d.dmdunit(+)
and vp.dmdgroup = d.dmdgroup(+)
and vp.loc = d.loc(+)
and d.dmdunit is null;

commit;

delete fcst where loc in 
    (select loc from loc where u_area = 'NA'
    );
    
commit;

--need to create functions to replace hard-coded fcst dates

insert into fcst

select f.*
from scpomgr.fcst@scpomgr_chpprddb.jdadelivers.com f, SCPOMGR.dfuview@SCPOMGR_CHPPRDDB.JDADELIVERS.COM v, loc l
where v.u_dfulevel in (0,1)
and f.loc = l.loc
and l.u_area = 'NA'
--and f.startdate between v_demand_start_date and v_demand_end_date
and f.startdate between to_date('11/08/2015', 'MM/DD/YYYY') and to_date('05/01/2016', 'MM/DD/YYYY')     
and f.dmdunit = v.dmdunit
and f.dmdgroup = v.dmdgroup
and f.loc = v.loc;

commit;

end;
