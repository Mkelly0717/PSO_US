--------------------------------------------------------
--  DDL for Procedure U_8S
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8S" as

begin

scpomgr.u_8s_sourcing;
scpomgr.u_8s_metrics;
scpomgr.u_8s_optmap;
scpomgr.u_8s_dfu;
scpomgr.u_8d_exceptions;

end;
