create or replace
procedure u_REFRESH_MVS as

begin

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_ALL','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_COLL_MISSING','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_NO_3DIGIT_COLL','C');

DBMS_SNAPSHOT.REFRESH( 'SCPOMGR.SKUCONSTR_NO_5DIGIT_COLLECTION','C');

end;
