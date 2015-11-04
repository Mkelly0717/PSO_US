--------------------------------------------------------
--  DDL for Procedure U_POST_OPTIMIZE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_POST_OPTIMIZE" as

BEGIN

u_60_pst_store_fcst_tables;

u_60_pst_store_user_views;

u_60_pst_storemetrics;

--u_65_pst_replenishments;

end;
