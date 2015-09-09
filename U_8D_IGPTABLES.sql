create or replace
procedure         u_8d_igptables as

begin

execute immediate 'truncate table igpmgr.interr_bom';

execute immediate 'truncate table igpmgr.interr_cal';

execute immediate 'truncate table igpmgr.interr_caldata';

execute immediate 'truncate table igpmgr.interr_cost';

execute immediate 'truncate table igpmgr.interr_costtier';

execute immediate 'truncate table igpmgr.interr_prodmethod';

execute immediate 'truncate table igpmgr.interr_productionstep';

execute immediate 'truncate table igpmgr.interr_res';

execute immediate 'truncate table igpmgr.interr_rescost';

execute immediate 'truncate table igpmgr.interr_sku';

execute immediate 'truncate table igpmgr.interr_skudemandparam';

execute immediate 'truncate table igpmgr.interr_skudeployparam';

execute immediate 'truncate table igpmgr.interr_skussparam';

execute immediate 'truncate table igpmgr.interr_skuplannparam';

execute immediate 'truncate table igpmgr.interr_sourcing';

/* reset BOM Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_BOM','INTUPS_BOM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Cal Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_CAL','INTUPS_CAL')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Caldata Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_CALDATA','INTUPS_CALDATA')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Cost Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_COST','INTUPS_COST')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Costier Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_COSTTIER','INTUPS_COSTTIER')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;


/* reset DFUTOSKUFCST Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_DFUTOSKUFCST','INTUPS_DFUTOSKUFCST')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;
/* reset SKU Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKU','INTUPSKU')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset PRODMETHOD Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_PRODMETHOD','INTUPS_PRODMETHOD')
     and ( ij.jobid = 'INT_JOB'
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset PRODSTEP Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_PRODUCTIONSTEP','INTUPS_PRODUCTIONSTEP')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset RES Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_RES','INTUPS_RES')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset RESCOST Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_RESCOST','INTUPS_RESCOST')
     and ( ij.jobid = 'INT_JOB'
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset SKU Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKU','INTUPS_SKU')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Demand Param Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUDEMANDPARAM','INTUPS_SKUDEMANDPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Deployment Param Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUDEPLOYPARAM','INTUPS_SKUDEPLOYPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU PLanning Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUPLANNPARAM','INTUPSKU_SKUPLANPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset SKU Saftey Stock Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SKUSSPARAM','INTUPSKU_SKUSSPARAM')
      and (    ij.jobid='INT_JOB' 
            or ij.jobid like 'U_10_SKU_BASE_%'
            or ij.jobid like 'U_30_SRC_DAILY_%'
            or ij.jobid like 'U_23_PRD_REPAIR_%'
           ); 
commit;

/* reset Sourcing Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_SOURCING','INTUPS_SOURCING')
     and ( ij.jobid = 'INT_JOB' 
           or ij.jobid like 'U_10_SKU_BASE_%'
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

end;