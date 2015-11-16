--------------------------------------------------------
--  DDL for View U_03_SKUMETRIC
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_03_SKUMETRIC" ("ITEM", "MATCODE", "QB", "LOC", "CATEGORY", "DESCR", "VALUE", "TOTAL_COST", "TOTAL_EXEC", "A0504", "A0511", "A0518", "A0525", "A0601", "A0608", "A0615", "A0622", "A0629", "A0706", "A0713", "A0720", "A0727", "A0803", "A0810", "A0817", "A0824", "A0831", "A0907", "A0914", "A0921", "A0928", "A1005", "A1012", "A1019", "A1026", "A1102", "A1109", "A1116", "A1123", "A1130", "A1207", "A1214", "A1221", "A1228", "A0104", "A0111", "A0118", "A0125", "A0201", "A0208", "A0215", "A0222", "A0301", "A0308", "A0315", "A0322", "A0329", "A0405", "A0412", "A0419", "A0426") AS 
  SELECT u.item,
            SUBSTR (u.item, 1, 5) matcode,
            SUBSTR (u.item, 6, 5) qb,
            u.loc,
            u.category,
            u.descr,
            NVL (e.VALUE, 0) VALUE,
            (NVL (e.VALUE, 0)
             * (  NVL (a0504, 0)
                + NVL (a0511, 0)
                + NVL (a0518, 0)
                + NVL (a0525, 0)
                + NVL (a0601, 0)
                + NVL (a0608, 0)
                + NVL (a0615, 0)
                + NVL (a0622, 0)
                + NVL (a0629, 0)
                + NVL (a0706, 0)
                + NVL (a0713, 0)
                + NVL (a0720, 0)
                + NVL (a0727, 0)
                + NVL (a0803, 0)
                + NVL (a0810, 0)
                + NVL (a0817, 0)
                + NVL (a0824, 0)
                + NVL (a0831, 0)
                + NVL (a0907, 0)
                + NVL (a0914, 0)
                + NVL (a0921, 0)
                + NVL (a0928, 0)
                + NVL (a1005, 0)
                + NVL (a1012, 0)
                + NVL (a1019, 0)
                + NVL (a1026, 0)
                + NVL (a1102, 0)
                + NVL (a1109, 0)
                + NVL (a1116, 0)
                + NVL (a1123, 0)
                + NVL (a1130, 0)
                + NVL (a1207, 0)
                + NVL (a1214, 0)
                + NVL (a1221, 0)
                + NVL (a1228, 0)
                + NVL (a0104, 0)
                + NVL (a0111, 0)
                + NVL (a0118, 0)
                + NVL (a0125, 0)
                + NVL (a0201, 0)
                + NVL (a0208, 0)
                + NVL (a0215, 0)
                + NVL (a0222, 0)
                + NVL (a0301, 0)
                + NVL (a0308, 0)
                + NVL (a0315, 0)
                + NVL (a0322, 0)
                + NVL (a0329, 0)
                + NVL (a0405, 0)
                + NVL (a0412, 0)
                + NVL (a0419, 0)
                + NVL (a0426, 0)))
               total_cost,
            ROUND (
               (  NVL (a0504, 0)
                + NVL (a0511, 0)
                + NVL (a0518, 0)
                + NVL (a0525, 0)
                + NVL (a0601, 0)
                + NVL (a0608, 0)
                + NVL (a0615, 0)
                + NVL (a0622, 0)
                + NVL (a0629, 0)
                + NVL (a0706, 0)
                + NVL (a0713, 0)
                + NVL (a0720, 0)
                + NVL (a0727, 0)
                + NVL (a0803, 0)
                + NVL (a0810, 0)
                + NVL (a0817, 0)
                + NVL (a0824, 0)
                + NVL (a0831, 0)
                + NVL (a0907, 0)
                + NVL (a0914, 0)
                + NVL (a0921, 0)
                + NVL (a0928, 0)
                + NVL (a1005, 0)
                + NVL (a1012, 0)
                + NVL (a1019, 0)
                + NVL (a1026, 0)
                + NVL (a1102, 0)
                + NVL (a1109, 0)
                + NVL (a1116, 0)
                + NVL (a1123, 0)
                + NVL (a1130, 0)
                + NVL (a1207, 0)
                + NVL (a1214, 0)
                + NVL (a1221, 0)
                + NVL (a1228, 0)
                + NVL (a0104, 0)
                + NVL (a0111, 0)
                + NVL (a0118, 0)
                + NVL (a0125, 0)
                + NVL (a0201, 0)
                + NVL (a0208, 0)
                + NVL (a0215, 0)
                + NVL (a0222, 0)
                + NVL (a0301, 0)
                + NVL (a0308, 0)
                + NVL (a0315, 0)
                + NVL (a0322, 0)
                + NVL (a0329, 0)
                + NVL (a0405, 0)
                + NVL (a0412, 0)
                + NVL (a0419, 0)
                + NVL (a0426, 0)),
               1)
               total_exec,
            NVL (a0504, 0) a0504,
            NVL (a0511, 0) a0511,
            NVL (a0518, 0) a0518,
            NVL (a0525, 0) a0525,
            NVL (a0601, 0) a0601,
            NVL (a0608, 0) a0608,
            NVL (a0615, 0) a0615,
            NVL (a0622, 0) a0622,
            NVL (a0629, 0) a0629,
            NVL (a0706, 0) a0706,
            NVL (a0713, 0) a0713,
            NVL (a0720, 0) a0720,
            NVL (a0727, 0) a0727,
            NVL (a0803, 0) a0803,
            NVL (a0810, 0) a0810,
            NVL (a0817, 0) a0817,
            NVL (a0824, 0) a0824,
            NVL (a0831, 0) a0831,
            NVL (a0907, 0) a0907,
            NVL (a0914, 0) a0914,
            NVL (a0921, 0) a0921,
            NVL (a0928, 0) a0928,
            NVL (a1005, 0) a1005,
            NVL (a1012, 0) a1012,
            NVL (a1019, 0) a1019,
            NVL (a1026, 0) a1026,
            NVL (a1102, 0) a1102,
            NVL (a1109, 0) a1109,
            NVL (a1116, 0) a1116,
            NVL (a1123, 0) a1123,
            NVL (a1130, 0) a1130,
            NVL (a1207, 0) a1207,
            NVL (a1214, 0) a1214,
            NVL (a1221, 0) a1221,
            NVL (a1228, 0) a1228,
            NVL (a0104, 0) a0104,
            NVL (a0111, 0) a0111,
            NVL (a0118, 0) a0118,
            NVL (a0125, 0) a0125,
            NVL (a0201, 0) a0201,
            NVL (a0208, 0) a0208,
            NVL (a0215, 0) a0215,
            NVL (a0222, 0) a0222,
            NVL (a0301, 0) a0301,
            NVL (a0308, 0) a0308,
            NVL (a0315, 0) a0315,
            NVL (a0322, 0) a0322,
            NVL (a0329, 0) a0329,
            NVL (a0405, 0) a0405,
            NVL (a0412, 0) a0412,
            NVL (a0419, 0) a0419,
            NVL (a0426, 0) a0426
       FROM (SELECT 0 VALUE FROM DUAL) e,
            (  SELECT DISTINCT
                      c.item,
                      c.loc,
                      c.category,
                      m.descr,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('05/04/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0504,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('05/11/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0511,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('05/18/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0518,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('05/25/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0525,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('06/01/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0601,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('06/08/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0608,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('06/15/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0615,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('06/22/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0622,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('06/29/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0629,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('07/06/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0706,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('07/13/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0713,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('07/20/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0720,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('07/27/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0727,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('08/03/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0803,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('08/10/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0810,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('08/17/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0817,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('08/24/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0824,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('08/31/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0831,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('09/07/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0907,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('09/14/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0914,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('09/21/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0921,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('09/28/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0928,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('10/05/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1005,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('10/12/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1012,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('10/19/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1019,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('10/26/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1026,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('11/02/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1102,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('11/09/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1109,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('11/16/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1116,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('11/23/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1123,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('11/30/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1130,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('12/07/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1207,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('12/14/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1214,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('12/21/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1221,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('12/28/2014', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a1228,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('01/04/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0104,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('01/11/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0111,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('01/18/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0118,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('01/25/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0125,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('02/01/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0201,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('02/08/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0208,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('02/15/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0215,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('02/22/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0222,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('03/01/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0301,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('03/08/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0308,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('03/15/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0315,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('03/22/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0322,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('03/29/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0329,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('04/05/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0405,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('04/12/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0412,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('04/19/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0419,
                      NVL (
                         SUM (
                            CASE
                               WHEN eff = TO_DATE ('04/26/2015', 'MM/DD/YYYY')
                               THEN
                                  VALUE
                            END),
                         0)
                         a0426
                 FROM skumetric c, metriccategory m
                WHERE c.category = m.category
                      AND c.category IN
                             ('405', '406', '414', '421', '458', '463')
             GROUP BY c.item,
                      c.loc,
                      c.category,
                      m.descr) u
   ORDER BY u.category, u.item, u.loc
