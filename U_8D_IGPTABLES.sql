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
commit;

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid in ( 'INT_JOB'
                      ,'U_30_SRC_DAILY_PART1'
                      ,'U_30_SRC_DAILY_PART2'
                      ,'U_30_SRC_DAILY_PART2B'
                      ,'U_30_SRC_DAILY_PART3'
                      ,'U_30_SRC_DAILY_PART4'
                      ,'U_30_SRC_DAILY_PART5'
                      ,'U_30_SRC_DAILY_PART6'
                      ,'U_30_SRC_DAILY_PART7'
                      ,'U_30_SRC_DAILY_PART8'
                      ,'U_30_SRC_DAILY_PART9'
                      ,'U_30_SRC_DAILY_PART10'
                      ,'U_30_SRC_DAILY_PART11'
                      ,'U_30_SRC_DAILY_PART12'
                      ,'U_30_SRC_DAILY_PART13'
                      ,'U_30_SRC_DAILY_PART14'
                      ,'U_30_SRC_DAILY_PART15'
                      ,'U_30_SRC_DAILY_PART16'
                      ,'U_30_SRC_DAILY_PART17'
                      )
     and ij.int_tablename='INTINS_SOURCING';
commit;

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid in ( 'INT_JOB'
                      ,'U_30_SRC_DAILY_PART1'
                      ,'U_30_SRC_DAILY_PART2'
                      ,'U_30_SRC_DAILY_PART2B'
                      ,'U_30_SRC_DAILY_PART3'
                      ,'U_30_SRC_DAILY_PART4'
                      ,'U_30_SRC_DAILY_PART5'
                      ,'U_30_SRC_DAILY_PART6'
                      ,'U_30_SRC_DAILY_PART7'
                      ,'U_30_SRC_DAILY_PART8'
                      ,'U_30_SRC_DAILY_PART9'
                      ,'U_30_SRC_DAILY_PART10'
                      ,'U_30_SRC_DAILY_PART11'
                      ,'U_30_SRC_DAILY_PART12'
                      ,'U_30_SRC_DAILY_PART13'
                      ,'U_30_SRC_DAILY_PART14'
                      ,'U_30_SRC_DAILY_PART15'
                      ,'U_30_SRC_DAILY_PART16'
                      ,'U_30_SRC_DAILY_PART17'
                      )
     and ij.int_tablename='INTUPS_SOURCING';
commit;


end;