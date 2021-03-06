# Task 4

```sql
EXPLAIN PLAN FOR
SELECT/*+ USE_HASH(e, d) */ *
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

-----------------------------------------------------------------------------
--| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT   |      |     1 |   107 |     8   (0)| 00:00:01 |
--|*  1 |  HASH JOIN         |      |     1 |   107 |     8   (0)| 00:00:01 |
--|   2 |   TABLE ACCESS FULL| EMP  |     1 |    87 |     4   (0)| 00:00:01 |
--|   3 |   TABLE ACCESS FULL| DEPT |     4 |    80 |     4   (0)| 00:00:01 |
-----------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   1 - access("E"."DEPTNO"="D"."DEPTNO")
-- 
--Hint Report (identified by operation id / Query Block Name / Object Alias):
--Total hints for statement: 1 (U - Unused (1))
-----------------------------------------------------------------------------
-- 
--   2 -  SEL$1 / "E"@"SEL$1"
```
Работу данного алгоритма можно разделить на 2 итерации.
В первой «Build» строится хэш-таблица при помощи вычисления хэш-значения для 
каждой строки одного набора данных (обычно меньшего из двух). Эти хэши вычисляются 
на основе ключей соединения входных данных и затем сохраняются вместе со строкой в ​​хеш-таблице.
После построения хэш-таблицы БД начинает итерацию «Probe». 
Он для каждой строки другого набора данных, с помощью той же хэш-функции, 
вычисляет хэш-значение и осуществляет поиск совпадений по хэш-таблице. Если он находит 
совпадение для этого хеша, то затем он проверяет, действительно ли совпадают ключи соединения 
между строкой в хеш-таблице и строкой из второй таблицы (ему необходимо выполнить эту 
проверку из-за потенциальных хеш-коллизий).
Стоит отметить, что иногда могут возникать ситуации, когда на этапе 
«Build» хеш-таблица не может быть сохранена полностью в памяти. 
В таких случаях SQL Server сохраняет некоторую часть данных в памяти, 
а остальную часть перенаправляет в tempdb.
