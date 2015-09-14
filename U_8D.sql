--------------------------------------------------------
--  DDL for Procedure U_8D
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D" as

begin

u_8d_exceptions;

u_8d_igptables;

u_8d_sourcing;

u_8d_productionmethod;

u_8d_sku;

end;