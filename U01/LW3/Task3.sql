CREATE TABLE emp AS
SELECT
  object_id empno
, object_name ename
, created hiredate
, owner job
FROM
  all_objects;
commit; 

ALTER  TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (empno);
commit;

exec  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );

CREATE TABLE heap_addresses (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno, addr_type)
  );
COMMIT;

CREATE TABLE iot_addresses (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno,addr_type)
  )
  ORGANIZATION INDEX;
COMMIT;

SELECT segment_name, segment_type FROM user_segments;

INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

COMMIT;

exec dbms_stats.gather_table_stats('AShumilov', 'heap_addresses');
exec dbms_stats.gather_table_stats('AShumilov', 'iot_addresses');

SELECT segment_name, segment_type FROM user_segments; 

SET LINESIZE 130;

EXPLAIN PLAN FOR
SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno = 42;

SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));
 
EXPLAIN PLAN FOR
 SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno = 42;
 
SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

DROP TABLE heap_addresses;
DROP TABLE iot_addresses;
DROP TABLE emp;
commit;