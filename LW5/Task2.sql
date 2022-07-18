
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

SELECT * 
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno
              and d.deptno = 10;
              
EXPLAIN PLAN FOR
SELECT * 
    FROM EMP e, DEPT d
        WHERE e.deptno = d.deptno
              and d.deptno = 10;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);
