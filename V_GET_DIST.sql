--------------------------------------------------------
--  DDL for Function V_GET_DIST
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SCPOMGR"."V_GET_DIST" (
      V_ZIP_SOURCE       VARCHAR2 ,
      V_ZIP_DEST         VARCHAR2 ,
      V_U_EQUIPMENT_TYPE VARCHAR2 DEFAULT 'VN' ,
      V_DIRECTION        VARCHAR2 DEFAULT ' ' )
    RETURN NUMBER
  IS
    distance  NUMBER := 0;
    default_distance NUMBER := 0;
    /******************************************************************************
    NAME:       V_GET_DIST
    PURPOSE:
    REVISIONS:
    Ver        Date        Author           Description
    ---------  ----------  ---------------  ------------------------------------
    1.0        8/7/2015    Michael Kelly    1. Created this function.
    NOTES:This function will return the cost_pallet and ???? from udt_cost_transit.
    It first looks zip to zip for the 5 digit zips entered.
    If it cannot find the zip to zip it will look for the 3 digit zip to
    3 digit zip un the geo fields.
    If it cannot find the rate then, it will return the default cost
    from UDT_DEFAULT_PARAMETERS
    ******************************************************************************/
    -- Get the Default DIST
    CURSOR C_DEFAULT_DIST
    IS
      SELECT VALUE1 FROM UDT_DEFAULT_PARAMETERS WHERE NAME='DEF_MAX_DISTANCE';
      
    -- Get the 5 digit zip to 5 digit zip
    CURSOR C_5DIGIT_ZIP_COST
    IS
      SELECT DISTANCE
      FROM scpomgr.mak_udt_cost_transit_new ct
      WHERE ct.source_pc      = substr(v_zip_source,1,5)
      AND ct.dest_pc          = substr(v_zip_dest,1,5)
      AND ct.u_equipment_type = v_u_equipment_type
      AND ct.direction        = v_direction;
      
    -- Get the 3 digit zip to 3 digit zip
    CURSOR C_GEO_COST
    IS
      SELECT DISTANCE
      FROM scpomgr.mak_udt_cost_transit_new ct
      WHERE ct.source_geo     = '020' --substr(v_zip_source,1,3)
      AND ct.dest_geo         = '631' -- substr(v_zip_dest,1,3)
      AND ct.u_equipment_type = v_u_equipment_type
      AND ct.direction        = v_direction;
      
  BEGIN
 
    OPEN C_5DIGIT_ZIP_COST;
    FETCH C_5DIGIT_ZIP_COST INTO DISTANCE ;
    
    IF C_5DIGIT_ZIP_COST%ROWCOUNT = 0 THEN
      OPEN C_GEO_COST;
      FETCH C_GEO_COST INTO DISTANCE ;
      
      IF C_GEO_COST%ROWCOUNT = 0 THEN
        OPEN C_DEFAULT_DIST;
        FETCH C_DEFAULT_DIST INTO DISTANCE ;
        IF C_DEFAULT_DIST%ROWCOUNT = 0 THEN
          DISTANCE             := 999999;
        END IF;
      END IF;
    END IF;
    <<FOUND_VALUE>>
    RETURN DISTANCE;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  WHEN OTHERS THEN
    -- Consider logging the error and then re-raise
    RAISE;
  END V_GET_DIST;
