--------------------------------------------------------
--  DDL for View UDV_P1_TMP
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_P1_TMP" ("SOURCING", "ITEM", "DEST", "SRC", "SRC_5ZIP", "DEST_5ZIP", "SRC_3ZIP", "DEST_3ZIP", "ET", "QTY", "RANK", "P1", "COST_PALLET", "COST", "VALUE") AS 
  with src_metric (sourcing, item, dest, src,src_5zip, dest_5zip, src_3zip, dest_3zip, et, qty, rank) as
    (
    /* Sourcing Metric Piece */
    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,ls.postalcode
      ,ld.postalcode
      ,LS.U_3DIGITZIP
      ,ld.u_3digitzip
      ,ld.u_equipment_type
      ,round(sum(value),0) qty
      ,dense_rank() over ( partition by item, dest order by sum(value)desc ) as rank
    from sourcingmetric sm
      , loc ls
      , loc ld
    where sm.category=418
        and sm.dest=ld.loc
        and ld.loc_type=3
        and sm.source=ls.loc
    group by sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,ls.postalcode
      ,ld.postalcode
      ,ld.u_3digitzip
      ,ls.u_3digitzip
      ,ld.u_equipment_type
    order by item
      , dest
      , rank asc
      , ld.postalcode
    )
select sm.sourcing
  , sm.item
  , sm.dest
  , sm.src
  , sm.src_5zip
  , sm.dest_5zip
  , sm.src_3zip
  , sm.dest_3zip
  , sm.et
  , sm.qty
  , sm.rank
  , ls.priority p1
  , CT.COST_PALLET
  , CTIER.COST
  , ctier.value
from src_metric sm
  , udt_llamasoft_data ls
  , UDT_COST_TRANSIT CT
  , COSTTIER ctier
where sm.src=ls.source(+)      and sm.src='UT50' and sm.dest='3000146840'
    and sm.dest=ls.dest(+)
    and sm.item=ls.item(+)
    AND SM.ET=LS.U_EQUIPMENT_TYPE(+)
    AND ( ( SM.SRC_5ZIP=CT.SOURCE_PC AND SM.DEST_5ZIP=CT.DEST_PC )
           OR
           ( SM.SRC_3ZIP=CT.SOURCE_geo AND SM.DEST_3ZIP=CT.DEST_geo )
        )
    AND SM.ET=CT.U_EQUIPMENT_TYPE
    and ctier.cost like sm.sourcing || '_' || sm.src || '->' || sm.dest || '%'
order by item
  , dest
  , RANK
  , cost_pallet
