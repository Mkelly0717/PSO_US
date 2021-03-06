--------------------------------------------------------
--  DDL for Procedure U_REFRESH_MVS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_REFRESH_MVS" as

begin

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_ALL','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_MISSING','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_NO_3DIGIT_COLL','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_3DIGIT_COSTTRN','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_3DIGIT_SUMMARY','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_5DIGIT_COLLECTION','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_5DIGIT_COSTTRN','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_NO_PC_SUMMARY','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_SRC_ALL','C');

DBMS_SNAPSHOT.REFRESH( 'SKUCONSTR_SRC_MISSING','C');

end;

/

