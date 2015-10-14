--------------------------------------------------------
--  DDL for Procedure U_PRE_OPTIMIZE_TMP1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_PRE_OPTIMIZE_TMP1" as

BEGIN



U_100_CHECK_TABLES;

u_29_prd_resconstraint_wk;

U_100_CHECK_TABLES;

U_30_SRC_DAILY;

U_100_CHECK_TABLES;

U_100_ERROR_STATS;
end;
