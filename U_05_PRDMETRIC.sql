--------------------------------------------------------
--  DDL for View U_05_PRDMETRIC
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_05_PRDMETRIC" ("ITEM", "OUTPUTITEM", "YIELDQTY", "PRODRATE", "LOC", "PRODUCTIONMETHOD", "CATEGORY", "DESCR", "AVG_RATE", "TOTAL_COST", "TOTAL_EXEC", "A0504", "A0511", "A0518", "A0525", "A0601", "A0608", "A0615", "A0622", "A0629", "A0706", "A0713", "A0720", "A0727", "A0803", "A0810", "A0817", "A0824", "A0831", "A0907", "A0914", "A0921", "A0928", "A1005", "A1012", "A1019", "A1026", "A1102", "A1109", "A1116", "A1123", "A1130", "A1207", "A1214", "A1221", "A1228", "A0104", "A0111", "A0118", "A0125", "A0201", "A0208", "A0215", "A0222", "A0301", "A0308", "A0315", "A0322", "A0329", "A0405", "A0412", "A0419", "A0426", "C0504", "C0511", "C0518", "C0525", "C0601", "C0608", "C0615", "C0622", "C0629", "C0706", "C0713", "C0720", "C0727", "C0803", "C0810", "C0817", "C0824", "C0831", "C0907", "C0914", "C0921", "C0928", "C1005", "C1012", "C1019", "C1026", "C1102", "C1109", "C1116", "C1123", "C1130", "C1207", "C1214", "C1221", "C1228", "C0104", "C0111", "C0118", "C0125", "C0201", "C0208", "C0215", "C0222", "C0301", "C0308", "C0315", "C0322", "C0329", "C0405", "C0412", "C0419", "C0426") AS 
  SELECT item,
          outputitem,
          yieldqty,
          prodrate,
          loc,
          productionmethod,
          category,
          descr,
          CASE
             WHEN total_exec = 0 THEN 0
             ELSE ROUND (total_cost / total_exec, 3)
          END
             avg_rate,
          ROUND (total_cost, 0) TOTAL_COST,
          ROUND (total_exec, 0) total_exec,
          ROUND (a0504, 1) a0504,
          ROUND (a0511, 1) a0511,
          ROUND (a0518, 1) a0518,
          ROUND (a0525, 1) a0525,
          ROUND (a0601, 1) a0601,
          ROUND (a0608, 1) a0608,
          ROUND (a0615, 1) a0615,
          ROUND (a0622, 0) a0622,
          ROUND (a0629, 1) a0629,
          ROUND (a0706, 1) a0706,
          ROUND (a0713, 1) a0713,
          ROUND (a0720, 1) a0720,
          ROUND (a0727, 1) a0727,
          ROUND (a0803, 1) a0803,
          ROUND (a0810, 1) a0810,
          ROUND (a0817, 1) a0817,
          ROUND (a0824, 1) a0824,
          ROUND (a0831, 1) a0831,
          ROUND (a0907, 1) a0907,
          ROUND (a0914, 1) a0914,
          ROUND (a0921, 1) a0921,
          ROUND (a0928, 1) a0928,
          ROUND (a1005, 1) a1005,
          ROUND (a1012, 1) a1012,
          ROUND (a1019, 1) a1019,
          ROUND (a1026, 1) a1026,
          ROUND (a1102, 1) a1102,
          ROUND (a1109, 1) a1109,
          ROUND (a1116, 1) a1116,
          ROUND (a1123, 1) a1123,
          ROUND (a1130, 1) a1130,
          ROUND (a1207, 1) a1207,
          ROUND (a1214, 1) a1214,
          ROUND (a1221, 1) a1221,
          ROUND (a1228, 1) a1228,
          ROUND (a0104, 1) a0104,
          ROUND (a0111, 1) a0111,
          ROUND (a0118, 1) a0118,
          ROUND (a0125, 1) a0125,
          ROUND (a0201, 1) a0201,
          ROUND (a0208, 1) a0208,
          ROUND (a0215, 1) a0215,
          ROUND (a0222, 1) a0222,
          ROUND (a0301, 1) a0301,
          ROUND (a0308, 1) a0308,
          ROUND (a0315, 1) a0315,
          ROUND (a0322, 1) a0322,
          ROUND (a0329, 1) a0329,
          ROUND (a0405, 1) a0405,
          ROUND (a0412, 1) a0412,
          ROUND (a0419, 1) a0419,
          ROUND (a0426, 1) a0426,
          ROUND (c0504, 1) c0504,
          ROUND (c0511, 1) c0511,
          ROUND (c0518, 1) c0518,
          ROUND (c0525, 1) c0525,
          ROUND (c0601, 1) c0601,
          ROUND (c0608, 1) c0608,
          ROUND (c0615, 1) c0615,
          ROUND (c0622, 0) c0622,
          ROUND (c0629, 1) c0629,
          ROUND (c0706, 1) c0706,
          ROUND (c0713, 1) c0713,
          ROUND (c0720, 1) c0720,
          ROUND (c0727, 1) c0727,
          ROUND (c0803, 1) c0803,
          ROUND (c0810, 1) c0810,
          ROUND (c0817, 1) c0817,
          ROUND (c0824, 1) c0824,
          ROUND (c0831, 1) c0831,
          ROUND (c0907, 1) c0907,
          ROUND (c0914, 1) c0914,
          ROUND (c0921, 1) c0921,
          ROUND (c0928, 1) c0928,
          ROUND (c1005, 1) c1005,
          ROUND (c1012, 1) c1012,
          ROUND (c1019, 1) c1019,
          ROUND (c1026, 1) c1026,
          ROUND (c1102, 1) c1102,
          ROUND (c1109, 1) c1109,
          ROUND (c1116, 1) c1116,
          ROUND (c1123, 1) c1123,
          ROUND (c1130, 1) c1130,
          ROUND (c1207, 1) c1207,
          ROUND (c1214, 1) c1214,
          ROUND (c1221, 1) c1221,
          ROUND (c1228, 1) c1228,
          ROUND (c0104, 1) c0104,
          ROUND (c0111, 1) c0111,
          ROUND (c0118, 1) c0118,
          ROUND (c0125, 1) c0125,
          ROUND (c0201, 1) c0201,
          ROUND (c0208, 1) c0208,
          ROUND (c0215, 1) c0215,
          ROUND (c0222, 1) c0222,
          ROUND (c0301, 1) c0301,
          ROUND (c0308, 1) c0308,
          ROUND (c0315, 1) c0315,
          ROUND (c0322, 1) c0322,
          ROUND (c0329, 1) c0329,
          ROUND (c0405, 1) c0405,
          ROUND (c0412, 1) c0412,
          ROUND (c0419, 1) c0419,
          ROUND (c0426, 1) c0426
     FROM (  SELECT u.item,
                    u.outputitem,
                    t.yieldqty,
                    t.prodrate,
                    u.loc,
                    u.productionmethod,
                    u.category,
                    u.descr,
                    t.sc_qty,
                    (  NVL (c0504, 0)
                     + NVL (c0511, 0)
                     + NVL (c0518, 0)
                     + NVL (c0525, 0)
                     + NVL (c0601, 0)
                     + NVL (c0608, 0)
                     + NVL (c0615, 0)
                     + NVL (c0622, 0)
                     + NVL (c0629, 0)
                     + NVL (c0706, 0)
                     + NVL (c0713, 0)
                     + NVL (c0720, 0)
                     + NVL (c0727, 0)
                     + NVL (c0803, 0)
                     + NVL (c0810, 0)
                     + NVL (c0817, 0)
                     + NVL (c0824, 0)
                     + NVL (c0831, 0)
                     + NVL (c0907, 0)
                     + NVL (c0914, 0)
                     + NVL (c0921, 0)
                     + NVL (c0928, 0)
                     + NVL (c1005, 0)
                     + NVL (c1012, 0)
                     + NVL (c1019, 0)
                     + NVL (c1026, 0)
                     + NVL (c1102, 0)
                     + NVL (c1109, 0)
                     + NVL (c1116, 0)
                     + NVL (c1123, 0)
                     + NVL (c1130, 0)
                     + NVL (c1207, 0)
                     + NVL (c1214, 0)
                     + NVL (c1221, 0)
                     + NVL (c1228, 0)
                     + NVL (c0104, 0)
                     + NVL (c0111, 0)
                     + NVL (c0118, 0)
                     + NVL (c0125, 0)
                     + NVL (c0201, 0)
                     + NVL (c0208, 0)
                     + NVL (c0215, 0)
                     + NVL (c0222, 0)
                     + NVL (c0301, 0)
                     + NVL (c0308, 0)
                     + NVL (c0315, 0)
                     + NVL (c0322, 0)
                     + NVL (c0329, 0)
                     + NVL (c0405, 0)
                     + NVL (c0412, 0)
                     + NVL (c0419, 0)
                     + NVL (c0426, 0))
                       total_cost,
                    (  a0504
                     + a0511
                     + a0518
                     + a0525
                     + a0601
                     + a0608
                     + a0615
                     + a0622
                     + a0629
                     + a0706
                     + a0713
                     + a0720
                     + a0727
                     + a0803
                     + a0810
                     + a0817
                     + a0824
                     + a0831
                     + a0907
                     + a0914
                     + a0921
                     + a0928
                     + a1005
                     + a1012
                     + a1019
                     + a1026
                     + a1102
                     + a1109
                     + a1116
                     + a1123
                     + a1130
                     + a1207
                     + a1214
                     + a1221
                     + a1228
                     + a0104
                     + a0111
                     + a0118
                     + a0125
                     + a0201
                     + a0208
                     + a0215
                     + a0222
                     + a0301
                     + a0308
                     + a0315
                     + a0322
                     + a0329
                     + a0405
                     + a0412
                     + a0419
                     + a0426)
                       total_exec,
                    a0504,
                    a0511,
                    a0518,
                    a0525,
                    a0601,
                    a0608,
                    a0615,
                    a0622,
                    a0629,
                    a0706,
                    a0713,
                    a0720,
                    a0727,
                    a0803,
                    a0810,
                    a0817,
                    a0824,
                    a0831,
                    a0907,
                    a0914,
                    a0921,
                    a0928,
                    a1005,
                    a1012,
                    a1019,
                    a1026,
                    a1102,
                    a1109,
                    a1116,
                    a1123,
                    a1130,
                    a1207,
                    a1214,
                    a1221,
                    a1228,
                    a0104,
                    a0111,
                    a0118,
                    a0125,
                    a0201,
                    a0208,
                    a0215,
                    a0222,
                    a0301,
                    a0308,
                    a0315,
                    a0322,
                    a0329,
                    a0405,
                    a0412,
                    a0419,
                    a0426,
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
                              c.item,
                              y.outputitem,
                              c.loc,
                              c.productionmethod,
                              c.category,
                              m.descr,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('05/04/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0504,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('05/11/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0511,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('05/18/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0518,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('05/25/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0525,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('06/01/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0601,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('06/08/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0608,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('06/15/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0615,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('06/22/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0622,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('06/29/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0629,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('07/06/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0706,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('07/13/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0713,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('07/20/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0720,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('07/27/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0727,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('08/03/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0803,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('08/10/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0810,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('08/17/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0817,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('08/24/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0824,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('08/31/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0831,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('09/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0907,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('09/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0914,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('09/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0921,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('09/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0928,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('10/05/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1005,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('10/12/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1012,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('10/19/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1019,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('10/26/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1026,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('11/02/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1102,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('11/09/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1109,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('11/16/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1116,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('11/23/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1123,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('11/30/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1130,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('12/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1207,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('12/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1214,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('12/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1221,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('12/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a1228,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('01/04/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0104,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('01/11/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0111,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('01/18/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0118,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('01/25/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0125,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('02/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0201,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('02/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0208,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('02/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0215,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('02/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0222,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('03/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0301,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('03/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0308,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('03/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0315,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('03/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0322,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('03/29/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0329,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('04/05/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0405,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('04/12/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0412,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('04/19/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0419,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN c.eff =
                                               TO_DATE ('04/26/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 a0426
                         FROM productionmetric c,
                              metriccategory m,
                              productionyield y
                        WHERE     c.category = m.category
                              AND c.category IN (418)
                              AND c.item = y.item
                              AND c.loc = y.loc
                              AND c.productionmethod = y.productionmethod
                     GROUP BY c.item,
                              c.loc,
                              c.productionmethod,
                              y.outputitem,
                              c.category,
                              m.descr) u,
                    (  SELECT DISTINCT
                              s.item,
                              y.outputitem,
                              s.loc,
                              s.productionmethod,
                              s.category,
                              c.descr,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('05/04/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0504,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('05/11/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0511,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('05/18/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0518,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('05/25/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0525,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('06/01/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0601,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('06/08/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0608,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('06/15/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0615,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('06/22/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0622,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('06/29/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0629,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('07/06/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0706,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('07/13/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0713,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('07/20/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0720,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('07/27/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0727,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('08/03/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0803,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('08/10/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0810,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('08/17/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0817,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('08/24/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0824,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('08/31/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0831,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('09/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0907,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('09/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0914,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('09/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0921,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('09/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0928,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('10/05/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1005,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('10/12/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1012,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('10/19/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1019,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('10/26/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1026,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('11/02/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1102,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('11/09/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1109,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('11/16/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1116,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('11/23/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1123,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('11/30/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1130,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('12/07/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1207,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('12/14/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1214,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('12/21/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1221,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('12/28/2014',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c1228,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('01/04/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0104,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('01/11/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0111,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('01/18/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0118,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('01/25/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0125,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('02/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0201,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('02/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0208,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('02/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0215,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('02/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0222,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('03/01/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0301,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('03/08/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0308,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('03/15/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0315,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('03/22/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0322,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('03/29/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0329,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('04/05/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0405,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('04/12/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0412,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('04/19/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0419,
                              NVL (
                                 SUM (
                                    CASE
                                       WHEN s.eff =
                                               TO_DATE ('04/26/2015',
                                                        'MM/DD/YYYY')
                                       THEN
                                          VALUE * y.yieldqty
                                    END),
                                 0)
                                 c0426
                         FROM productionresmetric s,
                              metriccategory c,
                              productionyield y
                        WHERE     s.category = c.category
                              AND c.category = 435
                              AND s.item = y.item
                              AND s.loc = y.loc
                              AND s.productionmethod = y.productionmethod
                     GROUP BY s.item,
                              s.loc,
                              s.productionmethod,
                              s.category,
                              c.descr,
                              y.outputitem) c,
                    (  SELECT DISTINCT c.item,
                                       y.outputitem,
                                       y.yieldqty,
                                       s.prodrate,
                                       c.loc,
                                       c.productionmethod,
                                       c.category,
                                       m.descr,
                                       SUM (VALUE) * y.yieldqty sc_qty
                         FROM productionmetric c,
                              metriccategory m,
                              productionyield y,
                              productionstep s
                        WHERE     c.category = m.category
                              AND c.category IN (418)
                              AND c.item = y.item
                              AND c.loc = y.loc
                              AND c.productionmethod = y.productionmethod
                              AND c.item = s.item
                              AND c.loc = s.loc
                              AND c.productionmethod = s.productionmethod
                              AND s.stepnum = 1
                     GROUP BY c.item,
                              c.loc,
                              c.category,
                              m.descr,
                              y.outputitem,
                              y.yieldqty,
                              s.prodrate,
                              c.productionmethod) t
              WHERE     u.item = c.item(+)
                    AND u.outputitem = c.outputitem(+)
                    AND u.loc = c.loc(+)
                    AND u.productionmethod = c.productionmethod(+)
                    AND u.item = t.item(+)
                    AND u.outputitem = t.outputitem(+)
                    AND u.loc = t.loc(+)
                    AND u.productionmethod = t.productionmethod(+)
           ORDER BY u.category,
                    u.productionmethod,
                    u.item,
                    u.loc)
