--------------------------------------------------------
--  DDL for View U_00_DISTANCE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_00_DISTANCE" ("DEST", "CITY_DEST", "SOURCE", "POSTALREGION", "POSTALREGION_SOURCE", "CITY_SOURCE", "TO_LAT", "FROM_LAT", "TO_LONG", "FROM_LONG", "DISTANCE", "CAPMIN", "ISS_CST", "COL_CST") AS 
  SELECT dest,
          city_dest,
          source,
          postalregion,
          postalregion_source,
          city_source,
          to_lat,
          from_lat,
          to_long,
          from_long,
          distance,
          capmin,
          CASE
             WHEN EXP (
                       -2.48516
                     - 0.720485 * LN (distance)
                     + 0.000631852 * (distance - 150) * capmin)
                  * distance < 0.135
             THEN
                0.135
             ELSE
                ROUND (
                   EXP (
                        -2.48516
                      - 0.720485 * LN (distance)
                      + 0.000631852 * (distance - 150) * capmin)
                   * distance,
                   3)
          END
             iss_cst,
          CASE
             WHEN distance
                  * EXP (
                       -1.65246234476771 - 0.872006304602446 * LN (distance)) <
                     0.135
             THEN
                0.135
             ELSE
                ROUND (
                   distance
                   * EXP (
                        -1.65246234476771 - 0.872006304602446 * LN (distance)),
                   3)
          END
             col_cst
     FROM (SELECT dest,
                  city_dest,
                  source,
                  to_lat,
                  from_lat,
                  to_long,
                  from_long,
                  postalregion,
                  postalregion_source,
                  city_source,
                  CASE
                     WHEN ROUND (
                             ACOS (
                                SIN (to_lat_aux) * SIN (from_lat_aux)
                                +   COS (to_lat_aux)
                                  * COS (from_lat_aux)
                                  * COS (from_long_aux - to_long_aux))
                             * 6371,
                             1) <= 0
                     THEN
                        1
                     ELSE
                        ROUND (
                           ACOS (
                              SIN (to_lat_aux) * SIN (from_lat_aux)
                              +   COS (to_lat_aux)
                                * COS (from_lat_aux)
                                * COS (from_long_aux - to_long_aux))
                           * 6371,
                           1)
                  END
                     distance,
                  CASE
                     WHEN (ROUND (
                              ACOS (
                                 SIN (to_lat_aux) * SIN (from_lat_aux)
                                 +   COS (to_lat_aux)
                                   * COS (from_lat_aux)
                                   * COS (from_long_aux - to_long_aux))
                              * 6371,
                              1)) > 150
                     THEN
                        1
                     ELSE
                        0
                  END
                     capmin
             FROM (SELECT d.dest,
                          d.postalregion,
                          d.city city_dest,
                          s.source,
                          s.postalregion postalregion_source,
                          s.city city_source,
                          d.to_lat,
                          d.to_long,
                          s.from_lat,
                          s.from_long,
                          ROUND (from_lat * 3.141592654 / 180, 6)
                             from_lat_aux,
                          ROUND (from_long * 3.141592654 / 180, 6)
                             from_long_aux,
                          ROUND (to_lat * 3.141592654 / 180, 6) to_lat_aux,
                          ROUND (to_long * 3.141592654 / 180, 6) to_long_aux
                     FROM (SELECT ld.loc dest,
                                  ld.descr,
                                  ld.country,
                                  ld.u_city city,
                                  ld.postalcode,
                                  gd.postalregion,
                                  NVL (gd.latitude, 40.230282) to_lat,
                                  NVL (gd.longitude, -3.5667) to_long
                             FROM loc ld, tmp_longlat gd
                            WHERE ld.loc_type = 2
                                  AND    ld.country
                                      || '-'
                                      || SUBSTR (ld.postalcode, 1, 4) =
                                         gd.postalregion(+)) d,
                          (SELECT ls.loc source,
                                  ls.descr,
                                  ls.country,
                                  ls.u_city city,
                                  ls.postalcode,
                                  gd.postalregion,
                                  NVL (gd.latitude, 40.230282) from_lat,
                                  NVL (gd.longitude, -3.5667) from_long
                             FROM loc ls, tmp_longlat gd
                            WHERE ls.loc_type = 2
                                  AND    ls.country
                                      || '-'
                                      || SUBSTR (ls.postalcode, 1, 4) =
                                         gd.postalregion(+)) s
                    WHERE     s.source <> d.dest
                          AND d.dest = 'ES32'
                          AND SUBSTR (s.source, 1, 2) = 'ES'))
