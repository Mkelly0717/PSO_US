--------------------------------------------------------
--  DDL for Procedure U_65_PST_REPLENISHMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_65_PST_REPLENISHMENTS" as

begin

--about a minute

execute immediate 'truncate table planarriv';

insert into planarriv (item, dest, source, sourcing,   transmode, firmplansw, needarrivdate,  schedarrivdate,     needshipdate,     
    schedshipdate,     qty,  expdate, shrinkagefactor,   transname,   action,  actiondate, actionallowedsw, actionqty, reviseddate,        
    availtoshipdate, substqty,  ff_trigger_control, headerseqnum,  covdurscheddate,   departuredate,     deliverydate, orderplacedate,  supporderqty,     revisedexpdate,     nonignorableqty, u_admindate, u_z1banum, u_custorderid, u_sales_document, u_ship_condition, seqnum)

select item, dest, source, sourcing,   transmode, 0 firmplansw,     arrivdate needarrivdate,     arrivdate schedarrivdate,     shipdate needshipdate,     
    shipdate schedshipdate,     qty,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      0 shrinkagefactor,     ' ' transname,     
    0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,        
    shipdate availtoshipdate,     0 substqty,      '' ff_trigger_control,     0 headerseqnum,     TO_DATE('01/01/1970','MM/DD/YYYY') covdurscheddate,     
    shipdate departuredate,     arrivdate deliverydate,     TO_DATE('01/01/1970','MM/DD/YYYY') orderplacedate,     0 supporderqty,     
    TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 nonignorableqty,         TO_DATE('01/01/1970','MM/DD/YYYY')  u_admindate, ' ' u_z1banum, ' ' u_custorderid, ' ' u_sales_document, ' ' u_ship_condition,
    row_number()
              over (partition by item, dest order by item, dest ) as seqnum
from 

    (select t.item, t.dest, t.source, t.shipdate, t.arrivdate, t.sourcing, t.transmode, t.res, t.dur, t.qty, t.category, t.descr
    from

        (select t.item, t.dest, t.source, t.eff shipdate, t.eff+(c.minleadtime/1440) arrivdate, t.sourcing, 'TRUCK' transmode, tt.res, t.dur, t.value qty, t.category, m.descr
        from sourcingmetric t, metriccategory m, sourcing c, res r, sourcingrequirement tt
        where t.category = m.category 
        and t.category in (417)
        and t.item = c.item
        and t.dest = c.dest 
        and t.source = c.source
        and t.sourcing = c.sourcing 
        and t.item = tt.item
        and t.dest = tt.dest
        and t.source = tt.source
        and t.sourcing = tt.sourcing
        and r.res = tt.res
        and r.type = 5
        and t.value > 0
        ) t,
            
        (select distinct k.eff, t.item, k.res, t.source, t.dest, t.sourcing, qty mininflow
        from resconstraint k, res r, sourcingrequirement t
        where k.res = r.res
        and r.type = 5
        and r.res = t.res
        and t.sourcing = 'DELIVERY'
        and k.qty > 0 
        ) k
        
    where t.item = k.item(+)
    and t.source = k.source(+)
    and t.dest = k.dest(+)
    and t.arrivdate = k.eff(+)
    and t.res = k.res(+)  
    and k.source is null
    );    

commit;

declare
  cursor cur_selected is
        SELECT c.item, c.loc, p.source, p.schedshipdate, p.schedarrivdate, c.qty, 
            case when m.item is not null then 'MULTIPLE' else c.orderid end orderid
        from custorder c, loc l, planarriv p,
        
            (select distinct c.item, loc, shipdate, sum(qty) co_totqty, count(*) cnt
            from custorder c, item i
            where c.item = i.item
            and i.u_stock = 'C'
            group by c.item, loc, shipdate
            having count(*) > 1
            ) m
        
        where c.loc = l.loc
        and l.loc_type = 3 
        and c.item = p.item
        and c.loc = p.dest
        and c.shipdate = p.schedarrivdate 
        and p.qty > 0 
        and c.item = m.item(+)
        and c.loc = m.loc(+)
        and c.shipdate = m.shipdate(+) 
    for update of p.u_custorderid;
begin
  for cur_record in cur_selected loop
  
    update planarriv
    set u_custorderid = cur_record.orderid
    where current of cur_selected;
    
  end loop;
  commit;
end;

update planarriv set u_admindate = schedshipdate-1;

commit;

--create separate planned arrivals where multiple customer orders exist with same item / GID / ship date

insert into planarriv (item, dest, source, sourcing,   transmode, u_custorderid, firmplansw, needarrivdate,  schedarrivdate,     needshipdate,     
    schedshipdate,     qty,  expdate, shrinkagefactor,   transname,   action,  actiondate, actionallowedsw, actionqty, reviseddate,        
    availtoshipdate, substqty,  ff_trigger_control, headerseqnum,  covdurscheddate,   departuredate,     deliverydate, orderplacedate,  supporderqty,     revisedexpdate,     nonignorableqty, seqnum)

