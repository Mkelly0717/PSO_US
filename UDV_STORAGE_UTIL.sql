--------------------------------------------------------
--  DDL for View UDV_STORAGE_UTIL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_STORAGE_UTIL" ("LOC", "RES", "MAXCAP", "PROJECTION", "OOH0927", "OOH1004", "OOH1011", "OOH1018", "OOH1025", "OOH1101", "OOH1108", "OOH1115", "OOH1122", "OOH1129", "OOH1206", "OOH1213", "OOH1220", "OOH1227", "OOH0103", "OOH0110", "OOH0117", "OOH0124", "OOH0131", "OOH0207", "OOH0214", "OOH0221", "OOH0228", "OOH0306", "OOH0313", "OOH0320") AS 
  select loc, res, maxcap,  projection,
    nvl(oohp01, 0) oohp01,     nvl(oohp02, 0) oohp02,     nvl(oohp03, 0) oohp03,     nvl(oohp04, 0) oohp04,     nvl(oohp05, 0) oohp05,     nvl(oohp06, 0) oohp06,     
    nvl(oohp07, 0) oohp07,     nvl(oohp08, 0) oohp08,     nvl(oohp09, 0) oohp09,     nvl(oohp10, 0) oohp10,     nvl(oohp11, 0) oohp11,     nvl(oohp12, 0) oohp12,     
    nvl(oohp13, 0) oohp13,     nvl(oohp14, 0) oohp14,     nvl(oohp15, 0) oohp15,     nvl(oohp16, 0) oohp16,     nvl(oohp17, 0) oohp17,     nvl(oohp18, 0) oohp18,     
    nvl(oohp19, 0) oohp19,     nvl(oohp20, 0) oohp20,     nvl(oohp21, 0) oohp21,     nvl(oohp22, 0) oohp22,     nvl(oohp23, 0) oohp23,     nvl(oohp24, 0) oohp24,     
    nvl(oohp25, 0) oohp25,     nvl(oohp26, 0) oohp26
