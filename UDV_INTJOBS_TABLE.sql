--------------------------------------------------------
--  File created - Thursday-September-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View UDV_INTJOBS_TABLE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SCPOMGR"."UDV_INTJOBS_TABLE" ("JOBID", "INT_TABLENAME", "TABLENAME", "INSERTCT", "UPDATECT", "TOTALROWSCT", "LASTEXEC", "ERRORCODE", "ERRORTEXT") AS 
  select "JOBID","INT_TABLENAME","TABLENAME","INSERTCT","UPDATECT","TOTALROWSCT","LASTEXEC","ERRORCODE","ERRORTEXT"
from igpmgr.intjobs
where int_tablename like '%BOM%' 
   or int_tablename like '%CAL%'
   or int_tablename like '%COST%'
   or int_tablename like '%CUST%'
   or int_tablename like '%DFU%'
   or int_tablename like '%HIST%'
   or int_tablename like '%INV%'
   or int_tablename like '%ITEM%'
   or int_tablename like '%LOC%'
   or int_tablename like '%PLAN%'
   or int_tablename like '%PROD%'
   or int_tablename like '%PURCH%'
   or int_tablename like '%RES%'   
   or int_tablename like '%SKU%'
   or int_tablename like '%SOURCING%'
   or int_tablename like '%UDT%'
order by lastexec desc;
