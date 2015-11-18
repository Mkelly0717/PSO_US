--------------------------------------------------------
--  DDL for Table UDT_INTJOBS_HISTORY
--------------------------------------------------------

  CREATE TABLE "SCPOMGR"."UDT_INTJOBS_HISTORY" 
   (	"JOBID" VARCHAR2(32 CHAR), 
	"INT_TABLENAME" VARCHAR2(30 CHAR), 
	"TABLENAME" VARCHAR2(30 CHAR), 
	"INSERTCT" NUMBER(*,0), 
	"UPDATECT" NUMBER(*,0), 
	"TOTALROWSCT" NUMBER(*,0), 
	"LASTEXEC" VARCHAR2(17), 
	"ERRORCODE" VARCHAR2(9 CHAR)
   )
