--Task 1
DROP TABLE t IF EXISTS;
commit; 

CREATE TABLE t ( 
	a int, 
    b varchar2(4000) default rpad('*',4000,'*'), 
    c varchar2(3000) default rpad('*',3000,'*') 
   );
commit; 
  
INSERT INTO t (a) VALUES (1);
INSERT INTO t (a) VALUES (2);
INSERT INTO t (a) VALUES (3);
commit; 

DELETE FROM t WHERE a = 2 ; 
commit; 

insert into t (a) values (4); 
commit; 

SELECT a FROM t;

/*
A
----------
1
3
4
*/

DROP TABLE t;
commit;


--Task_2

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

--Task_3


CREATE TABLE emp AS
SELECT
  object_id empno
, object_name ename
, created hiredate
, owner job
FROM
  all_objects;
commit;


ALTER  TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (empno);
commit;

begin
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );
end;


CREATE TABLE heap_addresses (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno, addr_type)
  );
COMMIT;

CREATE TABLE iot_addresses (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno,addr_type)
  )
  ORGANIZATION INDEX;
COMMIT;


INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

COMMIT;

exec dbms_stats.gather_table_stats('AShumilov', 'heap_addresses');
exec dbms_stats.gather_table_stats('AShumilov', 'iot_addresses');

SET LINESIZE 130;

EXPLAIN PLAN FOR
SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno = 42;

SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

/*
Plan hash value: 2428793282
 
-------------------------------------------------------------------------------------------------------
| Id  | Operation                            | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                     |                |     4 |   400 |     7   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                        |                |     4 |   400 |     7   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID        | EMP            |     1 |    54 |     2   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN                 | EMP_PK         |     1 |       |     1   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID BATCHED| HEAP_ADDRESSES |     4 |   184 |     5   (0)| 00:00:01 |
|*  5 |    INDEX RANGE SCAN                  | SYS_C007092    |     4 |       |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1
   2 - SEL$1 / "EMP"@"SEL$1"
   3 - SEL$1 / "EMP"@"SEL$1"
   4 - SEL$1 / "HEAP_ADDRESSES"@"SEL$1"
   5 - SEL$1 / "HEAP_ADDRESSES"@"SEL$1"
 
Outline Data
-------------
 
  /-*+
      BEGIN_OUTLINE_DATA
      USE_NL(@"SEL$1" "HEAP_ADDRESSES"@"SEL$1")
      LEADING(@"SEL$1" "EMP"@"SEL$1" "HEAP_ADDRESSES"@"SEL$1")
      BATCH_TABLE_ACCESS_BY_ROWID(@"SEL$1" "HEAP_ADDRESSES"@"SEL$1")
      INDEX_RS_ASC(@"SEL$1" "HEAP_ADDRESSES"@"SEL$1" ("HEAP_ADDRESSES"."EMPNO" 
              "HEAP_ADDRESSES"."ADDR_TYPE"))
      INDEX_RS_ASC(@"SEL$1" "EMP"@"SEL$1" ("EMP"."EMPNO"))
      OUTLINE_LEAF(@"SEL$1")
      ALL_ROWS
      DB_VERSION('21.1.0')
      OPTIMIZER_FEATURES_ENABLE('21.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  *-/
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=42)
   5 - access("HEAP_ADDRESSES"."EMPNO"=42)
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=0) "EMP"."EMPNO"[NUMBER,22], "EMP"."ENAME"[VARCHAR2,128], 
       "EMP"."HIREDATE"[DATE,7], "EMP"."JOB"[VARCHAR2,128], "HEAP_ADDRESSES"."EMPNO"[NUMBER,22], 
       "HEAP_ADDRESSES"."ADDR_TYPE"[VARCHAR2,10], "HEAP_ADDRESSES"."STREET"[VARCHAR2,20], 
       "HEAP_ADDRESSES"."CITY"[VARCHAR2,20], "HEAP_ADDRESSES"."STATE"[VARCHAR2,2], 
       "HEAP_ADDRESSES"."ZIP"[NUMBER,22]
   2 - "EMP"."EMPNO"[NUMBER,22], "EMP"."ENAME"[VARCHAR2,128], "EMP"."HIREDATE"[DATE,7], 
       "EMP"."JOB"[VARCHAR2,128]
   3 - "EMP".ROWID[ROWID,10], "EMP"."EMPNO"[NUMBER,22]
   4 - "HEAP_ADDRESSES"."EMPNO"[NUMBER,22], "HEAP_ADDRESSES"."ADDR_TYPE"[VARCHAR2,10], 
       "HEAP_ADDRESSES"."STREET"[VARCHAR2,20], "HEAP_ADDRESSES"."CITY"[VARCHAR2,20], 
       "HEAP_ADDRESSES"."STATE"[VARCHAR2,2], "HEAP_ADDRESSES"."ZIP"[NUMBER,22]
   5 - "HEAP_ADDRESSES".ROWID[ROWID,10], "HEAP_ADDRESSES"."EMPNO"[NUMBER,22], 
       "HEAP_ADDRESSES"."ADDR_TYPE"[VARCHAR2,10]
 
Query Block Registry:
---------------------
 
  SEL$1 (PARSER) [FINAL]
 
*/
 
