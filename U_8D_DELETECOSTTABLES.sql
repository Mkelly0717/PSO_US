--------------------------------------------------------
--  DDL for Procedure U_8D_DELETECOSTTABLES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SCPOMGR"."U_8D_DELETECOSTTABLES" 
AS
begin
      
declare
  begin

loop
    delete from scpomgr.rescost where rownum < 25000;
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;
loop
    delete from scpomgr.costtier where rownum < 25000; 
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;

    loop
      delete from scpomgr.cost 
      where rownum < 25000
        and trim(cost) is not null; 
      exit when sql%rowcount < 24999;
      commit;
    end loop;
  end;  

loop
    delete from scpomgr.skucost where rownum < 25000;
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;
--

LOOP
    delete from scpomgr.storagerequirement where rownum < 25000;
    exit when sql%rowcount < 24999;
    commit;
end loop;
commit;

--loop
--    delete from scpomgr.res where rownum < 25000;
--    exit when sql%rowcount < 24999;
--    commit;
--end loop;
--commit;
--
--loop
--    delete from scpomgr.resconstraint where rownum < 25000;
--    exit when sql%rowcount < 24999;
--    commit;
--end loop;
--commit;

end;
