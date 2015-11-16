--------------------------------------------------------
--  DDL for View U_99_SKU_VALUES
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_99_SKU_VALUES" ("LOC_TYPE", "U_STOCK", "REPLENTYPE", "OHPOST", "QTYUOM", "CURRENCYUOM", "STORABLESW", "ENABLESW", "TIMEUOM", "INFCARRYFWDSW", "INFINITESUPPLYSW", "CNT") AS 
  select distinct l.loc_type, i.u_stock, s.replentype,     s.ohpost,     s.qtyuom,    s.currencyuom,     s.storablesw,      s.enablesw,     s.timeuom, s.infcarryfwdsw,     s.infinitesupplysw, count(*) cnt
        from sku s, loc l, item i
        where s.loc = l.loc
        and s.item = i.item
        and loc_type in (1, 2, 3)
group by l.loc_type, i.u_stock, s.replentype,     s.ohpost,     s.qtyuom,    s.currencyuom,     s.storablesw,      s.enablesw,     s.timeuom, s.infcarryfwdsw,  s.infinitesupplysw
order by l.loc_type, i.u_stock
