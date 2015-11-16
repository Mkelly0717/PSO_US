--------------------------------------------------------
--  DDL for View U_01_PSOVALIDATEDATA_SRE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_01_PSOVALIDATEDATA_SRE" ("NODE_CONFIG_NAME", "SERVICE_NAME", "PROP_NAME", "PROP_VALUE", "COMMENTS") AS 
  select "NODE_CONFIG_NAME","SERVICE_NAME","PROP_NAME","PROP_VALUE","COMMENTS"
from wwfmgr.SRE_NODE_CONFIG_PROPS 
where prop_name = 'Strategy.validateData'
