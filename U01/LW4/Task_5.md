# Task 5

```sql
create table employees (  
  empno    number(4,0),  
  ename    varchar2(10),  
  job      varchar2(9),  
  mgr      number(4,0),  
  hiredate date,  
  sal      number(7,2),  
  comm     number(7,2),  
  deptno   number(2,0),  
  constraint pk_emp primary key (empno)
);
commit;
 
ALTER session set NLS_DATE_FORMAT='DD-MM-YYYY'; 

INSERT INTO employees  VALUES (7839, 'KING',   'PRESIDENT', null, '17-11-1981',     5000, null, 10);
INSERT INTO employees  VALUES (7698, 'BLAKE',  'MANAGER',   7839, '01-05-1981',     2850, null, 30);
INSERT INTO employees  VALUES (7782, 'CLARK',  'MANAGER',   7839, '09-06-1981',     2450, null, 10);
INSERT INTO employees  VALUES (7566, 'JONES',  'MANAGER',   7839, '02-04-1981',     2975, null, 20);
INSERT INTO employees  VALUES (7788, 'SCOTT',  'ANALYST',   7566, '19-04-1987',     3000, null, 20);
INSERT INTO employees  VALUES (7902, 'FORD',   'ANALYST',   7566, '03-12-1981',     3000, null, 20);
INSERT INTO employees  VALUES (7369, 'SMITH',  'CLERK',     7902, '17-12-1980',      800, null, 20);
INSERT INTO employees  VALUES (7499, 'ALLEN',  'SALESMAN',  7698, '20-02-1981',     1600,  300, 30);
INSERT INTO employees  VALUES (7521, 'WARD',   'SALESMAN',  7698, '22-02-1981',     1250,  500, 30);
INSERT INTO employees  VALUES (7654, 'MARTIN', 'SALESMAN',  7698, '28-09-1981',     1250, 1400, 30);
INSERT INTO employees  VALUES (7844, 'TURNER', 'SALESMAN',  7698, '08-09-1981',     1500,    0, 30);
INSERT INTO employees  VALUES (7876, 'ADAMS',  'CLERK',     7788, '23-05-1987',     1100, null, 20);
INSERT INTO employees  VALUES (7900, 'JAMES',  'CLERK',     7698, '03-12-1981',      950, null, 30);
INSERT INTO employees  VALUES (7934, 'MILLER', 'CLERK',     7782, '23-01-1982',     1300, null, 10);
commit;


CREATE INDEX idx_emp01 ON employees
      ( empno, ename, job );

SELECT blocks 
    from user_segments 
        where segment_name = 'EMPLOYEES';

--|BLOCKS|
--|------|
--|6     |

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from employees;  

--|BLOCK_CT|
--|--------|
--|1       |  

set autotrace on;
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM employees emp where ename = 'SCOTT';

--EMPNO|ENAME|JOB    |MGR |HIREDATE               |SAL |COMM|DEPTNO|
-------+-----+-------+----+-----------------------+----+----+------+
-- 7788|SCOTT|ANALYST|7566|1987-04-19 00:00:00.000|3000|    |    20|

/*
------------------------------------------------------------------
| Id  | Operation                           | Name      | E-Rows |
------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |           |        |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES |      1 |
|*  2 |   INDEX SKIP SCAN                   | IDX_EMP01 |      1 |
------------------------------------------------------------------

Statistics
-----------------------------------------------------------
               1  CPU used by this session
               1  CPU used when call started
               1  DB time
              32  Requests to/from client
              33  SQL*Net roundtrips to/from client
               4  buffer is not pinned count
             566  bytes received via SQL*Net from client
           60937  bytes sent via SQL*Net to client
               7  calls to get snapshot scn: kcmgss
               7  calls to kcmgcs
              10  consistent gets
              10  consistent gets from cache
              10  consistent gets pin
              10  consistent gets pin (fastpath)
               3  enqueue releases
               3  enqueue requests
               3  execute count
          327680  logical read bytes from cache
               5  no work - consistent read gets
              33  non-idle wait count
               3  opened cursors cumulative
               2  opened cursors current
               2  parse count (hard)
               3  parse count (total)
               2  parse time cpu
               1  process last non-idle time
               5  recursive calls
               1  recursive cpu usage
               1  session cursor cache hits
              10  session logical reads
               1  sorts (memory)
            1581  sorts (rows)
               1  table fetch by rowid
               3  table scan blocks gotten
              14  table scan disk non-IMC rows gotten
              14  table scan rows gotten
               1  table scans (short tables)
              33  user calls
*/

set autotrace on  
SELECT emp.* FROM employees emp WHERE ename = 'SCOTT';


--EMPNO|ENAME|JOB    |MGR |HIREDATE               |SAL |COMM|DEPTNO|
-------+-----+-------+----+-----------------------+----+----+------+
-- 7788|SCOTT|ANALYST|7566|1987-04-19 00:00:00.000|3000|    |    20|
/*
------------------------------------------------
| Id  | Operation         | Name      | E-Rows |
------------------------------------------------
|   0 | SELECT STATEMENT  |           |        |
|*  1 |  TABLE ACCESS FULL| EMPLOYEES |      1 |

Statistics
-----------------------------------------------------------
               2  DB time
              32  Requests to/from client
              33  SQL*Net roundtrips to/from client
               2  buffer is not pinned count
             547  bytes received via SQL*Net from client
           60937  bytes sent via SQL*Net to client
               2  calls to get snapshot scn: kcmgss
               4  calls to kcmgcs
               5  consistent gets
               5  consistent gets from cache
               5  consistent gets pin
               5  consistent gets pin (fastpath)
               2  execute count
          163840  logical read bytes from cache
               3  no work - consistent read gets
              33  non-idle wait count
               2  opened cursors cumulative
               2  opened cursors current
               2  parse count (total)
               2  session cursor cache hits
               5  session logical reads
               1  sorts (memory)
            1581  sorts (rows)
               3  table scan blocks gotten
              14  table scan disk non-IMC rows gotten
              14  table scan rows gotten
               1  table scans (short tables)
              33  user calls

*/


```

Вывод:
Данная задача показывает работу индекса Index Skip Scan и Table Access Full.
Т.к. набор данных очень мал, данные расположены в одном block, 
то для направления работы оптимизатора использовали подсказки параметра инициализации .
В первом примере использован INDEX SKIP SCAN. Этот метод доступа используется в случае,
если в предикате where не используется первый столбец индекса.
Во втором примере использован TABLE FULL SCAN. Данный метод доступа, подразумевает перебор всех 
строк таблицы с исключением тех, которые не удовлетворяют предикату where.
Под данный запрос отлично вписывается INDEX SKIP SCAN потому что есть составной 
индекс и не используется первый столбец индекса. Происходит чтение индексов, а затем таблицы.
Но на данный момент у нас мало данных, они все храняться в одном block. Оптимизатор решает просто 
пройтись по данным, что выгоднее INDEX SKIP SCAN, т.к. нет операции чтения индексов. В этом можно убедиться 
из таблицы ниже, параметр Consistent getsю




| № | Count of Blocks | Count of Used Blocks | Count of Rows | Consistent gets | Description       |
| - | --------------- | -------------------- | ------------- | --------------- | ----------------- |
|   | 384             | 372                  | 99999         | 3               | Index Unique Scan |
|   | 416             | 376                  | 99999         | 3               | Index Range Scan  |
|   | 6               | 1                    | 14            | 10              | Index Skip Scan   |
|   | 6               | 1                    | 14            | 5               | Table Access Full |