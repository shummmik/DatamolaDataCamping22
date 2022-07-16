# Task 1

```sql
CREATE TABLE t2 AS
    SELECT 
        TRUNC( rownum / 100 ) id, 
        rpad(rownum, 100 ) t_pad
    FROM dual
        CONNECT BY rownum < 100000;

CREATE INDEX t2_ind_id ON t2 (id);

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

--|BLOCKS|
--|------|
--|416   |

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;
    
--|BLOCK_CT|
--|--------|
--|376     |

SET autotrace ON
SELECT COUNT( * )
   FROM t2 ;

--Statistics
-------------------------------------------------------------
--               2  CPU used by this session
--               2  CPU used when call started
--               1  DB time
--              32  Requests to/from client
--              33  SQL*Net roundtrips to/from client
--               2  buffer is not pinned count
--             512  bytes received via SQL*Net from client
--           60426  bytes sent via SQL*Net to client
--               3  calls to get snapshot scn: kcmgss
--               6  calls to kcmgcs
--             380  consistent gets
--             380  consistent gets from cache
--             380  consistent gets pin
--             380  consistent gets pin (fastpath)
--               1  enqueue releases
--               1  enqueue requests
--               2  execute count
--        12451840  logical read bytes from cache
--             376  no work - consistent read gets
--              38  non-idle wait count
--               2  opened cursors cumulative
--               2  opened cursors current
--               1  parse count (hard)
--               2  parse count (total)
--               1  process last non-idle time
--               1  recursive calls
--             380  session logical reads
--               1  sorts (memory)
--            1581  sorts (rows)
--             376  table scan blocks gotten
--           99999  table scan disk non-IMC rows gotten
--           99999  table scan rows gotten
--               1  table scans (short tables)
--              33  user calls

delete from t2;

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

--|BLOCKS|
--|------|
--|416   |

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;
    
--|BLOCK_CT|
--|--------|
--|0       |

set autotrace on
SELECT COUNT( * )
   FROM t2 ;
   
--Statistics
-------------------------------------------------------------
--               1  CPU used by this session
--               1  CPU used when call started
--               5  Requests to/from client
--               5  non-idle wait count
--               1  opened cursors cumulative
--              -1  opened cursors current
--               1  pinned cursors current
--               6  user calls

set autotrace on
INSERT INTO t2
  ( ID, T_PAD )
  VALUES ( 1, '1' );
COMMIT;

set autotrace on
SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

--|BLOCKS|
--|------|
--|416   |

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;
    
--|BLOCK_CT|
--|--------|
--|1       |

SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
   
--Statistics
-------------------------------------------------------------
--               1  DB time
--               6  Requests to/from client
--             380  consistent gets
--             380  consistent gets from cache
--             380  consistent gets pin
--             380  consistent gets pin (fastpath)
--               6  non-idle wait count
--               2  opened cursors cumulative
--               1  opened cursors current
--             380  session logical reads
--               8  user calls

TRUNCATE TABLE t2;

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

--|BLOCKS|
--|------|
--|6     |

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;
    
--|BLOCK_CT|
--|--------|
--|0       |

SET autotrace ON
SELECT COUNT( * )
   FROM t2 ;
   
Statistics
-------------------------------------------------------------
--               1  DB time
--               5  Requests to/from client
--               4  consistent gets
--               1  consistent gets examination
--               1  consistent gets examination (fastpath)
--               4  consistent gets from cache
--               3  consistent gets pin
--               3  consistent gets pin (fastpath)
--               1  enqueue releases
--               1  enqueue requests
--               7  non-idle wait count
--               2  opened cursors cumulative
--               2  opened cursors current
--               1  pinned cursors current
--               1  recursive calls
--               4  session logical reads
--               6  user calls

drop table t2;
```

| № | Count of Blocks | Count of Used Blocks | Count of Rows | Consistent gets | Description    |
| - | --------------- | -------------------- | ------------- | --------------- | -------------- |
|   | 416             | 376                  | 99999         | 380             | Select (all)   |
|   | 416             | 0                    | 0             | 380             | After delete   |
|   | 416             | 1                    | 1             | 380             | After insert   |
|   | 6               | 0                    | 0             | 4               | After trancate |

Вывод:
Данная задача показывает работу БД с block в разных вариациях выполнения действий над таблице. 
При создании таблицы для области ее сегмента выделили N blocks. При заполнении которых система выделит 
партицию bloks для пользования. 


В нашем примере после создания и добавления данных для таблицы выделено 416 blocks, из них 376 используются,
прочитано 380.

Затем удалим все данные. Количество выделеных блоков не изменилось, зато количество используемых стало 0.
Но количество прочтенных блоков не изменилось.

Добавим запись. На это пошел 1 block. Но количество прочтенных блоков также не изменилось.
Это отображает тот факт, что при удалнии записей ниже установленного порога в block, он переходит в 
состояние готовности записи и используются таблицей.

Но выполнив trancate table произойдет удаление записей не на уровне строк, а на уровне block. 
Они все будут удалены. И занового выделится дефолтный начальный сегмент. А 4 blocks как после trancate, так и 
в начале 380 - 376, послесоздания таблицы, это служебные blocks таблицы.
