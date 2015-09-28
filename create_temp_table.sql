    --------------------------------------------------------
    --  Drop Prexiting Table MAK_T30_part1
    --------------------------------------------------------
define PART_NAME = 'MAK_T30_part2b';
define PART_NAME_PK = 'MAK_T30_part2b_PK';
define VIEW_NAME = 'MAK_V30_part2b';


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE &PART_NAME CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/




    --------------------------------------------------------
    --  Create new Table MAK_T30_part1
    --------------------------------------------------------

CREATE TABLE &PART_NAME 
(
  DEST VARCHAR2(50 CHAR) NOT NULL 
, ITEM VARCHAR2(50 CHAR) NOT NULL 
, SOURCE VARCHAR2(50 CHAR) 
) 
LOGGING 
TABLESPACE "SCPODATA" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 81920 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);
/


ALTER TABLE &PART_NAME
MODIFY (SOURCE NOT NULL);
/

ALTER TABLE &PART_NAME
ADD CONSTRAINT &PART_NAME_PK PRIMARY KEY 
(
  DEST 
, ITEM 
, SOURCE 
)
ENABLE;
/

insert into &PART_NAME
( dest, item, source )
select dest, item, source
from &VIEW_NAME;

commit;


