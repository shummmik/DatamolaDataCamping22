# Task 8

```sql
EXPLAIN PLAN FOR
SELECT *
    FROM EMP
    where deptno in 
        (SELECT deptno FROM DEPT);

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

--EMPNO|ENAME |JOB      |MGR |HIREDATE               |SAL |COMM|DEPTNO|
-------+------+---------+----+-----------------------+----+----+------+
-- 7698|BLAKE |MANAGER  |7839|1981-05-01 00:00:00.000|2850|    |    30|
-- 7782|CLARK |MANAGER  |7839|1981-06-09 00:00:00.000|2450|    |    10|
-- 7566|JONES |MANAGER  |7839|1981-04-02 00:00:00.000|2975|    |    20|
-- 7788|SCOTT |ANALYST  |7566|1987-04-19 00:00:00.000|3000|    |    20|
-- 7902|FORD  |ANALYST  |7566|1981-12-03 00:00:00.000|3000|    |    20|
-- 7369|SMITH |CLERK    |7902|1980-12-17 00:00:00.000| 800|    |    20|
-- 7499|ALLEN |SALESMAN |7698|1981-02-20 00:00:00.000|1600| 300|    30|
-- 7521|WARD  |SALESMAN |7698|1981-02-22 00:00:00.000|1250| 500|    30|
-- 7654|MARTIN|SALESMAN |7698|1981-09-28 00:00:00.000|1250|1400|    30|
-- 7844|TURNER|SALESMAN |7698|1981-09-08 00:00:00.000|1500|   0|    30|
-- 7876|ADAMS |CLERK    |7788|1987-05-23 00:00:00.000|1100|    |    20|
-- 7900|JAMES |CLERK    |7698|1981-12-03 00:00:00.000| 950|    |    30|
-- 7934|MILLER|CLERK    |7782|1982-01-23 00:00:00.000|1300|    |    10|
-- 7839|KING  |PRESIDENT|    |1981-11-17 00:00:00.000|5000|    |    10|

----------------------------------------------------------------------------
--| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |      |     1 |    87 |     4   (0)| 00:00:01 |
--|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     4   (0)| 00:00:01 |
----------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   1 - filter("DEPTNO" IS NOT NULL)




EXPLAIN PLAN FOR       
SELECT *
    FROM DEPT
    where deptno IN 
        (SELECT deptno FROM EMP);

SELECT * FROM table (DBMS_XPLAN.DISPLAY);
--
--DEPTNO|DNAME     |LOC     |
--------+----------+--------+
--    10|ACCOUNTING|NEW YORK|
--    20|RESEARCH  |DALLAS  |
--    30|SALES     |CHICAGO |
 
------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     1 |    33 |     5  (20)| 00:00:01 |
--|   1 |  NESTED LOOPS                |         |     1 |    33 |     5  (20)| 00:00:01 |
--|   2 |   NESTED LOOPS               |         |     1 |    33 |     5  (20)| 00:00:01 |
--|   3 |    SORT UNIQUE               |         |     1 |    13 |     4   (0)| 00:00:01 |
--|   4 |     TABLE ACCESS FULL        | EMP     |     1 |    13 |     4   (0)| 00:00:01 |
--|*  5 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
--|   6 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     1 |    20 |     0   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")


EXPLAIN PLAN FOR       
SELECT *
    FROM DEPT
    where deptno IN 
        (SELECT /*+MERGE_SJ*/ deptno FROM EMP);

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

--DEPTNO|DNAME     |LOC     |
--------+----------+--------+
--    10|ACCOUNTING|NEW YORK|
--    20|RESEARCH  |DALLAS  |
--    30|SALES     |CHICAGO |

------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     1 |    33 |     7  (15)| 00:00:01 |
--|   1 |  MERGE JOIN SEMI             |         |     1 |    33 |     7  (15)| 00:00:01 |
--|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     2   (0)| 00:00:01 |
--|   3 |    INDEX FULL SCAN           | PK_DEPT |     4 |       |     1   (0)| 00:00:01 |
--|*  4 |   SORT UNIQUE                |         |     1 |    13 |     5  (20)| 00:00:01 |
--|   5 |    TABLE ACCESS FULL         | EMP     |     1 |    13 |     4   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   4 - access("DEPTNO"="DEPTNO")
--       filter("DEPTNO"="DEPTNO")
```
Semi join выдает все записи левой таблицы, без присоединения к правой, 
мы только проверяем, есть ли хотя бы одно соединение с правой частью.