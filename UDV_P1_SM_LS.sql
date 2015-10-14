--------------------------------------------------------
--  DDL for View UDV_P1_SM_LS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_P1_SM_LS" ("SOURCING", "ITEM", "DEST", "SRC", "SRC_5ZIP", "DEST_5ZIP", "SRC_3ZIP", "DEST_3ZIP", "ET", "QTY", "RANK", "P1", "COST", "VALUE") AS 
  with src_metric (sourcing, item, dest, src,src_5zip, dest_5zip, src_3zip, dest_3zip, et, qty, rank) as
    (
    /* Sourcing Metric Piece */
    select sm.sourcing
      ,sm.item
      ,sm.dest
      ,sm.source
      ,ls.postalcode
      ,ld.postalcode
      ,ls.u_3digitzip
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
   , ctier.cost
  , ctier.value
from src_metric sm
  , udt_llamasoft_data ls
  , COSTTIER CTIER
WHERE   SM.SRC  =LS.SOURCE(+)
    AND SM.DEST =LS.DEST(+)
    AND SM.ITEM =LS.ITEM(+)
    AND SM.ET   =LS.U_EQUIPMENT_TYPE(+)
    and ctier.cost = sm.sourcing
    || '_'
    || sm.src
    || '->'
    || SM.DEST
    || '-202'
--    AND SM.SRC='UT50'
--    and sm.dest='3000146840'
ORDER BY SM.ITEM
  , SM.DEST
  , sm.RANK
