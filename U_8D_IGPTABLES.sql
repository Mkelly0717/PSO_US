--------------------------------------------------------
--  DDL for Procedure U_8D_IGPTABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_IGPTABLES" as

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
   where ij.jobid='INT_JOB'
     and ij.int_tablename='INTINS_SOURCING';

update igpmgr.intjobs ij
   set insertct=0,
       updatect=0,
       totalrowsct=0
   where ij.jobid='INT_JOB'
     and ij.int_tablename='INTUPS_SOURCING';


end;

/

