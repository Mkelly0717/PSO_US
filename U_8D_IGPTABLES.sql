create or replace
procedure         u_8d_igptables as

begin

execute immediate 'truncate table igpmgr.interr_costtier';

execute immediate 'truncate table igpmgr.interr_sourcing';

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid='INT_JOB'
     and ij.int_tablename='INTUPS_COSTTIER';

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid in ( 'U_30_SRC_DAILY_PART1'
                      ,'U_30_SRC_DAILY_PART2'
                      )
     and ij.int_tablename='INTINS_SOURCING';

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid='INT_JOB'
     and ij.int_tablename='INTUPS_SOURCING';


end;