EXPLAIN PLAN FOR
SELECT *
    FROM EMP e
    FULL OUTER JOIN 
    DEPT d
        on e.deptno = d.deptno;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);