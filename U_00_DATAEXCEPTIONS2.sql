--------------------------------------------------------
--  DDL for View U_00_DATAEXCEPTIONS2
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_DATAEXCEPTIONS2" ("ELEMENT", "CNT") AS 
  SELECT DISTINCT element, COUNT (*) cnt
       FROM u_00_dataexceptions
   GROUP BY element