EXPLAIN PLAN FOR
 SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno = 42;
 
SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

/*
Plan hash value: 555669464
 
--------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name              | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |                   |     4 |   400 |     3   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |                   |     4 |   400 |     3   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP               |     1 |    54 |     2   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | EMP_PK            |     1 |       |     1   (0)| 00:00:01 |
|*  4 |   INDEX RANGE SCAN           | SYS_IOT_TOP_66781 |     4 |   184 |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1
   2 - SEL$1 / "EMP"@"SEL$1"
   3 - SEL$1 / "EMP"@"SEL$1"
   4 - SEL$1 / "IOT_ADDRESSES"@"SEL$1"
 
Outline Data
-------------
 
  /-*+
      BEGIN_OUTLINE_DATA
      USE_NL(@"SEL$1" "IOT_ADDRESSES"@"SEL$1")
      LEADING(@"SEL$1" "EMP"@"SEL$1" "IOT_ADDRESSES"@"SEL$1")
      INDEX(@"SEL$1" "IOT_ADDRESSES"@"SEL$1" ("IOT_ADDRESSES"."EMPNO" 
              "IOT_ADDRESSES"."ADDR_TYPE"))
      INDEX_RS_ASC(@"SEL$1" "EMP"@"SEL$1" ("EMP"."EMPNO"))
      OUTLINE_LEAF(@"SEL$1")
      ALL_ROWS
      DB_VERSION('21.1.0')
      OPTIMIZER_FEATURES_ENABLE('21.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  *-/
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=42)
   4 - access("IOT_ADDRESSES"."EMPNO"=42)
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=0) "EMP"."EMPNO"[NUMBER,22], "EMP"."ENAME"[VARCHAR2,128], 
       "EMP"."HIREDATE"[DATE,7], "EMP"."JOB"[VARCHAR2,128], "IOT_ADDRESSES"."EMPNO"[NUMBER,22], 
       "IOT_ADDRESSES"."ADDR_TYPE"[VARCHAR2,10], "IOT_ADDRESSES"."STREET"[VARCHAR2,20], 
       "IOT_ADDRESSES"."CITY"[VARCHAR2,20], "IOT_ADDRESSES"."STATE"[VARCHAR2,2], 
       "IOT_ADDRESSES"."ZIP"[NUMBER,22]
   2 - "EMP"."EMPNO"[NUMBER,22], "EMP"."ENAME"[VARCHAR2,128], "EMP"."HIREDATE"[DATE,7], 
       "EMP"."JOB"[VARCHAR2,128]
   3 - "EMP".ROWID[ROWID,10], "EMP"."EMPNO"[NUMBER,22]
   4 - "IOT_ADDRESSES"."EMPNO"[NUMBER,22], "IOT_ADDRESSES"."ADDR_TYPE"[VARCHAR2,10], 
       "IOT_ADDRESSES"."STREET"[VARCHAR2,20], "IOT_ADDRESSES"."CITY"[VARCHAR2,20], 
       "IOT_ADDRESSES"."STATE"[VARCHAR2,2], "IOT_ADDRESSES"."ZIP"[NUMBER,22]
 
Query Block Registry:
---------------------
 
  SEL$1 (PARSER) [FINAL]
 
*/

--План запроса обычной таблицы (heap_addresses) больше по стоимости.
--В плане запроса таблицы heap_addresses видно, что выполняется дополнительное действие:
--4 |   TABLE ACCESS BY INDEX ROWID BATCHED| HEAP_ADDRESSES |     4 |   184 |     5   (0)| 00:00:01 
--обращение к ROWID (адресам данных), при чем самое дорогостоящее
--это доказывает, что фмзмческий ROWID на порядок медленее логического ROWID, используемого IOT tables.

