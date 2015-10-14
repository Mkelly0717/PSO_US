--------------------------------------------------------
--  DDL for Procedure MAK_CREATE_RESIDUAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."MAK_CREATE_RESIDUAL" 
is
    stmt                 varchar2(1000);
    v_res                varchar2;
    v_weeks_percent_util varchar2;
begin
    stmt:='CREATE GLOBAL TEMPORARY table temp(list if columns) ON COMMIT DELETE ROWS';
    execute immediate stmt;
    insert into temp values
        ('res,ratio'
        )
    select rm.res
      , rm.value/rc.qty
    from resmetric rm
      , resconstraint rc
    where rm.category=401
        and rc.category=12
        and rc.res like '%@U%'
        and rm.res like '%@U%'
        and rm.eff=rc.eff
        and rm.res=rc.res
        and rc.qty > 0
    order by rm.res ;
end;
