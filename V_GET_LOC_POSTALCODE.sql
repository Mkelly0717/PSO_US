--------------------------------------------------------
--  DDL for Function V_GET_LOC_POSTALCODE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SCPOMGR"."V_GET_LOC_POSTALCODE" (
            in_loc varchar2 )
        return varchar2
    is
        v_postalcode varchar2(10);
    begin
        select l.postalcode into v_postalcode from loc l where l.loc = in_loc;
        return v_postalcode;
    exception
    when no_data_found then
        return 'INVALID CODE';
    when others then
        -- Consider logging the error and then re-raise
        raise;
    end v_get_loc_postalcode;
