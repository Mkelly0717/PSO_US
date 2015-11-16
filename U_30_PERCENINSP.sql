--------------------------------------------------------
--  DDL for View U_30_PERCENINSP
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_30_PERCENINSP" ("LOC", "MATCODE", "QB", "ITEM", "HI_VOL", "LOW_VOL", "PC_UTIL", "HRSPERDAY", "PERCEN") AS 
  SELECT loc,
            matcode,
            qb,
            matcode || qb item,
            hi_vol,
            low_vol,
            pc_util,
            hrsperday,
            percen
       FROM (SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'AD' qb,
                    ad percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'AI' qb,
                    ai percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'AP' qb,
                    ap percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'AR' qb,
                    ar percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'AW' qb,
                    aw percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'NA_PRESCRP' qb,
                    na_prescrp percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'NA_SCRAP' qb,
                    na_scrap percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUDRY' qb,
                    rudry percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUPCSTD' qb,
                    rupcstd percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUPRM' qb,
                    ruprm percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUPS' qb,
                    rups percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUPSSTRD' qb,
                    rupsstrd percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUSD' qb,
                    rusd percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUSDSTRD' qb,
                    rusdstrd percen
               FROM tmp_perceninsp
             UNION
             SELECT loc,
                    matcode,
                    hi_vol,
                    low_vol,
                    pc_util,
                    hrsperday,
                    'RUSTD' qb,
                    rustd percen
               FROM tmp_perceninsp)
   ORDER BY loc, matcode, qb
