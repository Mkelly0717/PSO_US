--------------------------------------------------------
--  DDL for View UDV_RANK_SOURCINGMETRIC
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."UDV_RANK_SOURCINGMETRIC" ("SOURCING", "ITEM", "DEST", "SOURCE", "QTY", "RANK") AS 
  select sm.sourcing        ,sm.item ,sm.dest ,sm.source
      ,round(sum(value),0) qty ,rank() over ( partition by sourcing, item, dest
        order by sum(value)desc ) as rank
       from sourcingmetric sm , loc l
      where sm.category=418
        and sm.dest    =l.loc
        and l.loc_type =3
   group by sm.sourcing ,sm.item ,sm.dest ,sm.source
   order by sourcing    , item   , dest   , rank asc;
