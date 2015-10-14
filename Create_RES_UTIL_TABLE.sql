set echo off;
set feedback off
set verify off
set trimspool on
set heading off
set showmode = off;
/
define table_name = 'UDT_RESOURCE_WEEKLY_UTIL';
define table_name_pk = 'UDT_RESOURCE_WEEKLY_UTIL_PK';
define table2_name = 'UDT_RESOURCE_UTIL';
define table2_name_pk = 'UDT_RESOURCE_UTIL_PK';

begin
    execute immediate 'DROP TABLE &table_name CASCADE CONSTRAINTS';
    execute immediate 'DROP TABLE &table2_name CASCADE CONSTRAINTS';
exception
when others then
    if sqlcode != -942 then
        raise;
    end if;
end;
/
--------------------------------------------------------
--  Create new Table MAK_T30_part1
--------------------------------------------------------
create table
    &table_name
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
/
alter table &table_name add constraint &table_name_pk primary key
(
    res
    ,eff
)
enable;
/
insert into &table_name
    ( res, eff, value, rm_category )
select rm.res
  , rm.eff
  , rm.value
  , rm.category
from resmetric rm
where rm.category=401
  and rm.res like '%@U%'
order by rm.res;
/

commit;

update UDT_RESOURCE_WEEKLY_UTIL UDT_RESOURCE_WEEKLY_UTIL
set UDT_RESOURCE_WEEKLY_UTIL.qty = 
   ( select rc.qty
        from resconstraint rc
        where rc.eff=UDT_RESOURCE_WEEKLY_UTIL.eff
          and rc.res= UDT_RESOURCE_WEEKLY_UTIL.res
          and rc.category=12
     ),
    UDT_RESOURCE_WEEKLY_UTIL.category = 
   ( select rc.category
        from resconstraint rc
        where rc.eff=UDT_RESOURCE_WEEKLY_UTIL.eff
          and rc.res= UDT_RESOURCE_WEEKLY_UTIL.res
          and rc.category=12
    ),
    UDT_RESOURCE_WEEKLY_UTIL.policy = 
    ( select rc.policy
        from resconstraint rc
        where rc.eff=UDT_RESOURCE_WEEKLY_UTIL.eff
          and rc.res= UDT_RESOURCE_WEEKLY_UTIL.res
          and rc.category=12
     ),
    UDT_RESOURCE_WEEKLY_UTIL.PercentWeeklyUtil =
       ( select case 
                     when rc.qty is null then 0
                     else round(UDT_RESOURCE_WEEKLY_UTIL.value/rc.qty*100,6)
                end
        from resconstraint rc
        where rc.eff=UDT_RESOURCE_WEEKLY_UTIL.eff
          and rc.res= UDT_RESOURCE_WEEKLY_UTIL.res
          and rc.category=12
     );
/
     
commit;

delete from UDT_RESOURCE_WEEKLY_UTIL UDT_RESOURCE_WEEKLY_UTIL where UDT_RESOURCE_WEEKLY_UTIL.category is null;
/


create table
    &table2_name
    (
        RES varchar2(101 char) not null enable
      , AvgUtil float(126)
      , SdevUtil float(126)
    );
/
alter table &table2_name add constraint &table2_name_pk primary key
(
    res
)
enable;


insert into &table2_name
    ( res, AvgUtil, SdevUtil )
select t.res
      ,round(avg(t.PercentWeeklyUtil),2) as AvgUtil
      ,round(stddev(t.PercentWeeklyUtil),2) as SdevUtil
from UDT_RESOURCE_WEEKLY_UTIL t
where t.qty > 0
  and not exists ( select 1 from UDT_RESOURCE_UTIL t2 where t2.res=t.res)
group by t.res
order by t.res asc;
/
