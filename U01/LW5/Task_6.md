# Task 6

```sql

EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    LEFT OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);


--EMPNO|ENAME |JOB      |MGR |HIREDATE               |SAL |COMM|DEPTNO|DEPTNO|DNAME     |LOC     |
-------+------+---------+----+-----------------------+----+----+------+------+----------+--------+
-- 7698|BLAKE |MANAGER  |7839|1981-05-01 00:00:00.000|2850|    |    30|    30|SALES     |CHICAGO |
-- 7782|CLARK |MANAGER  |7839|1981-06-09 00:00:00.000|2450|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7566|JONES |MANAGER  |7839|1981-04-02 00:00:00.000|2975|    |    20|    20|RESEARCH  |DALLAS  |
-- 7788|SCOTT |ANALYST  |7566|1987-04-19 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7902|FORD  |ANALYST  |7566|1981-12-03 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7369|SMITH |CLERK    |7902|1980-12-17 00:00:00.000| 800|    |    20|    20|RESEARCH  |DALLAS  |
-- 7499|ALLEN |SALESMAN |7698|1981-02-20 00:00:00.000|1600| 300|    30|    30|SALES     |CHICAGO |
-- 7521|WARD  |SALESMAN |7698|1981-02-22 00:00:00.000|1250| 500|    30|    30|SALES     |CHICAGO |
-- 7654|MARTIN|SALESMAN |7698|1981-09-28 00:00:00.000|1250|1400|    30|    30|SALES     |CHICAGO |
-- 7844|TURNER|SALESMAN |7698|1981-09-08 00:00:00.000|1500|   0|    30|    30|SALES     |CHICAGO |
-- 7876|ADAMS |CLERK    |7788|1987-05-23 00:00:00.000|1100|    |    20|    20|RESEARCH  |DALLAS  |
-- 7900|JAMES |CLERK    |7698|1981-12-03 00:00:00.000| 950|    |    30|    30|SALES     |CHICAGO |
-- 7934|MILLER|CLERK    |7782|1982-01-23 00:00:00.000|1300|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7839|KING  |PRESIDENT|    |1981-11-17 00:00:00.000|5000|    |    10|    10|ACCOUNTING|NEW YORK|

------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     1 |   107 |     4   (0)| 00:00:01 |
--|   1 |  NESTED LOOPS OUTER          |         |     1 |   107 |     4   (0)| 00:00:01 |
--|   2 |   TABLE ACCESS FULL          | EMP     |     1 |    87 |     4   (0)| 00:00:01 |
--|   3 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     1 |    20 |     0   (0)| 00:00:01 |
--|*  4 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   4 - access("E"."DEPTNO"="D"."DEPTNO"(+))

EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    RIGHT OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

--EMPNO|ENAME |JOB      |MGR |HIREDATE               |SAL |COMM|DEPTNO|DEPTNO|DNAME     |LOC     |
-------+------+---------+----+-----------------------+----+----+------+------+----------+--------+
-- 7934|MILLER|CLERK    |7782|1982-01-23 00:00:00.000|1300|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7839|KING  |PRESIDENT|    |1981-11-17 00:00:00.000|5000|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7782|CLARK |MANAGER  |7839|1981-06-09 00:00:00.000|2450|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7902|FORD  |ANALYST  |7566|1981-12-03 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7876|ADAMS |CLERK    |7788|1987-05-23 00:00:00.000|1100|    |    20|    20|RESEARCH  |DALLAS  |
-- 7788|SCOTT |ANALYST  |7566|1987-04-19 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7566|JONES |MANAGER  |7839|1981-04-02 00:00:00.000|2975|    |    20|    20|RESEARCH  |DALLAS  |
-- 7369|SMITH |CLERK    |7902|1980-12-17 00:00:00.000| 800|    |    20|    20|RESEARCH  |DALLAS  |
-- 7900|JAMES |CLERK    |7698|1981-12-03 00:00:00.000| 950|    |    30|    30|SALES     |CHICAGO |
-- 7844|TURNER|SALESMAN |7698|1981-09-08 00:00:00.000|1500|   0|    30|    30|SALES     |CHICAGO |
-- 7654|MARTIN|SALESMAN |7698|1981-09-28 00:00:00.000|1250|1400|    30|    30|SALES     |CHICAGO |
-- 7521|WARD  |SALESMAN |7698|1981-02-22 00:00:00.000|1250| 500|    30|    30|SALES     |CHICAGO |
-- 7698|BLAKE |MANAGER  |7839|1981-05-01 00:00:00.000|2850|    |    30|    30|SALES     |CHICAGO |
-- 7499|ALLEN |SALESMAN |7698|1981-02-20 00:00:00.000|1600| 300|    30|    30|SALES     |CHICAGO |
--     |      |         |    |                       |    |    |      |    40|OPERATIONS|BOSTON  |
```
LEFT OUTER JOIN - внешнее присоединение «слева».
Когда все записи слева соединяются с записями справа, при невозможности - заполняются Null.
LEFT OUTER JOIN - внешнее присоединение «справа».
Когда все записи справа соединяются с записями слева, при невозможности - заполняются Null.