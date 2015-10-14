--------------------------------------------------------
--  DDL for View UDV_SAFETYSTOCK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_SAFETYSTOCK" ("ITEM", "LOC", "SS", "PROJECTION", "OOH_P01", "OOH_P02", "OOH_P03", "OOH_P04", "OOH_P05", "OOH_P06", "OOH_P07", "OOH_P08", "OOH_P09", "OOH_P10", "OOH_P11", "OOH_P12", "OOH_P13", "OOH_P14", "OOH_P15", "OOH_P16", "OOH_P17", "OOH_P18", "OOH_P19", "OOH_P20", "OOH_P21", "OOH_P22", "OOH_P23", "OOH_P24", "OOH_P25", "OOHP_26") AS 
  select item, loc, ss, projection,
    nvl(ooh_p01, 0) ooh_p01,     nvl(ooh_p02, 0) ooh_p02,     nvl(ooh_p03, 0) ooh_p03,     nvl(ooh_p04, 0) ooh_p04,     nvl(ooh_p05, 0) ooh_p05,     nvl(ooh_p06, 0) ooh_p06,     
    nvl(ooh_p07, 0) ooh_p07,     nvl(ooh_p08, 0) ooh_p08,     nvl(ooh_p09, 0) ooh_p09,     nvl(ooh_p10, 0) ooh_p10,     nvl(ooh_p11, 0) ooh_p11,     nvl(ooh_p12, 0) ooh_p12,     
    nvl(ooh_p13, 0) ooh_p13,     nvl(ooh_p14, 0) ooh_p14,     nvl(ooh_p15, 0) ooh_p15,     nvl(ooh_p16, 0) ooh_p16,     nvl(ooh_p17, 0) ooh_p17,     nvl(ooh_p18, 0) ooh_p18,     
    nvl(ooh_p19, 0) ooh_p19,     nvl(ooh_p20, 0) ooh_p20,     nvl(ooh_p21, 0) ooh_p21,     nvl(ooh_p22, 0) ooh_p22,     nvl(ooh_p23, 0) ooh_p23,     nvl(ooh_p24, 0) ooh_p24,     
    nvl(ooh_p25, 0) ooh_p25,     nvl(ooh_p26, 0) oohp_26
