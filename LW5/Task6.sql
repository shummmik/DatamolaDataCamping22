EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    LEFT OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    RIGHT OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);
