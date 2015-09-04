create or replace
procedure         u_8d_igptables as

begin

execute immediate 'truncate table igpmgr.interr_bom';

execute immediate 'truncate table igpmgr.interr_cost';

execute immediate 'truncate table igpmgr.interr_costtier';

execute immediate 'truncate table igpmgr.interr_prodmethod';

execute immediate 'truncate table igpmgr.interr_productionstep';

execute immediate 'truncate table igpmgr.interr_res';

execute immediate 'truncate table igpmgr.interr_rescost';

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

/* reset Cost Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_COST','INTUPS_COST')
      and (    ij.jobid='INT_JOB' 
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
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

/* reset RECOST Records */
update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.int_tablename in ('INTINS_RESCOST','INTUPS_RESCOST')
     and ( ij.jobid = 'INT_JOB' 
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
           or ij.jobid like 'U_30_SRC_DAILY_%'
           or ij.jobid like 'U_23_PRD_REPAIR_%'
          );
commit;

end;