from

    (select u.loc, u.res, u.maxcap,  'OOH' projection,

        sum(case when u.eff = u_start_date+000 then ooh end) oohp01, 
        sum(case when u.eff = u_start_date+007 then ooh end) oohp02, 
        sum(case when u.eff = u_start_date+014 then ooh end) oohp03, 
        sum(case when u.eff = u_start_date+021 then ooh end) oohp04, 
        sum(case when u.eff = u_start_date+028 then ooh end) oohp05, 
        sum(case when u.eff = u_start_date+035 then ooh end) oohp06, 
        sum(case when u.eff = u_start_date+042 then ooh end) oohp07, 
        sum(case when u.eff = u_start_date+049 then ooh end) oohp08, 
        sum(case when u.eff = u_start_date+056 then ooh end) oohp09, 
        sum(case when u.eff = u_start_date+063 then ooh end) oohp10, 
        sum(case when u.eff = u_start_date+070 then ooh end) oohp11, 
        sum(case when u.eff = u_start_date+077 then ooh end) oohp12, 
        sum(case when u.eff = u_start_date+084 then ooh end) oohp13, 
        sum(case when u.eff = u_start_date+091 then ooh end) oohp14, 
        sum(case when u.eff = u_start_date+098 then ooh end) oohp15, 
        sum(case when u.eff = u_start_date+105 then ooh end) oohp16, 
        sum(case when u.eff = u_start_date+112 then ooh end) oohp17, 
        sum(case when u.eff = u_start_date+119 then ooh end) oohp18, 
        sum(case when u.eff = u_start_date+126 then ooh end) oohp19, 
        sum(case when u.eff = u_start_date+133 then ooh end) oohp20, 
        sum(case when u.eff = u_start_date+140 then ooh end) oohp21, 
        sum(case when u.eff = u_start_date+147 then ooh end) oohp22, 
        sum(case when u.eff = u_start_date+154 then ooh end) oohp23, 
        sum(case when u.eff = u_start_date+161 then ooh end) oohp24, 
        sum(case when u.eff = u_start_date+168 then ooh end) oohp25, 
        sum(case when u.eff = u_start_date+175 then ooh end) oohp26
        
    from

        (select u.loc, u.eff, u.res, sum(ooh) ooh, c.maxcap, 
            case when c.maxcap = 0 then 0 else round(sum(ooh)/c.maxcap, 3) end util
        from tmp_storage_capacity c,

            (select m.item, m.loc, t.res, m.eff, round(m.value, 1) ooh 
            from udt_skumetric_wk m, loc l, storagerequirement t
            where m.category = 414
            and m.loc = l.loc
            and l.loc_type in (2, 4, 5)
            and m.value >= 0 --and m.eff = '11-OCT-15'
            and m.loc = t.loc
            and m.item = t.item --and m.loc = 'US1M'
            ) u

        where u.loc = c.loc
        group by u.loc, u.eff, u.res, c.maxcap
        ) u

    group by u.loc, u.res, u.maxcap

    union

    select u.loc, u.res, u.maxcap,  'UTIL' projection, 
        
        sum(case when u.eff = u_start_date+000 then util end) utilp01, 
        sum(case when u.eff = u_start_date+007 then util end) utilp02, 
        sum(case when u.eff = u_start_date+014 then util end) utilp03, 
        sum(case when u.eff = u_start_date+021 then util end) utilp04, 
        sum(case when u.eff = u_start_date+028 then util end) utilp05, 
        sum(case when u.eff = u_start_date+035 then util end) utilp06, 
        sum(case when u.eff = u_start_date+042 then util end) utilp07, 
        sum(case when u.eff = u_start_date+049 then util end) utilp08, 
        sum(case when u.eff = u_start_date+056 then util end) utilp09, 
        sum(case when u.eff = u_start_date+063 then util end) utilp10, 
        sum(case when u.eff = u_start_date+070 then util end) utilp11, 
        sum(case when u.eff = u_start_date+077 then util end) utilp12, 
        sum(case when u.eff = u_start_date+084 then util end) utilp13, 
        sum(case when u.eff = u_start_date+091 then util end) utilp14, 
        sum(case when u.eff = u_start_date+098 then util end) utilp15, 
        sum(case when u.eff = u_start_date+105 then util end) utilp16, 
        sum(case when u.eff = u_start_date+112 then util end) utilp17, 
        sum(case when u.eff = u_start_date+119 then util end) utilp18, 
        sum(case when u.eff = u_start_date+126 then util end) utilp19, 
        sum(case when u.eff = u_start_date+133 then util end) utilp20, 
        sum(case when u.eff = u_start_date+140 then util end) utilp21, 
        sum(case when u.eff = u_start_date+147 then util end) utilp22, 
        sum(case when u.eff = u_start_date+154 then util end) utilp23, 
        sum(case when u.eff = u_start_date+161 then util end) utilp24, 
        sum(case when u.eff = u_start_date+168 then util end) utilp25, 
        sum(case when u.eff = u_start_date+175 then util end) utilp26
        
    from

        (select u.loc, u.eff, u.res, sum(ooh) ooh, c.maxcap, 
            case when c.maxcap = 0 then 0 else round(sum(ooh)/c.maxcap, 3) end util
        from tmp_storage_capacity c,

            (select m.item, m.loc, t.res, m.eff, round(m.value, 1) ooh 
            from udt_skumetric_wk m, loc l, storagerequirement t
            where m.category = 414
            and m.loc = l.loc
            and l.loc_type in (2, 4, 5)
            and m.value >= 0 --and m.eff = '11-OCT-15'
            and m.loc = t.loc
            and m.item = t.item --and m.loc = 'US1M'
            ) u

        where u.loc = c.loc
        group by u.loc, u.eff, u.res, c.maxcap
        ) u

    group by u.loc, u.res, u.maxcap
    )

order by loc, projection