select item, dest, source, sourcing,   transmode, orderid u_custorderid, 0 firmplansw,     schedarrivdate needarrivdate,     schedarrivdate,     schedshipdate needshipdate,     
    schedshipdate,   co_qty qty,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      0 shrinkagefactor,     ' ' transname,     
    0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,        
    schedshipdate availtoshipdate,     0 substqty,      '' ff_trigger_control,     0 headerseqnum,     TO_DATE('01/01/1970','MM/DD/YYYY') covdurscheddate,     
    schedshipdate departuredate,     schedarrivdate deliverydate,     TO_DATE('01/01/1970','MM/DD/YYYY') orderplacedate,     0 supporderqty,     
    TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 nonignorableqty,         
    row_number()
              over (partition by 1 order by item, dest )+(select max(seqnum) from planarriv) as seqnum
from 
              
    (select p.item, p.dest, p.source, p.sourcing, p.transmode, p.schedshipdate, p.schedarrivdate, p.pa_qty, c.co_totqty, c.cnt, co.orderid, p.u_custorderid, co.qty co_qty
    from custorder co,

        (select distinct item, dest, source, sourcing, transmode, schedshipdate, schedarrivdate, u_custorderid, sum(qty) pa_qty, count(*) cnt
        from planarriv
        group by item, dest, source, sourcing, transmode, schedshipdate, schedarrivdate, u_custorderid) p, 

        (select distinct c.item, loc, shipdate, sum(qty) co_totqty, count(*) cnt
        from custorder c, item i
        where c.item = i.item
        and i.u_stock = 'C'
        group by c.item, loc, shipdate
        having count(*) > 1) c

    where p.item = c.item
    and p.dest = c.loc
    and c.shipdate = p.schedarrivdate
    and c.item = co.item
    and c.loc = co.loc 
    and c.shipdate = co.shipdate
    );
    
commit;

delete planarriv where u_custorderid = 'MULTIPLE';

commit;

execute immediate 'truncate table planorder';

insert into planorder (item, loc, scheddate,   qty,  needdate,  firmplansw, recschedrcptsopt,   productionmethod,  startdate,  expdate,  headerseqnum,  action,   actiondate,  actionallowedsw,  actionqty,   reviseddate,     
    substqty,  ff_trigger_control, covdurscheddate, editsw, revisedexpdate,  primaryseqnum,  coprodprimaryitem, coprodordertype, seqnum)

select item, loc, eff scheddate,     qty,     eff needdate,     1 firmplansw,     1 recschedrcptsopt,   productionmethod,     eff startdate,     TO_DATE('01/01/1970','MM/DD/YYYY') expdate,      
    0 headerseqnum,     0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     0 actionallowedsw,     0 actionqty,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,     
    0 substqty,      '' ff_trigger_control,     eff covdurscheddate,     0 editsw,     TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate,     0 primaryseqnum,     ' ' coprodprimaryitem,     0 coprodordertype, 
    row_number()
              over (partition by item, loc order by item, loc ) as seqnum     
from
    (select c.eff, y.outputitem item, c.loc, c.productionmethod, c.category, m.descr, round(c.value*y.yieldqty, 5) qty
    FROM productionmetric c, metriccategory m, productionyield y
    where c.category = m.category
    and c.category = 417
    and c.value > 0 
    and c.item = y.item
    and c.loc =  y.loc
    and c.productionmethod = y.productionmethod
    );
    
commit;

delete schedrcpts where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 3);

commit;

insert into schedrcpts (item, loc, scheddate,  qty,   qtyreceived, lastcompletedstep, pctcomplete, explodesw, actionallowedsw, reviseddate,  expdate,  startdate, action,  actiondate,     
    actionqty, ordernum, seqnum,   ff_trigger_control,  productionmethod,  sourceopt,  revisedexpdate)

select u.item, u.loc,  u.eff scheddate,     u.qty,     0 qtyreceived,     0 lastcompletedstep,     0 pctcomplete,     0 explodesw,     0 actionallowedsw,     TO_DATE('01/01/1970','MM/DD/YYYY') reviseddate,     
    TO_DATE('01/01/1970','MM/DD/YYYY') expdate,     eff startdate,     0 action,     TO_DATE('01/01/1970','MM/DD/YYYY') actiondate,     
    0 actionqty,     0 ordernum,     0 seqnum,  ''    ff_trigger_control,     ' ' productionmethod,     1 sourceopt,     TO_DATE('01/01/1970','MM/DD/YYYY') revisedexpdate
from schedrcpts r,

    (select item, loc, eff, qty
    from skuconstraint
    where category = 10
    ) u
    
where u.item = r.item(+)
and u.loc = r.loc(+)
and u.eff = r.scheddate(+)
and r.item is null
and u.qty > 0;

commit;