from 

    (select u.loc, u.item, u.ss,  'OOH' projection, 
        
        sum(case when u.eff = u_start_date+000 then ooh end) ooh_p01, 
        sum(case when u.eff = u_start_date+007 then ooh end) ooh_p02, 
        sum(case when u.eff = u_start_date+014 then ooh end) ooh_p03, 
        sum(case when u.eff = u_start_date+021 then ooh end) ooh_p04, 
        sum(case when u.eff = u_start_date+028 then ooh end) ooh_p05, 
        sum(case when u.eff = u_start_date+035 then ooh end) ooh_p06, 
        sum(case when u.eff = u_start_date+042 then ooh end) ooh_p07, 
        sum(case when u.eff = u_start_date+049 then ooh end) ooh_p08, 
        sum(case when u.eff = u_start_date+056 then ooh end) ooh_p09, 
        sum(case when u.eff = u_start_date+063 then ooh end) ooh_p10, 
        sum(case when u.eff = u_start_date+070 then ooh end) ooh_p11, 
        sum(case when u.eff = u_start_date+077 then ooh end) ooh_p12, 
        sum(case when u.eff = u_start_date+084 then ooh end) ooh_p13, 
        sum(case when u.eff = u_start_date+091 then ooh end) ooh_p14, 
        sum(case when u.eff = u_start_date+098 then ooh end) ooh_p15, 
        sum(case when u.eff = u_start_date+105 then ooh end) ooh_p16, 
        sum(case when u.eff = u_start_date+112 then ooh end) ooh_p17, 
        sum(case when u.eff = u_start_date+119 then ooh end) ooh_p18, 
        sum(case when u.eff = u_start_date+126 then ooh end) ooh_p19, 
        sum(case when u.eff = u_start_date+133 then ooh end) ooh_p20, 
        sum(case when u.eff = u_start_date+140 then ooh end) ooh_p21, 
        sum(case when u.eff = u_start_date+147 then ooh end) ooh_p22, 
        sum(case when u.eff = u_start_date+154 then ooh end) ooh_p23, 
        sum(case when u.eff = u_start_date+161 then ooh end) ooh_p24, 
        sum(case when u.eff = u_start_date+168 then ooh end) ooh_p25, 
        sum(case when u.eff = u_start_date+175 then ooh end) ooh_p26
        
    from

            (select m.item, m.loc, k.qty ss, m.eff, round(m.value, 1) ooh, 
                case when k.qty = 0 then 0 else round(m.value/k.qty, 1) end percen_ss 
            from udt_skumetric_wk m, loc l, 
            
                (select distinct item, loc, qty
                from skuconstraint 
                where category = 5
                ) k
            
            where m.category = 414
            and m.loc = l.loc
            and l.loc_type in (2, 4, 5)
            --and m.value >= 0 --and m.eff = '11-OCT-15'
            and m.loc = k.loc
            and m.item = k.item --and m.loc = 'US1M'
            ) u

     group by u.loc, u.item, u.ss

    union

    select u.loc, u.item, u.ss,  'PERCEN_SS' projection, 
        
        sum(case when u.eff = u_start_date+000 then percen_ss end) percen_ss_p01, 
        sum(case when u.eff = u_start_date+007 then percen_ss end) percen_ss_p02, 
        sum(case when u.eff = u_start_date+014 then percen_ss end) percen_ss_p03, 
        sum(case when u.eff = u_start_date+021 then percen_ss end) percen_ss_p04, 
        sum(case when u.eff = u_start_date+028 then percen_ss end) percen_ss_p05, 
        sum(case when u.eff = u_start_date+035 then percen_ss end) percen_ss_p06, 
        sum(case when u.eff = u_start_date+042 then percen_ss end) percen_ss_p07, 
        sum(case when u.eff = u_start_date+049 then percen_ss end) percen_ss_p08, 
        sum(case when u.eff = u_start_date+056 then percen_ss end) percen_ss_p09, 
        sum(case when u.eff = u_start_date+063 then percen_ss end) percen_ss_p10, 
        sum(case when u.eff = u_start_date+070 then percen_ss end) percen_ss_p11, 
        sum(case when u.eff = u_start_date+077 then percen_ss end) percen_ss_p12, 
        sum(case when u.eff = u_start_date+084 then percen_ss end) percen_ss_p13, 
        sum(case when u.eff = u_start_date+091 then percen_ss end) percen_ss_p14, 
        sum(case when u.eff = u_start_date+098 then percen_ss end) percen_ss_p15, 
        sum(case when u.eff = u_start_date+105 then percen_ss end) percen_ss_p16, 
        sum(case when u.eff = u_start_date+112 then percen_ss end) percen_ss_p17, 
        sum(case when u.eff = u_start_date+119 then percen_ss end) percen_ss_p18, 
        sum(case when u.eff = u_start_date+126 then percen_ss end) percen_ss_p19, 
        sum(case when u.eff = u_start_date+133 then percen_ss end) percen_ss_p20, 
        sum(case when u.eff = u_start_date+140 then percen_ss end) percen_ss_p21, 
        sum(case when u.eff = u_start_date+147 then percen_ss end) percen_ss_p22, 
        sum(case when u.eff = u_start_date+154 then percen_ss end) percen_ss_p23, 
        sum(case when u.eff = u_start_date+161 then percen_ss end) percen_ss_p24, 
        sum(case when u.eff = u_start_date+168 then percen_ss end) percen_ss_p25, 
        sum(case when u.eff = u_start_date+175 then percen_ss end) percen_ss_p26
        
    from

            (select m.item, m.loc, k.qty ss, m.eff, round(m.value, 1) ooh, 
                case when k.qty = 0 then 0 else round(m.value/k.qty, 1) end percen_ss 
            from udt_skumetric_wk m, loc l, 
            
                (select distinct item, loc, qty
                from skuconstraint 
                where category = 5
                ) k
            
            where m.category = 414
            and m.loc = l.loc
            and l.loc_type in (2, 4, 5)
            --and m.value >= 0 --and m.eff = '11-OCT-15'
            and m.loc = k.loc
            and m.item = k.item --and m.loc = 'US1M'
            ) u

     group by u.loc, u.item, u.ss
     )

order by item, loc, projection
