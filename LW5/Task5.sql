EXPLAIN PLAN FOR
SELECT*
    FROM EMP e, DEPT d;

SELECT * FROM table (DBMS_XPLAN.DISPLAY);