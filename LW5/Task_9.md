# Task 8

```sql
EXPLAIN PLAN FOR
SELECT DEPT.DEPTNO, DEPT.DNAME, DEPT.LOC
    FROM EMP 
        RIGHT JOIN DEPT
        ON EMP.DEPTNO = DEPT.DEPTNO
        WHERE  EMP.DEPTNO IS NULL;

SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

--DEPTNO|DNAME     |LOC   |
--------+----------+------+
--    40|OPERATIONS|BOSTON|

------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     4 |   132 |     7  (15)| 00:00:01 |
--|   1 |  MERGE JOIN ANTI             |         |     4 |   132 |     7  (15)| 00:00:01 |
--|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     2   (0)| 00:00:01 |
--|   3 |    INDEX FULL SCAN           | PK_DEPT |     4 |       |     1   (0)| 00:00:01 |
--|*  4 |   SORT UNIQUE                |         |     1 |    13 |     5  (20)| 00:00:01 |
--|   5 |    TABLE ACCESS FULL         | EMP     |     1 |    13 |     4   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   4 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
--       filter("EMP"."DEPTNO"="DEPT"."DEPTNO")
```
Left Anti join выдает все записи, где нет связи с правой таблицей.

Right Anti join выдает все записи, где нет связи с левой таблицей.

