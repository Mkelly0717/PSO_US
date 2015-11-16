--------------------------------------------------------
--  DDL for View U_61_OPTEXCEPTION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_61_OPTEXCEPTION" ("SEVERITYLEVEL", "EXCEPTIONID", "MESSAGE", "CNT") AS 
  SELECT DISTINCT severitylevel,
                     exceptionid,
                     MESSAGE,
                     COUNT (*) cnt
       FROM u_60_optexception
   GROUP BY severitylevel, exceptionid, MESSAGE