DROP TABLE heap_addresses;
DROP TABLE iot_addresses;
DROP TABLE emp;
commit;


--Task_4

CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );

CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;
commit;

CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )
  , loc    VARCHAR2( 13 )
  )
  cluster emp_dept_cluster ( deptno ) ;
 
 CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )
  , job   VARCHAR2( 9 )
  , mgr   NUMBER
  , hiredate DATE
  , sal    NUMBER
  , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster emp_dept_cluster ( deptno ) ;
commit;

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');
 
ALTER session set NLS_DATE_FORMAT='DD-MM-YYYY'; 

INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT', null, '17-11-1981',     5000, null, 10);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',   7839, '01-05-1981',     2850, null, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',   7839, '09-06-1981',     2450, null, 10);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',   7839, '02-04-1981',     2975, null, 20);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',   7566, '19-04-1987',     3000, null, 20);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',   7566, '03-12-1981',     3000, null, 20);
INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',     7902, '17-12-1980',     800, null, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN',  7698, '20-02-1981',     1600,  300, 30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN',  7698, '22-02-1981',     1250,  500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN',  7698, '28-09-1981',     1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN',  7698, '08-09-1981',     1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',     7788, '23-05-1987',     1100, null, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',     7698, '03-12-1981',     950, null, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',     7782, '23-01-1982',     1300, null, 10);
commit;


EXPLAIN PLAN FOR
SELECT *
   FROM
  (
     SELECT dept_blk, 
            emp_blk, 
            CASE 
			 WHEN dept_blk <> emp_blk THEN '*' 
		    END flag,
		    deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

/*
Plan hash value: 735046682
 
-----------------------------------------------------------------------------------
| Id  | Operation           | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |             |    14 |   700 |     5  (20)| 00:00:01 |
|   1 |  SORT ORDER BY      |             |    14 |   700 |     5  (20)| 00:00:01 |
|   2 |   NESTED LOOPS      |             |    14 |   700 |     4   (0)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| EMP         |    14 |   350 |     4   (0)| 00:00:01 |
|*  4 |    INDEX UNIQUE SCAN| SYS_C007084 |     1 |    25 |     0   (0)| 00:00:01 |
-----------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$5C160134
   3 - SEL$5C160134 / "EMP"@"SEL$3"
   4 - SEL$5C160134 / "DEPT"@"SEL$3"
 
Outline Data
-------------
 
  /-*+
      BEGIN_OUTLINE_DATA
      USE_NL(@"SEL$5C160134" "DEPT"@"SEL$3")
      LEADING(@"SEL$5C160134" "EMP"@"SEL$3" "DEPT"@"SEL$3")
      INDEX(@"SEL$5C160134" "DEPT"@"SEL$3" ("DEPT"."DEPTNO"))
      FULL(@"SEL$5C160134" "EMP"@"SEL$3")
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$2")
      MERGE(@"SEL$3" >"SEL$2")
      OUTLINE(@"SEL$335DD26A")
      OUTLINE(@"SEL$1")
      MERGE(@"SEL$335DD26A" >"SEL$1")
      OUTLINE_LEAF(@"SEL$5C160134")
      ALL_ROWS
      DB_VERSION('21.1.0')
      OPTIMIZER_FEATURES_ENABLE('21.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  *-/
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=1) "DEPT"."DEPTNO"[NUMBER,22], 
       "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("DEPT".ROWID))[22], 
       "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("EMP".ROWID))[22], CASE  
       WHEN "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("DEPT".ROWID))<>"DBMS_RO
       WID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("EMP".ROWID)) THEN '*' END [1]
   2 - (#keys=0) "EMP".ROWID[ROWID,10], "DEPT".ROWID[ROWID,10], 
       "DEPT"."DEPTNO"[NUMBER,22]
   3 - "EMP".ROWID[ROWID,10], "EMP"."DEPTNO"[NUMBER,22]
   4 - "DEPT".ROWID[ROWID,10], "DEPT"."DEPTNO"[NUMBER,22]
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
 
Query Block Registry:
---------------------
 
  SEL$1 (PARSER)
    SEL$5C160134 (VIEW MERGE SEL$1 ; SEL$335DD26A) [FINAL]
  SEL$2 (PARSER)
    SEL$335DD26A (VIEW MERGE SEL$2 ; SEL$3)
  SEL$3 (PARSER)
 
 */


DROP TABLE emp;
DROP TABLE DEPT;
DROP CLUSTER emp_dept_cluster;
commit;

-- Taask_5

create cluster hash_emp_dept_cluster
( deptno NUMBER( 2 ) )
 hashkeys 100
 size 500
 STORAGE( INITIAL 10K NEXT 5K );


CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )
  , loc    VARCHAR2( 13 )
  )
  cluster hash_emp_dept_cluster ( deptno ) ;
 
 CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )
  , job   VARCHAR2( 9 )
  , mgr   NUMBER
  , hiredate DATE
  , sal    NUMBER
  , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster hash_emp_dept_cluster ( deptno ) ;
