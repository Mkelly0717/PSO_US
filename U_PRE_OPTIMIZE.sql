--------------------------------------------------------
--  DDL for Procedure U_PRE_OPTIMIZE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_PRE_OPTIMIZE" as

BEGIN
update loc l
set l.loc_type = (
    case l.u_plant_network_type
        when 'STORAGE'         then 5
        when 'DTPM - WM'       then 4
        when 'DTPM - NON-WM'   then 4
        when 'ETPM'            then 2
        when 'SC'              then 2
        when 'OTHER'           then 6
        when 'AUTOMOTIVE'      then 6
        else 6
    end  ) 
where length(loc)=4 and u_plant_network_type is not null
and u_area='NA' and country='US' and loc_type not in (1,6);


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
