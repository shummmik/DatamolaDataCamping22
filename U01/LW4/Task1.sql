CREATE TABLE t2 AS
    SELECT 
        TRUNC( rownum / 100 ) id, 
        rpad(rownum, 100 ) t_pad
    FROM dual
        CONNECT BY rownum < 100000;

CREATE INDEX t2_ind_id ON t2 (id);

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;

SET autotrace ON
SELECT COUNT( * )
   FROM t2 ;

delete from t2;

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;

set autotrace on
SELECT COUNT( * )
   FROM t2 ;
 
INSERT INTO t2
  ( ID, T_PAD )
  VALUES
  ( 1, '1' );
COMMIT;

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;

SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
   
TRUNCATE TABLE t2;

SELECT blocks 
    from user_segments 
        where segment_name = 'T2';

SELECT count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct 
    from t2;

SET autotrace ON
SELECT COUNT( * )
   FROM t2 ;				

drop table t2;

--