--------------------------------------------------------
--  DDL for View U_06_RESUTIL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_06_RESUTIL" ("RES", "CATEGORY", "DESCR", "PC0504", "PC0511", "PC0518", "PC0525", "PC0601", "PC0608", "PC0615", "PC0622", "PC0629", "PC0706", "PC0713", "PC0720", "PC0727", "PC0803", "PC0810", "PC0817", "PC0824", "PC0831", "PC0907", "PC0914", "PC0921", "PC0928", "PC1005", "PC1012", "PC1019", "PC1026", "PC1102", "PC1109", "PC1116", "PC1123", "PC1130", "PC1207", "PC1214", "PC1221", "PC1228", "PC0104", "PC0111", "PC0118", "PC0125", "PC0201", "PC0208", "PC0215", "PC0222", "PC0301", "PC0308", "PC0315", "PC0322", "PC0329", "PC0405", "PC0412", "PC0419", "PC0426", "A0504", "A0511", "A0518", "A0525", "A0601", "A0608", "A0615", "A0622", "A0629", "A0706", "A0713", "A0720", "A0727", "A0803", "A0810", "A0817", "A0824", "A0831", "A0907", "A0914", "A0921", "A0928", "A1005", "A1012", "A1019", "A1026", "A1102", "A1109", "A1116", "A1123", "A1130", "A1207", "A1214", "A1221", "A1228", "A0104", "A0111", "A0118", "A0125", "A0201", "A0208", "A0215", "A0222", "A0301", "A0308", "A0315", "A0322", "A0329", "A0405", "A0412", "A0419", "A0426", "C0504", "C0511", "C0518", "C0525", "C0601", "C0608", "C0615", "C0622", "C0629", "C0706", "C0713", "C0720", "C0727", "C0803", "C0810", "C0817", "C0824", "C0831", "C0907", "C0914", "C0921", "C0928", "C1005", "C1012", "C1019", "C1026", "C1102", "C1109", "C1116", "C1123", "C1130", "C1207", "C1214", "C1221", "C1228", "C0104", "C0111", "C0118", "C0125", "C0201", "C0208", "C0215", "C0222", "C0301", "C0308", "C0315", "C0322", "C0329", "C0405", "C0412", "C0419", "C0426") AS 
  SELECT u.res,
            u.category,
            u.descr,                      --round(u.total_exec, 0) total_util,
            CASE WHEN c.c0504 = 0 THEN 0 ELSE ROUND (u.a0504 / c.c0504, 2) END
               pc0504,
            CASE WHEN c.c0511 = 0 THEN 0 ELSE ROUND (u.a0511 / c.c0511, 2) END
               pc0511,
            CASE WHEN c.c0518 = 0 THEN 0 ELSE ROUND (u.a0518 / c.c0518, 2) END
               pc0518,
            CASE WHEN c.c0525 = 0 THEN 0 ELSE ROUND (u.a0525 / c.c0525, 2) END
               pc0525,
            CASE WHEN c.c0601 = 0 THEN 0 ELSE ROUND (u.a0601 / c.c0601, 2) END
               pc0601,
            CASE WHEN c.c0608 = 0 THEN 0 ELSE ROUND (u.a0608 / c.c0608, 2) END
               pc0608,
            CASE WHEN c.c0615 = 0 THEN 0 ELSE ROUND (u.a0615 / c.c0615, 2) END
               pc0615,
            CASE WHEN c.c0622 = 0 THEN 0 ELSE ROUND (u.a0622 / c.c0622, 2) END
               pc0622,
            CASE WHEN c.c0629 = 0 THEN 0 ELSE ROUND (u.a0629 / c.c0629, 2) END
               pc0629,
            CASE WHEN c.c0706 = 0 THEN 0 ELSE ROUND (u.a0706 / c.c0706, 2) END
               pc0706,
            CASE WHEN c.c0713 = 0 THEN 0 ELSE ROUND (u.a0713 / c.c0713, 2) END
               pc0713,
            CASE WHEN c.c0720 = 0 THEN 0 ELSE ROUND (u.a0720 / c.c0720, 2) END
               pc0720,
            CASE WHEN c.c0727 = 0 THEN 0 ELSE ROUND (u.a0727 / c.c0727, 2) END
               pc0727,
            CASE WHEN c.c0803 = 0 THEN 0 ELSE ROUND (u.a0803 / c.c0803, 2) END
               pc0803,
            CASE WHEN c.c0810 = 0 THEN 0 ELSE ROUND (u.a0810 / c.c0810, 2) END
               pc0810,
            CASE WHEN c.c0817 = 0 THEN 0 ELSE ROUND (u.a0817 / c.c0817, 2) END
               pc0817,
            CASE WHEN c.c0824 = 0 THEN 0 ELSE ROUND (u.a0824 / c.c0824, 2) END
               pc0824,
            CASE WHEN c.c0831 = 0 THEN 0 ELSE ROUND (u.a0831 / c.c0831, 2) END
               pc0831,
            CASE WHEN c.c0907 = 0 THEN 0 ELSE ROUND (u.a0907 / c.c0907, 2) END
               pc0907,
            CASE WHEN c.c0914 = 0 THEN 0 ELSE ROUND (u.a0914 / c.c0914, 2) END
               pc0914,
            CASE WHEN c.c0921 = 0 THEN 0 ELSE ROUND (u.a0921 / c.c0921, 2) END
               pc0921,
            CASE WHEN c.c0928 = 0 THEN 0 ELSE ROUND (u.a0928 / c.c0928, 2) END
               pc0928,
            CASE WHEN c.c1005 = 0 THEN 0 ELSE ROUND (u.a1005 / c.c1005, 2) END
               pc1005,
            CASE WHEN c.c1012 = 0 THEN 0 ELSE ROUND (u.a1012 / c.c1012, 2) END
               pc1012,
            CASE WHEN c.c1019 = 0 THEN 0 ELSE ROUND (u.a1019 / c.c1019, 2) END
               pc1019,
            CASE WHEN c.c1026 = 0 THEN 0 ELSE ROUND (u.a1026 / c.c1026, 2) END
               pc1026,
            CASE WHEN c.c1102 = 0 THEN 0 ELSE ROUND (u.a1102 / c.c1102, 2) END
               pc1102,
            CASE WHEN c.c1109 = 0 THEN 0 ELSE ROUND (u.a1109 / c.c1109, 2) END
               pc1109,
            CASE WHEN c.c1116 = 0 THEN 0 ELSE ROUND (u.a1116 / c.c1116, 2) END
               pc1116,
            CASE WHEN c.c1123 = 0 THEN 0 ELSE ROUND (u.a1123 / c.c1123, 2) END
               pc1123,
            CASE WHEN c.c1130 = 0 THEN 0 ELSE ROUND (u.a1130 / c.c1130, 2) END
               pc1130,
            CASE WHEN c.c1207 = 0 THEN 0 ELSE ROUND (u.a1207 / c.c1207, 2) END
               pc1207,
            CASE WHEN c.c1214 = 0 THEN 0 ELSE ROUND (u.a1214 / c.c1214, 2) END
               pc1214,
            CASE WHEN c.c1221 = 0 THEN 0 ELSE ROUND (u.a1221 / c.c1221, 2) END
               pc1221,
            CASE WHEN c.c1228 = 0 THEN 0 ELSE ROUND (u.a1228 / c.c1228, 2) END
               pc1228,
            CASE WHEN c.c0104 = 0 THEN 0 ELSE ROUND (u.a0104 / c.c0104, 2) END
               pc0104,
            CASE WHEN c.c0111 = 0 THEN 0 ELSE ROUND (u.a0111 / c.c0111, 2) END
               pc0111,
            CASE WHEN c.c0118 = 0 THEN 0 ELSE ROUND (u.a0118 / c.c0118, 2) END
               pc0118,
            CASE WHEN c.c0125 = 0 THEN 0 ELSE ROUND (u.a0125 / c.c0125, 2) END
               pc0125,
            CASE WHEN c.c0201 = 0 THEN 0 ELSE ROUND (u.a0201 / c.c0201, 2) END
               pc0201,
            CASE WHEN c.c0208 = 0 THEN 0 ELSE ROUND (u.a0208 / c.c0208, 2) END
               pc0208,
            CASE WHEN c.c0215 = 0 THEN 0 ELSE ROUND (u.a0215 / c.c0215, 2) END
               pc0215,
            CASE WHEN c.c0222 = 0 THEN 0 ELSE ROUND (u.a0222 / c.c0222, 2) END
               pc0222,
            CASE WHEN c.c0301 = 0 THEN 0 ELSE ROUND (u.a0301 / c.c0301, 2) END
               pc0301,
            CASE WHEN c.c0308 = 0 THEN 0 ELSE ROUND (u.a0308 / c.c0308, 2) END
               pc0308,
            CASE WHEN c.c0315 = 0 THEN 0 ELSE ROUND (u.a0315 / c.c0315, 2) END
               pc0315,
            CASE WHEN c.c0322 = 0 THEN 0 ELSE ROUND (u.a0322 / c.c0322, 2) END
               pc0322,
            CASE WHEN c.c0329 = 0 THEN 0 ELSE ROUND (u.a0329 / c.c0329, 2) END
               pc0329,
            CASE WHEN c.c0405 = 0 THEN 0 ELSE ROUND (u.a0405 / c.c0405, 2) END
               pc0405,
            CASE WHEN c.c0412 = 0 THEN 0 ELSE ROUND (u.a0412 / c.c0412, 2) END
               pc0412,
            CASE WHEN c.c0419 = 0 THEN 0 ELSE ROUND (u.a0419 / c.c0419, 2) END
               pc0419,
            CASE WHEN c.c0426 = 0 THEN 0 ELSE ROUND (u.a0426 / c.c0426, 2) END
               pc0426,
            ROUND (u.a0504, 1) a0504,
            ROUND (u.a0511, 1) a0511,
            ROUND (u.a0518, 1) a0518,
            ROUND (u.a0525, 1) a0525,
            ROUND (u.a0601, 1) a0601,
            ROUND (u.a0608, 1) a0608,
            ROUND (u.a0615, 1) a0615,
            ROUND (u.a0622, 1) a0622,
            ROUND (u.a0629, 1) a0629,
            ROUND (u.a0706, 1) a0706,
            ROUND (u.a0713, 1) a0713,
            ROUND (u.a0720, 1) a0720,
            ROUND (u.a0727, 1) a0727,
            ROUND (u.a0803, 1) a0803,
            ROUND (u.a0810, 1) a0810,
            ROUND (u.a0817, 1) a0817,
            ROUND (u.a0824, 1) a0824,
            ROUND (u.a0831, 1) a0831,
            ROUND (u.a0907, 1) a0907,
            ROUND (u.a0914, 1) a0914,
            ROUND (u.a0921, 1) a0921,
            ROUND (u.a0928, 1) a0928,
            ROUND (u.a1005, 1) a1005,
            ROUND (u.a1012, 1) a1012,
            ROUND (u.a1019, 1) a1019,
            ROUND (u.a1026, 1) a1026,
            ROUND (u.a1102, 1) a1102,
            ROUND (u.a1109, 1) a1109,
            ROUND (u.a1116, 1) a1116,
            ROUND (u.a1123, 1) a1123,
            ROUND (u.a1130, 1) a1130,
            ROUND (u.a1207, 1) a1207,
            ROUND (u.a1214, 1) a1214,
            ROUND (u.a1221, 1) a1221,
            ROUND (u.a1228, 1) a1228,
            ROUND (u.a0104, 1) a0104,
            ROUND (u.a0111, 1) a0111,
            ROUND (u.a0118, 1) a0118,
            ROUND (u.a0125, 1) a0125,
            ROUND (u.a0201, 1) a0201,
            ROUND (u.a0208, 1) a0208,
            ROUND (u.a0215, 1) a0215,
            ROUND (u.a0222, 1) a0222,
            ROUND (u.a0301, 1) a0301,
            ROUND (u.a0308, 1) a0308,
            ROUND (u.a0315, 1) a0315,
            ROUND (u.a0322, 1) a0322,
            ROUND (u.a0329, 1) a0329,
            ROUND (u.a0405, 1) a0405,
            ROUND (u.a0412, 1) a0412,
            ROUND (u.a0419, 1) a0419,
            ROUND (u.a0426, 1) a0426,
            ROUND (c.c0504, 1) c0504,
            ROUND (c.c0511, 1) c0511,
            ROUND (c.c0518, 1) c0518,
            ROUND (c.c0525, 1) c0525,
            ROUND (c.c0601, 1) c0601,
            ROUND (c.c0608, 1) c0608,
            ROUND (c.c0615, 1) c0615,
            ROUND (c.c0622, 1) c0622,
            ROUND (c.c0629, 1) c0629,
            ROUND (c.c0706, 1) c0706,
            ROUND (c.c0713, 1) c0713,
            ROUND (c.c0720, 1) c0720,
            ROUND (c.c0727, 1) c0727,
            ROUND (c.c0803, 1) c0803,
            ROUND (c.c0810, 1) c0810,
            ROUND (c.c0817, 1) c0817,
            ROUND (c.c0824, 1) c0824,
            ROUND (c.c0831, 1) c0831,
            ROUND (c.c0907, 1) c0907,
            ROUND (c.c0914, 1) c0914,
            ROUND (c.c0921, 1) c0921,
            ROUND (c.c0928, 1) c0928,
            ROUND (c.c1005, 1) c1005,
            ROUND (c.c1012, 1) c1012,
            ROUND (c.c1019, 1) c1019,
            ROUND (c.c1026, 1) c1026,
            ROUND (c.c1102, 1) c1102,
            ROUND (c.c1109, 1) c1109,
            ROUND (c.c1116, 1) c1116,
            ROUND (c.c1123, 1) c1123,
            ROUND (c.c1130, 1) c1130,
            ROUND (c.c1207, 1) c1207,
            ROUND (c.c1214, 1) c1214,
            ROUND (c.c1221, 1) c1221,
            ROUND (c.c1228, 1) c1228,
            ROUND (c.c0104, 1) c0104,
            ROUND (c.c0111, 1) c0111,
            ROUND (c.c0118, 1) c0118,
            ROUND (c.c0125, 1) c0125,
            ROUND (c.c0201, 1) c0201,
            ROUND (c.c0208, 1) c0208,
            ROUND (c.c0215, 1) c0215,
            ROUND (c.c0222, 1) c0222,
            ROUND (c.c0301, 1) c0301,
            ROUND (c.c0308, 1) c0308,
            ROUND (c.c0315, 1) c0315,
            ROUND (c.c0322, 1) c0322,
            ROUND (c.c0329, 1) c0329,
            ROUND (c.c0405, 1) c0405,
            ROUND (c.c0412, 1) c0412,
            ROUND (c.c0419, 1) c0419,
            ROUND (c.c0426, 1) c0426
       FROM (SELECT u.res,
                    u.category,
                    u.descr,
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
               FROM (  SELECT DISTINCT
                              c.res,
                              c.category,
                              m.descr,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/04/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0504,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/11/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0511,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/18/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0518,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/25/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0525,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/01/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0601,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/08/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0608,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/15/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0615,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/22/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0622,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/29/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0629,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/06/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0706,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/13/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0713,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/20/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0720,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/27/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0727,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/03/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0803,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/10/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0810,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/17/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0817,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/24/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0824,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/31/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0831,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0907,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0914,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0921,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0928,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/05/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1005,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/12/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1012,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/19/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1019,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/26/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1026,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/02/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1102,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/09/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1109,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/16/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1116,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/23/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1123,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/30/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1130,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1207,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1214,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1221,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a1228,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/04/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0104,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/11/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0111,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/18/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0118,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/25/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0125,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0201,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0208,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0215,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0222,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0301,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0308,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0315,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0322,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/29/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0329,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/05/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0405,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/12/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0412,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/19/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0419,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/26/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE
                                    END),
                                 0)
                                 a0426
                         FROM resmetric c, metriccategory m, res r
                        WHERE     c.category = m.category
                              AND c.category IN (401)
                              AND c.res = r.res
                              AND r.TYPE = 4
                              AND SUBSTR (c.res, 1, 1) IN ('R', 'I')
                     GROUP BY c.res, c.category, m.descr) u) u,
            (SELECT res,
                    NVL (c0504, 0) c0504,
                    NVL (c0511, 0) c0511,
                    NVL (c0518, 0) c0518,
                    NVL (c0525, 0) c0525,
                    NVL (c0601, 0) c0601,
                    NVL (c0608, 0) c0608,
                    NVL (c0615, 0) c0615,
                    NVL (c0622, 0) c0622,
                    NVL (c0629, 0) c0629,
                    NVL (c0706, 0) c0706,
                    NVL (c0713, 0) c0713,
                    NVL (c0720, 0) c0720,
                    NVL (c0727, 0) c0727,
                    NVL (c0803, 0) c0803,
                    NVL (c0810, 0) c0810,
                    NVL (c0817, 0) c0817,
                    NVL (c0824, 0) c0824,
                    NVL (c0831, 0) c0831,
                    NVL (c0907, 0) c0907,
                    NVL (c0914, 0) c0914,
                    NVL (c0921, 0) c0921,
                    NVL (c0928, 0) c0928,
                    NVL (c1005, 0) c1005,
                    NVL (c1012, 0) c1012,
                    NVL (c1019, 0) c1019,
                    NVL (c1026, 0) c1026,
                    NVL (c1102, 0) c1102,
                    NVL (c1109, 0) c1109,
                    NVL (c1116, 0) c1116,
                    NVL (c1123, 0) c1123,
                    NVL (c1130, 0) c1130,
                    NVL (c1207, 0) c1207,
                    NVL (c1214, 0) c1214,
                    NVL (c1221, 0) c1221,
                    NVL (c1228, 0) c1228,
                    NVL (c0104, 0) c0104,
                    NVL (c0111, 0) c0111,
                    NVL (c0118, 0) c0118,
                    NVL (c0125, 0) c0125,
                    NVL (c0201, 0) c0201,
                    NVL (c0208, 0) c0208,
                    NVL (c0215, 0) c0215,
                    NVL (c0222, 0) c0222,
                    NVL (c0301, 0) c0301,
                    NVL (c0308, 0) c0308,
                    NVL (c0315, 0) c0315,
                    NVL (c0322, 0) c0322,
                    NVL (c0329, 0) c0329,
                    NVL (c0405, 0) c0405,
                    NVL (c0412, 0) c0412,
                    NVL (c0419, 0) c0419,
                    NVL (c0426, 0) c0426
               FROM (  SELECT DISTINCT
                              c.res,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/04/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0504,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/11/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0511,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/18/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0518,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('05/25/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0525,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/01/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0601,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/08/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0608,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/15/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0615,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/22/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0622,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('06/29/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0629,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/06/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0706,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/13/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0713,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/20/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0720,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('07/27/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0727,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/03/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0803,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/10/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0810,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/17/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0817,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/24/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0824,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('08/31/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0831,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0907,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0914,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0921,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('09/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0928,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/05/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1005,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/12/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1012,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/19/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1019,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('10/26/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1026,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/02/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1102,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/09/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1109,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/16/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1116,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/23/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1123,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('11/30/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1130,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1207,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1214,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1221,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('12/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c1228,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/04/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0104,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/11/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0111,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/18/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0118,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('01/25/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0125,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0201,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0208,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0215,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('02/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0222,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0301,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0308,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0315,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0322,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('03/29/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0329,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/05/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0405,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/12/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0412,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/19/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0419,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN eff =
                                               TO_DATE ('04/26/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          qty
                                    END),
                                 0)
                                 c0426
                         FROM resconstraint c
                     GROUP BY c.res)) c
      WHERE u.res = c.res(+)
   ORDER BY u.category, u.res
