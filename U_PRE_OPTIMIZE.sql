--------------------------------------------------------
--  DDL for Procedure U_PRE_OPTIMIZE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_PRE_OPTIMIZE" as

BEGIN

u_8d;


U_10_SKU_BASE;


U_11_SKU_STORAGE;


u_15_sku_weekly;


u_20_prd_buy;


u_22_prd_inspect;


U_23_PRD_REPAIR;


U_25_PRD_HEAT;


u_29_prd_resconstraint_wk;


U_30_SRC_DAILY;

U_11_SKU_STORAGE;

u_35_tpm_corrections;

U_100_ERROR_STATS;
end;
