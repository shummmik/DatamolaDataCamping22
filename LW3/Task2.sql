CREATE TABLE t (
	x INT PRIMARY KEY,
	y CLOB,
	z BLOB
	);
commit;

select segment_name, segment_type from user_segments; 

/*
                   SEGMENT_NAME|   SEGMENT_TYPE
-----------------------------------------------
BIN$45K93Tz4dfTgVbKcyTjdsg==$0 |          TABLE
*/

DROP TABLE t;
commit;

CREATE TABLE t (
	x INT PRIMARY KEY,
	y CLOB,
	z BLOB
	) SEGMENT CREATION IMMEDIATE;
commit;


SELECT segment_name, segment_type FROM user_segments; 
/*
                   SEGMENT_NAME|   SEGMENT_TYPE
-----------------------------------------------
BIN$45K93Tz4dfTgVbKcyTjdsg==$0 |	      TABLE
SYS_C007057	                   |          INDEX
SYS_IL0000066734C00002$$	   |       LOBINDEX
SYS_IL0000066734C00003$$	   |       LOBINDEX
SYS_LOB0000066734C00002$$	   |     LOBSEGMENT
SYS_LOB0000066734C00003$$	   |     LOBSEGMENT
T	                           |          TABLE
*/

SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;

/*
DBMS_METADATA.GET_DDL('TABLE','T')
-------------------------------------------------------------------------------
"
  CREATE TABLE "ASHUMILOV"."T" 
   (	"X" NUMBER(*,0), 
	"Y" CLOB, 
	"Z" BLOB, 
	 PRIMARY KEY ("X")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 163840 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_DATA"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 163840 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_DATA" 
 LOB ("Y") STORE AS SECUREFILE (
  TABLESPACE "TS_DATA" ENABLE STORAGE IN ROW 4000 CHUNK 32768
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("Z") STORE AS SECUREFILE (
  TABLESPACE "TS_DATA" ENABLE STORAGE IN ROW 4000 CHUNK 32768
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) "
*/

DROP TABLE t;
commit;