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


exec  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );


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
--|   4 |   TABLE ACCESS BY INDEX ROWID BATCHED| HEAP_ADDRESSES |     4 |   184 |     5   (0)| 00:00:01 |
--обращение к ROWID (адресам данных), при чем самое дорогостоящее
--это доказывает, что физический ROWID на порядок медленее логического ROWID, используемого IOT tables.

DROP TABLE heap_addresses;
DROP TABLE iot_addresses;
DROP TABLE emp;
commit;