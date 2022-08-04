# Task 2

```sql

CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME VARCHAR2(14) ,
    LOC VARCHAR2(13) ) ;

CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

ALTER session set NLS_DATE_FORMAT='DD-MM-YYYY'; 

INSERT INTO EMP VALUES (7839, 'KING',   'PRESIDENT', null, '17-11-1981',     5000, null, 10);
INSERT INTO EMP VALUES (7698, 'BLAKE',  'MANAGER',   7839, '01-05-1981',     2850, null, 30);
INSERT INTO EMP VALUES (7782, 'CLARK',  'MANAGER',   7839, '09-06-1981',     2450, null, 10);
INSERT INTO EMP VALUES (7566, 'JONES',  'MANAGER',   7839, '02-04-1981',     2975, null, 20);
INSERT INTO EMP VALUES (7788, 'SCOTT',  'ANALYST',   7566, '19-04-1987',     3000, null, 20);
INSERT INTO EMP VALUES (7902, 'FORD',   'ANALYST',   7566, '03-12-1981',     3000, null, 20);
INSERT INTO EMP VALUES (7369, 'SMITH',  'CLERK',     7902, '17-12-1980',     800, null, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN',  'SALESMAN',  7698, '20-02-1981',     1600,  300, 30);
INSERT INTO EMP VALUES (7521, 'WARD',   'SALESMAN',  7698, '22-02-1981',     1250,  500, 30);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN',  7698, '28-09-1981',     1250, 1400, 30);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN',  7698, '08-09-1981',     1500,    0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS',  'CLERK',     7788, '23-05-1987',     1100, null, 20);
INSERT INTO EMP VALUES (7900, 'JAMES',  'CLERK',     7698, '03-12-1981',     950, null, 30);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK',     7782, '23-01-1982',     1300, null, 10);

COMMIT;

```
Подготовлены таблицы для выполнения лабораторной работы.

```sql
SELECT * 
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno
              and d.deptno = 10;
              
--EMPNO|ENAME |JOB      |MGR |HIREDATE               |SAL |COMM|DEPTNO|DEPTNO|DNAME     |LOC     |
-------+------+---------+----+-----------------------+----+----+------+------+----------+--------+
-- 7782|CLARK |MANAGER  |7839|1981-06-09 00:00:00.000|2450|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7934|MILLER|CLERK    |7782|1982-01-23 00:00:00.000|1300|    |    10|    10|ACCOUNTING|NEW YORK|
-- 7839|KING  |PRESIDENT|    |1981-11-17 00:00:00.000|5000|    |    10|    10|ACCOUNTING|NEW YORK|
EXPLAIN PLAN FOR
SELECT * 
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno
              and d.deptno = 10;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

------------------------------------------------------------------------------------------
--| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT             |         |     1 |   107 |     5   (0)| 00:00:01 |
--|   1 |  NESTED LOOPS                |         |     1 |   107 |     5   (0)| 00:00:01 |
--|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     1 |    20 |     1   (0)| 00:00:01 |
--|*  3 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
--|*  4 |   TABLE ACCESS FULL          | EMP     |     1 |    87 |     4   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   3 - access("D"."DEPTNO"=10)
--   4 - filter("E"."DEPTNO"=10)
```

Nested Loops Join работает следуюшим образом: БД берет первое значение из первой таблицы
  и сравнивает его с каждым значением во второй "внутренней" таблице в поисках совпадения. 
  Данный тип соединения таблиц обычно используется, когда мы соединяем наборы 
  данных, где один из наборов имеет небольшой размер, а другой набор данных сравнительно 
  большой и индексирован по соединяемым столбцам. Nested Loops самой быстрой операцией соединения
  на небольшом объеме данных.