--------------------------------------------------------
--  DDL for View U_40_SRC_LIMITS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "SCPOMGR"."U_40_SRC_LIMITS" ("ELEMENT", "ITEM", "DEST", "SOURCE", "SOURCING") AS 
  SELECT 'Rule 1' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE     SUBSTR (source, 1, 2) = 'FR'
          AND SUBSTR (dest, 1, 2) = 'DE'
          AND SUBSTR (item, 1, 5) = '00003'
   UNION
   --rule 2

   SELECT 'Rule 2' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE     SUBSTR (source, 1, 2) = 'FR'
          AND SUBSTR (dest, 1, 2) = 'ES'
          AND SUBSTR (item, 1, 9) = '00003RUPC'
   UNION
   --rule 3

   SELECT 'Rule 3' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE (SUBSTR (source, 1, 2) = 'TR' AND SUBSTR (dest, 1, 2) <> 'TR')
          OR (SUBSTR (source, 1, 2) <> 'TR' AND SUBSTR (dest, 1, 2) = 'TR')
   UNION
   --rule 4

   SELECT 'Rule 4' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE     SUBSTR (source, 1, 2) = 'GB'
          AND SUBSTR (item, 1, 5) = '00001'
          AND (SUBSTR (item, 6, 5) = 'RUSTD' OR SUBSTR (item, 6, 4) = 'RUPC')
          AND SUBSTR (dest, 1, 2) NOT IN
                 ('FR', 'BE', 'DE', 'ES', 'PT', 'NL', 'AT', 'DK')
   UNION
   --rule 5

   SELECT 'Rule 5' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE     SUBSTR (source, 1, 2) = 'GB'
          AND SUBSTR (item, 1, 5) = '00001'
          AND SUBSTR (item, 6, 2) <> 'AI'
          AND SUBSTR (dest, 1, 2) NOT IN
                 ('FR', 'BE', 'DE', 'ES', 'PT', 'NL', 'AT', 'DK')
   UNION
   --rule 6

   SELECT 'Rule 6' element,
          item,
          dest,
          source,
          sourcing
     FROM sourcing
    WHERE     SUBSTR (source, 1, 2) = 'PT'
          AND SUBSTR (dest, 1, 2) <> 'PT'
          AND SUBSTR (item, 6, 4) <> 'RUPS'
