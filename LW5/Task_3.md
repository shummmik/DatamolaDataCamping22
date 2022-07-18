# Task 3

```sql
EXPLAIN PLAN FOR
SELECT/*+ USE_MERGE(e, d) */ *
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     1 |   107 |     7  (15)| 00:00:01 |
--|   1 |  MERGE JOIN                  |         |     1 |   107 |     7  (15)| 00:00:01 |
--|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     2   (0)| 00:00:01 |
--|   3 |    INDEX FULL SCAN           | PK_DEPT |     4 |       |     1   (0)| 00:00:01 |
--|*  4 |   SORT JOIN                  |         |     1 |    87 |     5  (20)| 00:00:01 |
--|   5 |    TABLE ACCESS FULL         | EMP     |     1 |    87 |     4   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   4 - access("E"."DEPTNO"="D"."DEPTNO")
--       filter("E"."DEPTNO"="D"."DEPTNO")
-- 
--Hint Report (identified by operation id / Query Block Name / Object Alias):
--Total hints for statement: 1 (U - Unused (1))
-----------------------------------------------------------------------------
-- 
--   2 -  SEL$1 / "D"@"SEL$1"
--         U -  USE_MERGE(e, d)
```

Данный тип физического соединения данных является самым быстрым, 
однако требует, чтобы оба набора данных были отсортированы, например, есть индексы по соединяемым столбцам.
Merge наиболее эффективен в тех случаях, когда два набора данных достаточно велики,
 и отсортированы по соединяемым столбцам.
