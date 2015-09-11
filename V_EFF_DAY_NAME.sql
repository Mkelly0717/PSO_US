--------------------------------------------------------
--  DDL for Function V_EFF_DAY_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SCPOMGR"."V_EFF_DAY_NAME" ( v_eff integer , v_format varchar2 ) RETURN varchar2 IS
dayname varchar2(9);
BEGIN
dayname:=rtrim (to_char (  to_date ('19700101', 'YYYYMMDD'
                          )
                 + (  v_eff/ 1440),v_format
			   ) 
	  );
   RETURN dayname;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END v_eff_day_name;

/

