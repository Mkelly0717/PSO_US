--------------------------------------------------------
--  DDL for View U_00_OBJECTIVE2
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_OBJECTIVE2" ("ELEMENT", "COST") AS 
  SELECT 'Objective' element, SUM (cost) cost FROM u_00_objective1
