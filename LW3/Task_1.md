# Task 1

```sql

CREATE TABLE t ( 
	a int, 
    b varchar2(4000) default rpad('*',4000,'*'), 
    c varchar2(3000) default rpad('*',3000,'*') 
   );
commit; 
  
INSERT INTO t (a) VALUES (1);
INSERT INTO t (a) VALUES (2);
INSERT INTO t (a) VALUES (3);
commit; 

DELETE FROM t WHERE a = 2 ; 
commit; 

insert into t (a) values (4); 
commit; 

SELECT a FROM t;

--|A  |
--|---|
--|1  |
--|3  |
--|4  |

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block FROM t ;

--|NUM_BLOCK|
--|---------|
--|2,523    |
--|2,523    |
--|2,523    |

DROP TABLE t;
commit; 
```
В результате данного эксперимента видно, что БД Oracle использует один и тот же Block. 
Расчитать логику данных действий не сложно. int(4b) + 7k * char(1b) = 7004 b. Записей 3, 
3 * 7004 ~ 21 kb. Размер block равен 32kb. 21 < 32. 21 / 32 ~ 65 %. Порог в 10% не преодолен, значит 
новые записи будут записываться в данный блок.

```sql
CREATE TABLE t ( 
	a int, 
    b varchar2(4000) default rpad('*',4000,'*'), 
    c varchar2(4000) default rpad('*',4000,'*') 
   );
commit; 
  
INSERT INTO t (a) VALUES (1);
INSERT INTO t (a) VALUES (2);
INSERT INTO t (a) VALUES (3);
commit; 

DELETE FROM t WHERE a = 2 ; 
commit; 

insert into t (a) values (4); 
commit; 

SELECT a FROM t;

--|A  |
--|---|
--|1  |
--|4  |
--|3  |

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block FROM t ;

--|NUM_BLOCK|
--|---------|
--|2,529    |
--|2,529    |
--|2,529    |

DROP TABLE t;
commit; 
```
Теперь повторим эксперимент, немного изменив размер строки в таблице t. 
Опять расчитаем занимаемый объем block: int(4b) + 8k * char(1b) = 8004 b. Записей 3, 
3 * 7004 ~ 24 kb. Размер block равен 32kb. 24 < 32. 24 / 32 ~ 75 %. Порог в 10% не преодолен, значит 
новые записи будут записываться в данный блок. Но при записи строки могут ложиться в block по разному.
Теперь выйдем за рамки block.

```sql
CREATE TABLE t ( 
	a int, 
    b varchar2(2000) default rpad('*',2000,'*'), 
    c varchar2(880) default rpad('*',880,'*')
   );
commit; 
  
INSERT INTO t (a) VALUES (1);
INSERT INTO t (a) VALUES (2);
INSERT INTO t (a) VALUES (3);
insert into t (a) values (4); 
insert into t (a) values (5); 
insert into t (a) values (6); 
insert into t (a) values (7); 
insert into t (a) values (8); 
insert into t (a) values (9); 
insert into t (a) values (10);
insert into t (a) values (11); 
commit; 

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block, a FROM t ;

--|NUM_BLOCK|A |
--|---------|--|
--|41       |11|
--|43       |1 |
--|43       |2 |
--|43       |3 |
--|43       |4 |
--|43       |5 |
--|43       |6 |
--|43       |7 |
--|43       |8 |
--|43       |9 |
--|43       |10|
```
Добавив строку со значением 10 свободное пространство block num 43 стало меньше 10 %. 
И при добавлении строки 11, запись производилась в новый block num 41.

```sql
DELETE FROM t WHERE a = 2 ; 
commit; 

insert into t (a) values (12); 
commit;


SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block, a FROM t ;

--NUM_BLOCK|A |
-----------+--+
--       41|11|
--       41|12|
--       43| 1|
--       43| 3|
--       43| 4|
--       43| 5|
--       43| 6|
--       43| 7|
--       43| 8|
--       43| 9|
--       43|10|
```
Затем удалим строку 2 и добавим новое значение 12.
Видно, что новое значение добавлено в block 41, 
т.к. порог занятого пространства ниже 40 % первого блока
не достигнут. Попробуем преодолеть его...

```sql

DELETE FROM t WHERE a > 2 and a < 11 ; 
commit; 

insert into t (a) values (13); 
commit;

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block, a FROM t ;

--NUM_BLOCK|A |
-----------+--+
--       41|11|
--       41|12|
--       43| 1|
--       43|13|

DROP TABLE t;
commit;
```
Как видно, из вывода последнего select мы достигли порога ниже 40 % занимаемого пространства первого
block num 43, эти перевели его в состояние как готового для записи.

Вывод:
Наглядно увидели организацию работы по заполнинею наименьшего элемента block пространства памяти БД Oracle. 
