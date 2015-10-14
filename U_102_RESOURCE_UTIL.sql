--------------------------------------------------------
--  DDL for Procedure U_102_RESOURCE_UTIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_102_RESOURCE_UTIL" 
as
begin
    execute immediate 'DROP TABLE UDT_RESOURCE_WEEKLY_UTIL CASCADE CONSTRAINTS';
    execute immediate 'DROP TABLE UDT_RESOURCE_UTIL CASCADE CONSTRAINTS';
    execute immediate ' create table    

UDT_RESOURCE_WEEKLY_UTIL    

(        

RES varchar2(101 char) not null enable      

, EFF date not null enable      

, VALUE float(126)       

, QTY float(126)       

, PercentWeeklyUtil float(126)      

, RM_CATEGORY number(*,0)      

, CATEGORY    number(*,0)      

, POLICY      number(*,0)    

);

';
    execute immediate ' 

alter table UDT_RESOURCE_WEEKLY_UTIL add constraint UDT_RESOURCE_WEEKLY_UTIL_pk primary key

(    

res    

,eff

)

enable;';

   insert into UDT_RESOURCE_WEEKLY_UTIL
        ( res, eff, value, rm_category
        )
   select rm.res
      , rm.eff
      , rm.value
      , rm.category
    from resmetric rm
    where rm.category=401
        and rm.res like '%@U%'
    order by rm.res;
 
    commit;
    
    update UDT_RESOURCE_WEEKLY_UTIL udt_resource_weekly_util
    set udt_resource_weekly_util.qty =
        (select rc.qty
        from resconstraint rc
        where rc.eff=udt_resource_weekly_util.eff
            and rc.res= udt_resource_weekly_util.res
            and rc.category=12
        )
      , udt_resource_weekly_util.category =
        (select rc.category
        from resconstraint rc
        where rc.eff=udt_resource_weekly_util.eff
            and rc.res= udt_resource_weekly_util.res
            and rc.category=12
        )
      , udt_resource_weekly_util.policy =
        (select rc.policy
        from resconstraint rc
        where rc.eff=udt_resource_weekly_util.eff
            and rc.res= udt_resource_weekly_util.res
            and rc.category=12
        )
      , udt_resource_weekly_util.percentweeklyutil =
        (select
            case
                when rc.qty is null
                then 0
                else round(udt_resource_weekly_util.value/rc.qty*100,6)
            end
        from resconstraint rc
        where rc.eff=udt_resource_weekly_util.eff
            and rc.res= udt_resource_weekly_util.res
            and rc.category=12
        );
    commit;
    execute immediate ' 

delete from UDT_RESOURCE_WEEKLY_UTIL UDT_RESOURCE_WEEKLY_UTIL where UDT_RESOURCE_WEEKLY_UTIL.category is null;

';
    execute immediate 'create table    

UDT_RESOURCE_UTIL    

(        

RES varchar2(101 char) not null enable      

, AvgUtil float(126)      

, SdevUtil float(126)    

)';
    execute immediate 'alter table UDT_RESOURCE_UTIL add constraint UDT_RESOURCE_UTIL_pk primary key

(    

res

)

enable';
    insert into UDT_RESOURCE_UTIL
        ( res, avgutil, sdevutil
        )
    select t.res
      ,round(avg(t.percentweeklyutil),2)    as avgutil
      ,round(stddev(t.percentweeklyutil),2) as sdevutil
    from UDT_RESOURCE_WEEKLY_UTIL t
    where t.qty > 0
        and not exists
        ( select 1 from udt_resource_util t2 where t2.res=t.res
        )
    group by t.res
    order by t.res asc;
end;
