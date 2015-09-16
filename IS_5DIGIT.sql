--------------------------------------------------------
--  DDL for Function IS_5DIGIT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SCPOMGR"."IS_5DIGIT" (Zip_Code varchar2)
RETURN number 
is
v_number number :=0;
BEGIN
  
  if ( regexp_like( Zip_Code, '[0-9][0-9][0-9][0-9][0-9]')) then
     v_number := 1;
  else 
     v_number := 0;
  end if;
  
  return v_number;

  exception
    when others then return 0;
END IS_5DIGIT;
