# Task 7

```sql
EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    FULL OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);


--EMPNO|ENAME |JOB      |MGR |HIREDATE               |SAL |COMM|DEPTNO|DEPTNO|DNAME     |LOC     |
-------+------+---------+----+-----------------------+----+----+------+------+----------+--------+
-- 7782|CLARK |MANAGER  |7839|1981-06-09 00:00:00.000|2450|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7934|MILLER|CLERK    |7782|1982-01-23 00:00:00.000|1300|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7839|KING  |PRESIDENT|    |1981-11-17 00:00:00.000|5000|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7566|JONES |MANAGER  |7839|1981-04-02 00:00:00.000|2975|    |    20|    20|RESEARCH  |DALLAS  |
-- 7788|SCOTT |ANALYST  |7566|1987-04-19 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7902|FORD  |ANALYST  |7566|1981-12-03 00:00:00.000|3000|    |    20|    20|RESEARCH  |DALLAS  |
-- 7369|SMITH |CLERK    |7902|1980-12-17 00:00:00.000| 800|    |    20|    20|RESEARCH  |DALLAS  |
-- 7876|ADAMS |CLERK    |7788|1987-05-23 00:00:00.000|1100|    |    20|    20|RESEARCH  |DALLAS  |
-- 7698|BLAKE |MANAGER  |7839|1981-05-01 00:00:00.000|2850|    |    30|    30|SALES     |CHICAGO |
-- 7499|ALLEN |SALESMAN |7698|1981-02-20 00:00:00.000|1600| 300|    30|    30|SALES     |CHICAGO |
-- 7521|WARD  |SALESMAN |7698|1981-02-22 00:00:00.000|1250| 500|    30|    30|SALES     |CHICAGO |
-- 7654|MARTIN|SALESMAN |7698|1981-09-28 00:00:00.000|1250|1400|    30|    30|SALES     |CHICAGO |
-- 7844|TURNER|SALESMAN |7698|1981-09-08 00:00:00.000|1500|   0|    30|    30|SALES     |CHICAGO |
-- 7900|JAMES |CLERK    |7698|1981-12-03 00:00:00.000| 950|    |    30|    30|SALES     |CHICAGO |
--     |      |         |    |                       |    |    |      |    40|OPERATIONS|BOSTON  |


------------------------------------------------------------------------------------
--| Id  | Operation             | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT      |          |     4 |   468 |     8   (0)| 00:00:01 |
--|   1 |  VIEW                 | VW_FOJ_0 |     4 |   468 |     8   (0)| 00:00:01 |
--|*  2 |   HASH JOIN FULL OUTER|          |     4 |   428 |     8   (0)| 00:00:01 |
--|   3 |    TABLE ACCESS FULL  | EMP      |       |       |     4   (0)| 00:00:01 |
--|   4 |    TABLE ACCESS FULL  | DEPT     |     4 |    80 |     4   (0)| 00:00:01 |
------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   2 - access("E"."DEPTNO"="D"."DEPTNO")
```
FULL OUTER JOIN (или просто OUTER JOIN) используется, чтобы вернуть все записи,
имеющие значения в левой или правой таблице