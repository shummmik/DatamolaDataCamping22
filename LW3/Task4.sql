CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );

CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;
commit;

CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )
  , loc    VARCHAR2( 13 )
  )
  cluster emp_dept_cluster ( deptno ) ;
 
 CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )
  , job   VARCHAR2( 9 )
  , mgr   NUMBER
  , hiredate DATE
  , sal    NUMBER
  , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster emp_dept_cluster ( deptno ) ;
commit;

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');
 
ALTER session set NLS_DATE_FORMAT='DD-MM-YYYY'; 

INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT', null, '17-11-1981',     5000, null, 10);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',   7839, '01-05-1981',     2850, null, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',   7839, '09-06-1981',     2450, null, 10);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',   7839, '02-04-1981',     2975, null, 20);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',   7566, '19-04-1987',     3000, null, 20);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',   7566, '03-12-1981',     3000, null, 20);
INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',     7902, '17-12-1980',     800, null, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN',  7698, '20-02-1981',     1600,  300, 30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN',  7698, '22-02-1981',     1250,  500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN',  7698, '28-09-1981',     1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN',  7698, '08-09-1981',     1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',     7788, '23-05-1987',     1100, null, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',     7698, '03-12-1981',     950, null, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',     7782, '23-01-1982',     1300, null, 10);
commit;


EXPLAIN PLAN FOR
SELECT *
   FROM
  (
     SELECT dept_blk, 
            emp_blk, 
            CASE 
			 WHEN dept_blk <> emp_blk THEN '*' 
		    END flag,
		    deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

/*
Plan hash value: 735046682
 
-----------------------------------------------------------------------------------
| Id  | Operation           | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |             |    14 |   700 |     5  (20)| 00:00:01 |
|   1 |  SORT ORDER BY      |             |    14 |   700 |     5  (20)| 00:00:01 |
|   2 |   NESTED LOOPS      |             |    14 |   700 |     4   (0)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| EMP         |    14 |   350 |     4   (0)| 00:00:01 |
|*  4 |    INDEX UNIQUE SCAN| SYS_C007084 |     1 |    25 |     0   (0)| 00:00:01 |
-----------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$5C160134
   3 - SEL$5C160134 / "EMP"@"SEL$3"
   4 - SEL$5C160134 / "DEPT"@"SEL$3"
 
Outline Data
-------------
 
  /-*+
      BEGIN_OUTLINE_DATA
      USE_NL(@"SEL$5C160134" "DEPT"@"SEL$3")
      LEADING(@"SEL$5C160134" "EMP"@"SEL$3" "DEPT"@"SEL$3")
      INDEX(@"SEL$5C160134" "DEPT"@"SEL$3" ("DEPT"."DEPTNO"))
      FULL(@"SEL$5C160134" "EMP"@"SEL$3")
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$2")
      MERGE(@"SEL$3" >"SEL$2")
      OUTLINE(@"SEL$335DD26A")
      OUTLINE(@"SEL$1")
      MERGE(@"SEL$335DD26A" >"SEL$1")
      OUTLINE_LEAF(@"SEL$5C160134")
      ALL_ROWS
      DB_VERSION('21.1.0')
      OPTIMIZER_FEATURES_ENABLE('21.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  *-/
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=1) "DEPT"."DEPTNO"[NUMBER,22], 
       "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("DEPT".ROWID))[22], 
       "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("EMP".ROWID))[22], CASE  
       WHEN "DBMS_ROWID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("DEPT".ROWID))<>"DBMS_RO
       WID"."ROWID_BLOCK_NUMBER"(ROWIDTOCHAR("EMP".ROWID)) THEN '*' END [1]
   2 - (#keys=0) "EMP".ROWID[ROWID,10], "DEPT".ROWID[ROWID,10], 
       "DEPT"."DEPTNO"[NUMBER,22]
   3 - "EMP".ROWID[ROWID,10], "EMP"."DEPTNO"[NUMBER,22]
   4 - "DEPT".ROWID[ROWID,10], "DEPT"."DEPTNO"[NUMBER,22]
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
 
Query Block Registry:
---------------------
 
  SEL$1 (PARSER)
    SEL$5C160134 (VIEW MERGE SEL$1 ; SEL$335DD26A) [FINAL]
  SEL$2 (PARSER)
    SEL$335DD26A (VIEW MERGE SEL$2 ; SEL$3)
  SEL$3 (PARSER)
 
 */


DROP TABLE emp;
DROP TABLE DEPT;
DROP CLUSTER emp_dept_cluster;
commit;
