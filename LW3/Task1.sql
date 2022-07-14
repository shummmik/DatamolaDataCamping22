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

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block FROM t ;

DROP TABLE t;
commit; 

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

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block FROM t ;

DROP TABLE t;
commit; 

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

DELETE FROM t WHERE a = 2 ; 
commit; 

insert into t (a) values (12); 
commit;

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block, a FROM t ;

DELETE FROM t WHERE a > 2 and a < 11 ; 
commit; 

insert into t (a) values (13); 
commit;

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) num_block, a FROM t ;

DROP TABLE t;
commit;
