--------------------------------------------------------
--  DDL for View U_50_OPTIMIZER_COUNTS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_50_OPTIMIZER_COUNTS" ("CNT", "METRIC") AS 
  SELECT cnt, metric
     FROM (SELECT COUNT (*) cnt, 'ox OPTIMIZERSKUEXCEPTION' metric
             FROM optimizerskuexception
           UNION
           SELECT COUNT (*) cnt, 'ox oPTIMIZERSOURCINGEXCEPTION' metric
             FROM optimizersourcingexception
           UNION
           SELECT COUNT (*) cnt, 'ox OPTIMIZERPRODEXCEPTION' metric
             FROM optimizerprodexception
           UNION
           SELECT COUNT (*) cnt, 'ox OPTIMIZERCOSTEXCEPTION' metric
             FROM optimizercostexception
           UNION
           SELECT COUNT (*) cnt, 'ox OPTIMIZERCOSTEXCEPTION' metric
             FROM optimizercostexception
           UNION
           SELECT COUNT (*) cnt, 'ox OPTIMIZERRESEXCEPTION' metric
             FROM optimizerresexception
           UNION
           SELECT COUNT (*) cnt, 'ox OPTIMIZEREXCEPTION' metric
             FROM optimizerexception
           UNION
           SELECT COUNT (*) cnt, 'om OPTIMIZERLOCMAP' metric
             FROM optimizerlocmap
           UNION
           SELECT COUNT (*) cnt, 'om OPTIMIZERRESMAP' metric
             FROM optimizerresmap
           UNION
           SELECT COUNT (*) cnt, 'om OPTIMIZERSKUMAP' metric
             FROM optimizerskumap
           UNION
           SELECT COUNT (*) cnt, 'om OPTIMIZERSOURCINGMAP' metric
             FROM optimizersourcingmap
           UNION
           SELECT COUNT (*) cnt, 'om OPTIMIZERPRODUCTIONMAP' metric
             FROM optimizerproductionmap
           UNION
           SELECT COUNT (*) cnt, 'b OPTIMIZERBASISCOUNT' metric
             FROM optimizerbasiscount
           UNION
           SELECT COUNT (*) cnt, 'b OPTIMIZERBASIS' metric
             FROM optimizerbasis
           UNION
           SELECT COUNT (*) cnt, 'm SKUMETRIC' metric FROM skumetric
           UNION
           SELECT COUNT (*) cnt, 'm RESMETRIC' metric FROM resmetric
           UNION
           SELECT COUNT (*) cnt, 'm PRODUCTIONMETRIC' metric
             FROM productionmetric
           UNION
           SELECT COUNT (*) cnt, 'm PRODUCTIONRESMETRIC' metric
             FROM productionresmetric
           UNION
           SELECT COUNT (*) cnt, 'm SOURCINGRESMETRIC' metric
             FROM sourcingresmetric
           UNION
           SELECT COUNT (*) cnt, 'm SOURCINGMETRIC' metric
             FROM sourcingmetric
           UNION
             SELECT DISTINCT COUNT (*) cnt, 'src ' || sourcing metric
               FROM sourcing
           GROUP BY 'src ' || sourcing
           UNION
             SELECT DISTINCT SUM (qty) cnt, 'skucon ' || category metric
               FROM skuconstraint
           GROUP BY 'skucon ' || category
           UNION
             SELECT DISTINCT
                    COUNT (*) cnt,
                    CASE
                       WHEN basistype = 1
                       THEN
                          'b BASISTYPE ' || basistype || ' VARIABLES'
                       ELSE
                          'b BASISTYPE ' || basistype || ' CONSTRAINTS'
                    END
                       metric
               FROM optimizerbasis
           GROUP BY basistype)
   UNION
   SELECT DISTINCT numperiods cnt, 'b NUMPERIODS' metric FROM optimizerbasis
   ORDER BY metric