commit;

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');
 
ALTER session set NLS_DATE_FORMAT='DD-MM-YYYY'; 

INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT', null, '17-11-1981',     5000, null, 10);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',   7839, '01-05-1981',     2850, null, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',   7839, '09-06-1981',     2450, null, 10);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',   7839, '02-04-1981',     2975, null, 20);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',   7566, '19-04-1987',     3000, null, 20);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',   7566, '03-12-1981',     3000, null, 20);
INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',     7902, '17-12-1980',     800, null, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN',  7698, '20-02-1981',     1600,  300, 30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN',  7698, '22-02-1981',     1250,  500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN',  7698, '28-09-1981',     1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN',  7698, '08-09-1981',     1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',     7788, '23-05-1987',     1100, null, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',     7698, '03-12-1981',     950, null, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',     7782, '23-01-1982',     1300, null, 10);
commit;


EXPLAIN PLAN FOR
SELECT *
   FROM
  (
     SELECT dept_blk, 
            emp_blk, 
            CASE 
			 WHEN dept_blk <> emp_blk THEN '*' 
		    END flag,
		    deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

/*
Plan hash value: 304083712
 
----------------------------------------------------------------------------------
| Id  | Operation          | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |             |    14 |   700 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS      |             |    14 |   700 |     2   (0)| 00:00:01 |
|   2 |   INDEX FULL SCAN  | SYS_C007081 |     4 |   100 |     2   (0)| 00:00:01 |
|*  3 |   TABLE ACCESS HASH| EMP         |     4 |   100 |            |          |
----------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$5C160134
   2 - SEL$5C160134 / "DEPT"@"SEL$3"
   3 - SEL$5C160134 / "EMP"@"SEL$3"
 
Outline Data
-------------
 
  /-*+
      BEGIN_OUTLINE_DATA
      USE_NL(@"SEL$5C160134" "EMP"@"SEL$3")
      LEADING(@"SEL$5C160134" "DEPT"@"SEL$3" "EMP"@"SEL$3")
      HASH(@"SEL$5C160134" "EMP"@"SEL$3")
      INDEX(@"SEL$5C160134" "DEPT"@"SEL$3" ("DEPT"."DEPTNO"))
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$2")
      MERGE(@"SEL$3" >"SEL$2")
      OUTLINE(@"SEL$335DD26A")
      OUTLINE(@"SEL$1")
      MERGE(@"SEL$335DD26A" >"SEL$1")
      OUTLINE_LEAF(@"SEL$5C160134")
      ALL_ROWS
      DB_VERSION('21.1.0')
      OPTIMIZER_FEATURES_ENABLE('21.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  *-/
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=0) "DEPT".ROWID[ROWID,10], "DEPT"."DEPTNO"[NUMBER,22], 
       "EMP".ROWID[ROWID,10]
   2 - "DEPT".ROWID[ROWID,10], "DEPT"."DEPTNO"[NUMBER,22]
   3 - "EMP".ROWID[ROWID,10], "EMP"."DEPTNO"[NUMBER,22]
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
 
Query Block Registry:
---------------------
 
  SEL$1 (PARSER)
    SEL$5C160134 (VIEW MERGE SEL$1 ; SEL$335DD26A) [FINAL]
  SEL$2 (PARSER)
    SEL$335DD26A (VIEW MERGE SEL$2 ; SEL$3)
  SEL$3 (PARSER)
 
*/

DROP TABLE emp;
DROP TABLE DEPT;
DROP CLUSTER hash_emp_dept_cluster;
commit;



--
--select segment_name, segment_type from user_segments; 
--
--
-- SELECT * FROM scott.dept;
-- 
--
--SELECT * FROM _tab_pending_stats;
--
--select * from recyclebin;
--
--PURGE RECYCLEBIN;

