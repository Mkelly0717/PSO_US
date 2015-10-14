--------------------------------------------------------
--  DDL for View MAK_V30_PART1
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."MAK_V30_PART1" ("SECTION", "ITEM", "DEST", "SOURCE", "TRANSMODE", "EFF", "FACTOR", "ARRIVCAL", "MAJORSHIPQTY", "MINORSHIPQTY", "ENABLEDYNDEPSW", "SHRINKAGEFACTOR", "MAXSHIPQTY", "ABBR", "SOURCING", "DISC", "MAXLEADTIME", "MINLEADTIME", "PRIORITY", "ENABLESW", "YIELDFACTOR", "SUPPLYLEADTIME", "COSTPERCENTAGE", "SUPPLYTRANSFERCOST", "NONEWSUPPLYDATE", "SHIPCAL", "FF_TRIGGER_CONTROL", "PULLFORWARDDUR", "SPLITQTY", "LOADDUR", "UNLOADDUR", "REVIEWCAL", "USELOOKAHEADSW", "CONVENIENTSHIPQTY", "CONVENIENTADJUPPCT", "CONVENIENTOVERRIDETHRESHOLD", "ROUNDINGFACTOR", "ORDERGROUP", "ORDERGROUPMEMBER", "LOTSIZESENABLEDSW", "CONVENIENTADJDOWNPCT") AS 
  select distinct 'U_30_SRC_DAILY_PART1' section, u.item, u.dest, u.source
      , 'TRUCK' transmode, v_init_eff_date eff
      ,1 factor, ' ' arrivcal, 0 majorshipqty, 0 minorshipqty, 1 enabledyndepsw
      ,0 shrinkagefactor, 0 maxshipqty, ' ' abbr, 'ISS1EXCL' sourcing
      ,v_init_eff_date disc, 1440 * 365 * 100 maxleadtime, 0 minleadtime
      ,1 priority, 1 enablesw, 100 yieldfactor, 0 supplyleadtime
      ,100 costpercentage, 0 supplytransfercost, v_init_eff_date nonewsupplydate
      ,' ' shipcal, ''  ff_trigger_control, 0 pullforwarddur, 0 splitqty
      ,0 loaddur, 0 unloaddur, ' ' reviewcal, 1 uselookaheadsw
      ,0 convenientshipqty, 0 convenientadjuppct, 0 convenientoverridethreshold
      ,0 roundingfactor, ' ' ordergroup, ' ' ordergroupmember
      ,0 lotsizesenabledsw, 0 convenientadjdownpct
from sourcing c, sku ss, sku sd, 

            (select distinct g.item, g.loc dest, g.exclusive_loc source
            from udt_gidlimits_na g, loc l
            where g.exclusive_loc = l.loc
            and l.loc_type = 4
            and g.exclusive_loc is not null
            and g.de = 'E'
            
            union
            
            select distinct g.item, g.loc, g.mandatory_loc 
            from udt_gidlimits_na g, loc l
            where g.mandatory_loc = l.loc
            and l.loc_type = 2
            and g.mandatory_loc is not null
            ) u
    
where u.item = ss.item
and u.source = ss.loc
and u.item = sd.item
and u.dest = sd.loc
and u.item = c.item(+)
and u.dest = c.dest(+)
