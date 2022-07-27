### Task1

```SQL
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

```