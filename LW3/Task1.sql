
DROP TABLE t IF EXISTS;
commit; 

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

/*
A
----------
1
3
4
*/

DROP TABLE t;
commit;
