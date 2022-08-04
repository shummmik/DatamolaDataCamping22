



create table PART_EXAMPLE 
(
   ID_EVENT             numeric                        not null,
   DESCRIPTION          varchar(25)                    not null,
   "USER"               varchar(15)                    not null,
   CREATE_DTM           timestamp                      not null,
   constraint PK_PART_EXAMPLE primary key (ID_EVENT)
)

partition by range (CREATE_DTM)
    ( partition events_2021_01 values less than (to_date('01-02-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_02 values less than (to_date('01-03-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_03 values less than (to_date('01-04-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_04 values less than (to_date('01-05-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_05 values less than (to_date('01-06-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_06 values less than (to_date('01-07-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_07 values less than (to_date('01-08-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_08 values less than (to_date('01-09-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_09 values less than (to_date('01-10-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_10 values less than (to_date('01-11-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_11 values less than (to_date('01-12-2021', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2021_12 values less than (to_date('01-01-2022', 'DD-MM-YYYY')) tablespace ts_data
    , partition events_2022_01 values less than (to_date('01-02-2022', 'DD-MM-YYYY')) tablespace ts_data
);


--Table PART_EXAMPLE created.


ALTER TABLE PART_EXAMPLE DROP PARTITION events_2022_01;

--Table PART_EXAMPLE altered.


ALTER TABLE PART_EXAMPLE 

MERGE PARTITIONS events_2021_01, events_2021_02, events_2021_03 INTO PARTITION quarter_01

UPDATE INDEXES;

--Table PART_EXAMPLE altered.

CREATE TABLESPACE to_move
DATAFILE '/oracle/u02/oradata/AShumilovdb/move_data.dat'
SIZE 100M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

--TABLESPACE TO_MOVE created.


ALTER TABLE PART_EXAMPLE MOVE PARTITION events_2021_12

     TABLESPACE to_move NOLOGGING COMPRESS;
     
--Table PART_EXAMPLE altered.

ALTER TABLE PART_EXAMPLE
  SPLIT PARTITION quarter_01 AT (TO_DATE('31-01-2021 23:59:59', 'DD-MM-YYYY HH24:MI:SS'))
  INTO (PARTITION events_2021_01,
        PARTITION events_2021_02_03);

--Table PART_EXAMPLE altered.


ALTER TABLE PART_EXAMPLE TRUNCATE PARTITION events_2021_08;

--Table PART_EXAMPLE truncated.




ALTER TABLE T_BETS_F MODIFY
  PARTITION BY HASH (ID_USER)
  SUBPARTITION BY HASH (ID_AUCTION)
  ( PARTITION P1 SUBPARTITION P1S1 SUBPARTITION P1S2 SUBPARTITION P1S3,
    PARTITION P2 SUBPARTITION P2S1 SUBPARTITION P2S2 SUBPARTITION P2S3,
    PARTITION P3 SUBPARTITION P3S1 SUBPARTITION P3S2 SUBPARTITION P3S3,
    PARTITION P4 SUBPARTITION P4S1 SUBPARTITION P4S2 SUBPARTITION P4S3
   );
   
ALTER TABLE T_SUBSCRIPTIONS_USER_F MODIFY
  PARTITION BY HASH (START_DTM)
  ( PARTITION START_2021 values less than (to_date('01-01-2022', 'DD-MM-YYYY'),
    PARTITION START_2023 values less than (to_date('01-01-2023', 'DD-MM-YYYY')
   );

set autotrace on;
   
EXEC u_dw_ext_references.pkg_load_t_time.generate_T_CALENDAR('12/31/1982', 'MM/DD/YYYY', 80000, 'UNITED KINGDOM');

set autotrace on
select count(*) from U_DW_EXT_REFERENCES.CLS_CALENDAR;

EXPLAIN PLAN FOR
select * from tmp;






select plan_table_output from table(dbms_xplan.display('plan_table'));



select * from tmp;	1354191	1400798



--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |   111K|   267M|  2381   (1)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| TMP  |   111K|   267M|  2381   (1)| 00:00:01 |
--------------------------------------------------------------------------

EXPLAIN PLAN FOR
select /*+ PARALLEL(5) */ * from tmp;


SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));


694915	747732


--------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
--------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |          |   111K|   267M|   529   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |          |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000 |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |          |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | PCWC |            |
|   4 |     TABLE ACCESS FULL| TMP      |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | PCWP |            |
--------------------------------------------------------------------------------------------------------------




EXPLAIN PLAN FOR
select /*+ PARALLEL(5) ENABLE_PARALLEL_DML */ * from tmp;


SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));
set feedback off
set serveroutput on
set autotrace on
select /*+ ENABLE_PARALLEL_DML */ * from tmp	7630	10710
--------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
--------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |          |   160K|    51M|   529   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |          |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000 |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |          |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWC |            |
|   4 |     TABLE ACCESS FULL| TMP      |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWP |            |
--------------------------------------------------------------------------------------------------------------




alter session enable parallel dml;


EXPLAIN PLAN FOR
select /*+ PARALLEL(5) */ * from tmp;


SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

SELECT *
FROM V$SQL;




SELECT sql_text, CPU_TIME, ELAPSED_TIME
FROM V$SQL VS , ALL_USERS AU
WHERE (executions >= 1)
AND (parsing_user_id != 0)
AND (AU.user_id(+) = VS.parsing_user_id)
AND UPPER(AU.USERNAME)  IN (UPPER('ASHUMILOV'))
ORDER BY last_active_time DESC;

 insert into  tmp (FILE_NAME, FILE_CONTENT) SELECt * FROM ext_files where ROWNUM < 2 ;

CREATE TABLE tmp (
    ID_T NUMBER GENERATED BY DEFAULT AS IDENTITY, 
    FILE_NAME VARCHAR2(1000  BYTE), 
    FILE_CONTENT BLOB,
    PRIMARY KEY (ID_T)
);


declare
num_value NUMBER ;
BEGIN
     FOR i IN 1..80000 LOOP
        num_value   := DBMS_Random.Value(1,8);
        insert into tmp (FILE_NAME, FILE_CONTENT) SELECT  * FROM ext_files where ROWNUM < (num_value+1) OFFSET (num_value-1) ROWS;
        commit;
    END LOOP;
END;


EXPLAIN PLAN FOR
CREATE TABLE tmp1 parallel 8 as select * from tmp;

25600698	70626784



SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));


 
----------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                          | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
----------------------------------------------------------------------------------------------------------------------------
|   0 | CREATE TABLE STATEMENT             |          |   160K|    51M|   438   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                    |          |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)              | :TQ10000 |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    LOAD AS SELECT (HYBRID TSM/HWMB)| TMP1     |       |       |            |          |  Q1,00 | PCWP |            |
|   4 |     OPTIMIZER STATISTICS GATHERING |          |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWP |            |
|   5 |      PX BLOCK ITERATOR             |          |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|   6 |       TABLE ACCESS FULL            | TMP      |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWP |            |
----------------------------------------------------------------------------------------------------------------------------


EXPLAIN PLAN FOR
CREATE TABLE tmp1 as select * from tmp;

26100362	49931137



SELECT * FROM table (DBMS_XPLAN.DISPLAY(format => 'ADVANCED'));

Plan hash value: 2438530547
 
-----------------------------------------------------------------------------------------
| Id  | Operation                        | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------
|   0 | CREATE TABLE STATEMENT           |      |   160K|    51M|  3242   (1)| 00:00:01 |
|   1 |  LOAD AS SELECT                  | TMP1 |       |       |            |          |
|   2 |   OPTIMIZER STATISTICS GATHERING |      |   160K|    51M|  2381   (1)| 00:00:01 |
|   3 |    TABLE ACCESS FULL             | TMP  |   160K|    51M|  2381   (1)| 00:00:01 |
-----------------------------------------------------------------------------------------


SELECT * FROM EXT_FILES;
--
--FILE_NAME                      |FILE_CONTENT|
---------------------------------+------------+
--iso_3166_2.tab                 |[BLOB]      |
--iso-639-3-Macro.tab            |[BLOB]      |
--iso-639-3.tab                  |[BLOB]      |
--iso_3166.tab                   |[BLOB]      |
--iso_3166_geo_un.tab            |[BLOB]      |
--iso_3166_geo_un_contries.tab   |[BLOB]      |
--iso_3166_groups_un.tab         |[BLOB]      |
--iso_3166_groups_un_contries.tab|[BLOB]      |

CREATE TABLE tmp (
    ID_T NUMBER GENERATED BY DEFAULT AS IDENTITY, 
    FILE_NAME VARCHAR2(1000  BYTE), 
    FILE_CONTENT BLOB,
    PRIMARY KEY (ID_T)
);


declare
num_value NUMBER ;
BEGIN
     FOR i IN 1..80000 LOOP
        num_value   := DBMS_Random.Value(1,8);
        insert into tmp (FILE_NAME, FILE_CONTENT) SELECT  * FROM ext_files where ROWNUM < (num_value+1) OFFSET (num_value-1) ROWS;
        commit;
    END LOOP;
END;

set timing on
select * from tmp;	
Elapsed: 00:00:00.428
--------------------------
--|CPU_TIME| ELAPSED_TIME|
--------------------------
--|1354191 | 1400798     |
--------------------------
--
----------------------------------------------------------------------------
--| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |      |   111K|   267M|  2381   (1)| 00:00:01 |
--|   1 |  TABLE ACCESS FULL| TMP  |   111K|   267M|  2381   (1)| 00:00:01 |
----------------------------------------------------------------------------

set timing on
select /*+ PARALLEL(10) */ * from tmp;	

Elapsed: 00:00:00.409

--
----------------------------------------------------------------------------------------------------------------
--| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
----------------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT     |          |   111K|   267M|   529   (0)| 00:00:01 |        |      |            |
--|   1 |  PX COORDINATOR      |          |       |       |            |          |        |      |            |
--|   2 |   PX SEND QC (RANDOM)| :TQ10000 |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
--|   3 |    PX BLOCK ITERATOR |          |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | PCWC |            |
--|   4 |     TABLE ACCESS FULL| TMP      |   111K|   267M|   529   (0)| 00:00:01 |  Q1,00 | PCWP |            |
----------------------------------------------------------------------------------------------------------------


set timing on
select /*+ PARALLEL(10) ENABLE_PARALLEL_DML */ * from tmp;	
Elapsed: 00:00:00.396

--
----------------------------------------------------------------------------------------------------------------
--| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
----------------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT     |          |   160K|    51M|   529   (0)| 00:00:01 |        |      |            |
--|   1 |  PX COORDINATOR      |          |       |       |            |          |        |      |            |
--|   2 |   PX SEND QC (RANDOM)| :TQ10000 |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
--|   3 |    PX BLOCK ITERATOR |          |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWC |            |
--|   4 |     TABLE ACCESS FULL| TMP      |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWP |            |
----------------------------------------------------------------------------------------------------------------


CREATE TABLE tmp1 as select * from tmp;

--Elapsed: 00:00:33.354
--
-------------------------------------------------------------------------------------------
--| Id  | Operation                        | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------
--|   0 | CREATE TABLE STATEMENT           |      |   160K|    51M|  3242   (1)| 00:00:01 |
--|   1 |  LOAD AS SELECT                  | TMP1 |       |       |            |          |
--|   2 |   OPTIMIZER STATISTICS GATHERING |      |   160K|    51M|  2381   (1)| 00:00:01 |
--|   3 |    TABLE ACCESS FULL             | TMP  |   160K|    51M|  2381   (1)| 00:00:01 |
-------------------------------------------------------------------------------------------


CREATE TABLE tmp1 parallel 5 as select * from tmp;
--Elapsed: 00:00:09.863
-- 
------------------------------------------------------------------------------------------------------------------------------
--| Id  | Operation                          | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
------------------------------------------------------------------------------------------------------------------------------
--|   0 | CREATE TABLE STATEMENT             |          |   160K|    51M|   438   (0)| 00:00:01 |        |      |            |
--|   1 |  PX COORDINATOR                    |          |       |       |            |          |        |      |            |
--|   2 |   PX SEND QC (RANDOM)              | :TQ10000 |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
--|   3 |    LOAD AS SELECT (HYBRID TSM/HWMB)| TMP1     |       |       |            |          |  Q1,00 | PCWP |            |
--|   4 |     OPTIMIZER STATISTICS GATHERING |          |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWP |            |
--|   5 |      PX BLOCK ITERATOR             |          |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWC |            |
--|   6 |       TABLE ACCESS FULL            | TMP      |   160K|    51M|   331   (1)| 00:00:01 |  Q1,00 | PCWP |            |
------------------------------------------------------------------------------------------------------------------------------




INSERT INTO u_dw_ext_references.CLS_CALENDAR parallel 10
         SELECT 
          TRUNC( sd + rn ) time_id
          ,TO_CHAR( sd + rn, 'fmDay' ) day_name
          ,TO_CHAR( sd + rn, 'D' ) day_number_in_week
          ,TO_CHAR( sd + rn, 'DD' ) day_number_in_month
          ,TO_CHAR( sd + rn, 'DDD' ) day_number_in_year
          ,TO_CHAR( sd + rn, 'W' ) calendar_week_number_month
           ,TO_CHAR( sd + rn, 'WW' ) calendar_week_number
        --  ,TO_CHAR( sd + rn, 'IW' ) week_number_in_year_full  
          ,( CASE
              WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
                NEXT_DAY( sd + rn, 'Sunday' ) -- for USA Saturday
              ELSE
                ( sd + rn )
            END ) week_ending_date
          ,TO_CHAR( sd + rn, 'MM' ) calendar_month_number
          ,TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month
          ,LAST_DAY( sd + rn ) end_of_cal_month
          ,TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name
          ,( ( CASE
              WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
                TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
                TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
                TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
                TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter
          ,TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter
          ,( CASE
              WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
                TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
                TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
                TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
              WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
                TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            END ) end_of_cal_quarter
          ,TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number
          ,TO_CHAR( sd + rn, 'YYYY' ) calendar_year
          ,( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            - TRUNC( sd + rn, 'YEAR' ) +1 ) days_in_cal_year
          ,TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year
          ,TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
        FROM
          ( 
            SELECT 
              TO_DATE( '01/01/2000', 'MM/DD/YYYY' ) sd,
              rownum rn
            FROM dual
              CONNECT BY level <= 900
          );
          
          Elapsed: 00:00:00.328
          Elapsed: 00:00:00.045

  INSERT INTO u_dw_references.W_YEARS parallel 10 ( TIME_ID 
                                            ,CALENDAR_YEAR 
                                            ,DAYS_IN_CAL_YEAR
                                            ,BEG_OF_CAL_YEAR 
                                            ,END_OF_CAL_YEAR)
         SELECT  TIME_ID 
                ,CALENDAR_YEAR 
                ,DAYS_IN_CAL_YEAR
                ,BEG_OF_CAL_YEAR 
                ,END_OF_CAL_YEAR
           FROM u_dw_ext_references.CLS_CALENDAR;
           
           
           
           
true
TRUE