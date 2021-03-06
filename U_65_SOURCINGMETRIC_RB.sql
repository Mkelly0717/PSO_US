--------------------------------------------------------
--  DDL for View U_65_SOURCINGMETRIC_RB
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_65_SOURCINGMETRIC_RB" ("ITEM", "DEST", "SOURCE", "LOC_TYPE", "SOURCING", "CATEGORY", "DESCR", "TOTAL", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26") AS 
  select distinct item, dest, source, loc_type, sourcing, category, descr,
    (p1+    p2+    p3+    p4+    p5+    p6+    p7+    p8+    p9+    p10+    p11+    p12+    p13+    p14+    p15+    p16+    p17+    p18+    p19+    p20+    p21+    p22+    p23+    p24+    p25+    p26) total, 
    p1,    p2,    p3,    p4,    p5,    p6,    p7,    p8,    p9,    p10,    p11,    p12,    p13,    p14,    p15,    p16,    p17,    p18,    p19,    p20,    p21,    p22,    p23,    p24,    p25,    p26
    
from

    (select distinct c.item, c.dest, c.source, l.loc_type, c.sourcing, c.category, m.descr,
    nvl (sum (case when eff = s.ohpost + 0 then round(value, 2) end), 0) p1,
    nvl (sum (case when eff = s.ohpost + 7 then round(value, 2) end), 0) p2,
    nvl (sum (case when eff = s.ohpost + 14 then round(value, 2) end), 0) p3,
    nvl (sum (case when eff = s.ohpost + 21 then round(value, 2) end), 0) p4,
    nvl (sum (case when eff = s.ohpost + 28 then round(value, 2) end), 0) p5,
    nvl (sum (case when eff = s.ohpost + 35 then round(value, 2) end), 0) p6,
    nvl (sum (case when eff = s.ohpost + 42 then round(value, 2) end), 0) p7,
    nvl (sum (case when eff = s.ohpost + 49 then round(value, 2) end), 0) p8,
    nvl (sum (case when eff = s.ohpost + 56 then round(value, 2) end), 0) p9,
    nvl (sum (case when eff = s.ohpost + 63 then round(value, 2) end), 0) p10,
    nvl (sum (case when eff = s.ohpost + 70 then round(value, 2) end), 0) p11,
    nvl (sum (case when eff = s.ohpost + 77 then round(value, 2) end), 0) p12,
    nvl (sum (case when eff = s.ohpost + 84 then round(value, 2) end), 0) p13,
    nvl (sum (case when eff = s.ohpost + 91 then round(value, 2) end), 0) p14,
    nvl (sum (case when eff = s.ohpost + 98 then round(value, 2) end), 0) p15,
    nvl (sum (case when eff = s.ohpost + 105 then round(value, 2) end), 0) p16,
    nvl (sum (case when eff = s.ohpost + 112 then round(value, 2) end), 0) p17,
    nvl (sum (case when eff = s.ohpost + 119 then round(value, 2) end), 0) p18,
    nvl (sum (case when eff = s.ohpost + 126 then round(value, 2) end), 0) p19,
    nvl (sum (case when eff = s.ohpost + 133 then round(value, 2) end), 0) p20,
    nvl (sum (case when eff = s.ohpost + 140 then round(value, 2) end), 0) p21,
    nvl (sum (case when eff = s.ohpost + 147 then round(value, 2) end), 0) p22,
    nvl (sum (case when eff = s.ohpost + 154 then round(value, 2) end), 0) p23,
    nvl (sum (case when eff = s.ohpost + 161 then round(value, 2) end), 0) p24,
    nvl (sum (case when eff = s.ohpost + 168 then round(value, 2) end), 0) p25,
    nvl (sum (case when eff = s.ohpost + 175 then round(value, 2) end), 0) p26
     from udt_sourcingmetric_rb c, metriccategory m, sku s,loc l
    where     c.category = m.category
          and c.category in (418)
          and c.item = s.item
          and c.source = s.loc 
          and c.source = l.loc
    group by c.item, c.dest, c.source, l.loc_type, c.sourcing, c.category, m.descr
)

order by dest, item, loc_type, source
