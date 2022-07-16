# Task 2

```sql
CREATE TABLE t2 AS
    SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
        FROM dual
        CONNECT BY rownum < 100000;

CREATE INDEX t2_ind_id ON t2 (id);

CREATE TABLE t1 AS
    SELECT MOD( rownum, 100 ) id, rpad( rownum,100 ) t_pad
        FROM dual
        CONNECT BY rownum < 100000;
        
CREATE INDEX t1_idx1 ON t1 ( id );
 
exec dbms_stats.gather_table_stats(user, 't1', method_opt=>'for all columns size 1', cascade=>true);

exec dbms_stats.gather_table_stats(user, 't2', method_opt=>'for all columns size 1', cascade=>true);


select 
    t.table_name||'.'||i.index_name idx_name,
    i.clustering_factor,
    t.blocks,
    t.num_rows
        from user_indexes i, user_tables t
            where i.table_name=t.table_name
                and t.table_name in ('T1', 'T2');



--IDX_NAME    |CLUSTERING_FACTOR|BLOCKS|NUM_ROWS|
--------------+-----------------+------+--------+
--T1.T1_IDX1  |            37200|   381|   99999|
--T2.T2_IND_ID|              378|   386|   99999|
```

Вывод:
Данная задача показывает работу индексов и важности их упорядочивания.

Параметр CLUSTERING_FACTOR показывает как расположены строки в blocks в соотверствии с упорядочиванием 
их индексов. Чем ближе число CLUSTERING_FACTOR к num blocks тем лучше, и чем ближе к num rows - тем хуже.

Рассмотрим на данном примере двух таблиц.
Индекс строк T2 формировался в соотверствии с функцией TRUNC( rownum / 100 ), это значит что строки 
ложились в blocks по порядку 0/0/0....0/0/0/1/1/1...1/1/1..   ..99998/99998...99998/99998/99999/99999...99999./99999
и индексы записывались в blocks по порядку, и для чтения по одному индексу необходимо произвести мин. blocks.
Индекс строк T1 формировался в соотверствии с функцией MOD( rownum / 100 ), это значит что строки 
ложились в blocks по порядку 0/1/2....97/98/99/0/1/2....97/98/99..   ..0/1/2....97/98/99/0/1/2....97/98/99,
 т.е. не по порядку, и для чтения по одному индексу необходимо произвести чтение N blocks, 
 по всему сегменту.