/*
delete custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2);

insert into custorder (item, loc, shipdate, dfuloc,    status,    fcstsw,     qty,     reservation,     resexp,     priority,     calcpriority,  margin,     
    maxlatedur,  promiseddate,   revenue,   headerextref,   lineitemextref,   arrivtranszone,     maxearlydur,  lifecyclestatus,   arrivtransmode,     
    arrivleadtime,  promisedqty,     shipcompletesw,     cost,  unitprice,   orderlineitem,    project,     substlevel,  substoperator,   shipsw,  firmsw,         
    cust,    supersedesw,   ff_trigger_control,  priorityseqnum,  atpexcludesw,  ordertype,  fcsttype,    workscope,    dmdunit,    dmdgroup,    overridefcsttypesw,     
    u_sales_document,    u_ship_condition,   u_dmdgroup_code, orderseqnum, orderid)

select u.subord item, u.loc, eff shipdate, ' ' dfuloc,    1 status,    1 fcstsw,     qty,     0 reservation,     TO_DATE('01/01/1970','MM/DD/YYYY') resexp,     1 priority,     0 calcpriority,     -1 margin,     
    0 maxlatedur,     TO_DATE('01/01/1970','MM/DD/YYYY') promiseddate,     -1 revenue,     ' ' headerextref,     ' ' lineitemextref,     ' ' arrivtranszone,     0 maxearlydur,     1 lifecyclestatus,     ' ' arrivtransmode,     
    0 arrivleadtime,     0 promisedqty,     0 shipcompletesw,     0 cost,     0 unitprice,     0 orderlineitem,     ' ' project,     0 substlevel,     0 substoperator,     0 shipsw,     0 firmsw,         
    ' ' cust,     0 supersedesw,     '' ff_trigger_control,     0 priorityseqnum,     1 atpexcludesw,     -115 ordertype,     1 fcsttype,     ' ' workscope,     ' ' dmdunit,     ' ' dmdgroup,     1 overridefcsttypesw,     
    '' u_sales_document,     '' u_ship_condition,     '' u_dmdgroup_code, 
        (row_number()
                over (partition by 1 order by u.subord, u.loc, u.eff ))+10000000 as orderseqnum, 
        row_number()
              over (partition by 1 order by u.subord, u.loc, u.eff ) as orderid  --subord, loc, eff
from sku s,

    (select distinct p.eff, b.subord, p.loc, p.productionmethod, sum(p.value) value, b.drawqty, round(sum(p.value*b.drawqty), 2) qty
    from productionmetric p, metriccategory c, bom b
    where p.category = c.category
    and p.category = 417 
    and p.item = b.item
    and substr(b.subord, -2) = 'AI'
    and p.value > 0
    group by p.eff, b.subord, p.loc, p.productionmethod, b.drawqty
    ) u
    
where s.item = u.subord
and s.loc = u.loc;
    
commit;

*/

update skudemandparam
set fcstadjrule = 2
where item||loc in (select item||loc from custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2));

commit;

update skudemandparam
set custorderdur = 1440*14
where item||loc in (select item||loc from custorder where substr(item, -2) = 'AI' and loc in (select loc from loc where loc_type = 2));

commit;

--load depdmdstatic records to consume A stock at service centers

execute immediate 'truncate table depdmdstatic';

insert into depdmdstatic (item,     loc,   dur,  qty,   firmsw,     bomnum,  parentexpdate,  calcpriority,  scheddate, schedstatus,  schedqty,     
    parentscheddate,  parentseqnum,   supersedesw,  startdate,  parent,  parentordertype,  seqnum,  parentstartdate,   expdate,     earliestneeddate,   parentordernum)

select item,     loc,   dur,  qty,     0 firmsw,     bomnum,     to_date('01/01/1970', 'MM/DD/YYYY') parentexpdate,     0 calcpriority,     eff scheddate,     0 schedstatus,     qty schedqty,     
    eff parentscheddate,     0 parentseqnum,     0 supersedesw,     eff startdate,  parent,     6 parentordertype,     0 seqnum,     eff parentstartdate,     to_date('01/01/1970', 'MM/DD/YYYY')  expdate,     
    eff earliestneeddate,     0 parentordernum
from 

(select distinct eff, dur, item parent, subord item, loc, max(bomnum) bomnum, sum(qty) qty
from

    (select m.eff, m.dur, m.item, b.subord, m.loc, m.productionmethod, b.bomnum, b.drawqty, m.value, round(b.drawqty*m.value, 2) qty 
    from productionmetric m, bom b, productionmethod p, item i
    where m.category = 417
    and m.item = p.item
    and m.loc = p.loc
    and m.productionmethod = p.productionmethod
    and b.item = p.item
    and b.loc = p.loc
    and b.bomnum = p.bomnum
    and b.subord = i.item
    and i.u_stock in ( 'A', 'B') --and b.subord = '3AI' and m.loc = 'ES1J' and trunc(m.eff) = to_date('05/06/2014', 'MM/DD/YYYY')
    and m.value > 0
    )
    
group by eff, subord, loc, item, dur
order by loc, subord, eff, item, dur);

commit;

end;
