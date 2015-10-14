--------------------------------------------------------
--  DDL for Procedure U_100_CHECK_TABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_100_CHECK_TABLES" 
is 
   v_bom number;
   V_CAL NUMBER;
   v_caldata number;
   v_cost number;
   v_costtier number;
   v_prodmethod number;
   v_productionstep number;
   v_prodyield number;
   v_res number;
   v_resconstraint number;
   v_rescost number;
   V_RESPENALTY NUMBER;
   v_sku number;
   v_skudemandparam number;
   v_skudeployparam number;
   v_skupenalty number;
   v_skuplannparam number;
   v_skussparam number;
   v_sourcing number;
   v_sourcingmetric number;
   v_storagereq number;
   v_date date := sysdate;
begin
  select count(1) into v_bom from  bom;
  select count(1) into v_cal from  cal;
  select count(1) into v_caldata from  caldata;
  select count(1) into  v_cost from  cost;
  SELECT COUNT(1) INTO  V_COSTTIER FROM  COSTTIER;
--  SELECT COUNT(1) INTO  V_PRODMETHOD FROM  PRODMETHOD;
--  select count(1) into  v_productionstep  from productionstep;
--  select count(1) into  v_prodyield from prodyield;
  select count(1) into  v_res from res;
  SELECT COUNT(1) INTO  V_RESCONSTRAINT FROM  RESCONSTRAINT;
  select count(1) into  v_rescost from  rescost;
  select count(1) into  v_respenalty from  respenalty;
  select count(1) into  v_sku from  sku;
--  select count(1) into  v_skudemandparam from  skudemandparam;
--  select count(1) into  v_skudeployparam from  skudeployparam;
--  select count(1) into  v_skussparam from  skussparam;
--  select count(1) into  v_skuplannparam from  skuplannparam;
--  select count(1) into  v_skupenalty from skupenalty;
  select count(1) into  v_sourcing from  sourcing;
  SELECT COUNT(1) INTO  V_SOURCINGMETRIC FROM  SOURCINGMETRIC;
  select count(1) into  v_storagereq from  storagerequirement;
   
   insert into UDT_CHECK_TABLES 
   (run_date
   ,bom
   ,CAL
   ,caldata
   ,cost
   ,COSTTIER
--   ,prodmethod
--   ,productionstep
--   ,prodyield
   ,res
   ,resconstraint
   ,rescost
   ,respenalty
   ,sku
--   ,skudemandparam
--   ,skudeployparam
--   ,skupenalty
--   ,skuplannparam
--   ,skussparam
   ,sourcing
   ,sourcingmetric
   ,storagereq
   )
   values ( v_date
   ,v_bom 
   ,v_cal
   ,v_caldata
   ,v_cost
   ,V_COSTTIER
--   ,V_PRODMETHOD
--   ,v_productionstep
--   ,V_PRODYIELD
   ,v_res
   ,v_resconstraint
   ,v_rescost
   ,v_respenalty
   ,v_sku
--   ,v_skudemandparam
--   ,v_skudeployparam
--   ,v_skupenalty
--   ,v_skuplannparam
--   ,v_skussparam
   ,v_sourcing
   ,v_sourcingmetric
   ,v_storagereq
   );
end;
