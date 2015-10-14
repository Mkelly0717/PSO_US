--------------------------------------------------------
--  DDL for Procedure U_TMP_DELETE_RES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_TMP_DELETE_RES" 
AS

begin
      
loop
    DELETE FROM SCPOMGR.RES WHERE ROWNUM < 25000
    and res <> ' ' ;
    exit when sql%rowcount < 24999;
    commit;
end loop;

COMMIT;

END;
