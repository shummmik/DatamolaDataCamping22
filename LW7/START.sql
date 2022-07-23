drop table u_dw_ext_references.CLS_CALENDAR cascade constraints;

  CREATE TABLE u_dw_ext_references.CLS_CALENDAR
   (	TIME_ID DATE, 
	DAY_NAME VARCHAR2(50), 
	DAY_NUMBER_IN_WEEK VARCHAR2(1), 
	DAY_NUMBER_IN_MONTH VARCHAR2(2), 
	DAY_NUMBER_IN_YEAR VARCHAR2(3), 
	CALENDAR_WEEK_NUMBER_MONTH VARCHAR2(1), 
	CALENDAR_WEEK_NUMBER VARCHAR2(2), 
--	WEEK_NUMBER_IN_YEAR_FULL VARCHAR2(2), 
	WEEK_ENDING_DATE DATE, 
	CALENDAR_MONTH_NUMBER VARCHAR2(2), 
	DAYS_IN_CAL_MONTH VARCHAR2(2), 
	END_OF_CAL_MONTH DATE, 
	CALENDAR_MONTH_NAME VARCHAR2(50), 
	DAYS_IN_CAL_QUARTER NUMBER, 
	BEG_OF_CAL_QUARTER DATE, 
	END_OF_CAL_QUARTER DATE, 
	CALENDAR_QUARTER_NUMBER VARCHAR2(1), 
	CALENDAR_YEAR VARCHAR2(5), 
	DAYS_IN_CAL_YEAR NUMBER, 
	BEG_OF_CAL_YEAR DATE, 
	END_OF_CAL_YEAR DATE
   ) 
  TABLESPACE TS_REFERENCES_EXT_DATA_01 ;
  
--------------------------------------------DAY
drop table u_dw_ext_references.T_DAYS cascade constraints;

CREATE TABLE u_dw_references.T_DAYS
(
    TIME_ID DATE, 
	DAY_NAME VARCHAR2(50), 
	DAY_NUMBER_IN_WEEK VARCHAR2(1), 
	DAY_NUMBER_IN_MONTH VARCHAR2(2), 
	DAY_NUMBER_IN_YEAR VARCHAR2(3), 
    constraint PK_T_DAYS primary key (TIME_ID)
)
organization index tablespace TS_REFERENCES_DATA_01;


create or replace view u_dw_references.W_DAYS as
SELECT 
    TIME_ID 
	,DAY_NAME 
	,DAY_NUMBER_IN_WEEK
	,DAY_NUMBER_IN_MONTH 
	,DAY_NUMBER_IN_YEAR
  FROM u_dw_references.T_DAYS;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.W_DAYS to u_dw_ext_references;


--------------------------------------------WEEK
drop table u_dw_references.T_WEEKS cascade constraints;

CREATE TABLE u_dw_references.T_WEEKS
(
    TIME_ID DATE, 
	CALENDAR_WEEK_NUMBER_MONTH VARCHAR2(1), 
	CALENDAR_WEEK_NUMBER VARCHAR2(2), 
--	WEEK_NUMBER_IN_YEAR_FULL VARCHAR2(2), 
    WEEK_NUMBER_IN_YEAR VARCHAR2(2), 
    WEEK_NUMBER_IN_MONTH VARCHAR2(1),
	WEEK_ENDING_DATE DATE,  
    constraint PK_T_WEEKS primary key (TIME_ID)
)
organization index tablespace TS_REFERENCES_DATA_01;


create or replace view u_dw_references.W_WEEKS as
SELECT 
    TIME_ID 
	,CALENDAR_WEEK_NUMBER_MONTH
	,CALENDAR_WEEK_NUMBER
--	,WEEK_NUMBER_IN_YEAR_FULL
    ,WEEK_NUMBER_IN_YEAR
    ,WEEK_NUMBER_IN_MONTH
	,WEEK_ENDING_DATE
  FROM u_dw_references.T_WEEKS;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.W_WEEKS to u_dw_ext_references;


--------------------------------------------MONTH
drop table u_dw_references.T_MONTHS cascade constraints;

CREATE TABLE u_dw_references.T_MONTHS
(
    TIME_ID DATE, 
	CALENDAR_MONTH_NUMBER VARCHAR2(2), 
	DAYS_IN_CAL_MONTH VARCHAR2(2), 
	END_OF_CAL_MONTH DATE, 
	CALENDAR_MONTH_NAME VARCHAR2(50), 
    constraint PK_T_MONTHS primary key (TIME_ID)
)
organization index tablespace TS_REFERENCES_DATA_01;


create or replace view u_dw_references.W_MONTHS as
SELECT 
    TIME_ID 
	,CALENDAR_MONTH_NUMBER 
	,DAYS_IN_CAL_MONTH
	,END_OF_CAL_MONTH 
	,CALENDAR_MONTH_NAME
  FROM u_dw_references.T_MONTHS;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.W_MONTHS to u_dw_ext_references;

--------------------------------------------QUARTER
drop table u_dw_references.T_QUARTERS cascade constraints;

CREATE TABLE u_dw_references.T_QUARTERS
(
    TIME_ID DATE, 
    DAYS_IN_CAL_QUARTER NUMBER, 
	BEG_OF_CAL_QUARTER DATE, 
	END_OF_CAL_QUARTER DATE, 
	CALENDAR_QUARTER_NUMBER VARCHAR2(1), 
    constraint PK_T_QUARTERS primary key (TIME_ID)
)
organization index tablespace TS_REFERENCES_DATA_01;


create or replace view u_dw_references.W_QUARTERS as
SELECT 
    TIME_ID 
	,DAYS_IN_CAL_QUARTER 
	,BEG_OF_CAL_QUARTER
	,END_OF_CAL_QUARTER 
	,CALENDAR_QUARTER_NUMBER
  FROM u_dw_references.T_QUARTERS;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.W_QUARTERS to u_dw_ext_references;

--------------------------------------------YEARS
drop table u_dw_references.T_YEARS cascade constraints;

CREATE TABLE u_dw_references.T_YEARS
(
    TIME_ID DATE, 
	CALENDAR_YEAR VARCHAR2(5), 
	DAYS_IN_CAL_YEAR NUMBER, 
	BEG_OF_CAL_YEAR DATE, 
	END_OF_CAL_YEAR DATE,
    constraint PK_T_YEARS primary key (TIME_ID)
)
organization index tablespace TS_REFERENCES_DATA_01;


create or replace view u_dw_references.W_YEARS as
SELECT 
    TIME_ID 
	,CALENDAR_YEAR 
	,DAYS_IN_CAL_YEAR
	,BEG_OF_CAL_YEAR 
	,END_OF_CAL_YEAR
  FROM u_dw_references.T_YEARS;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.W_YEARS to u_dw_ext_references;



CREATE OR REPLACE PACKAGE u_dw_ext_references.pkg_load_t_time
AS  
   PROCEDURE generate_T_CALENDAR (
                    prev_start_date IN VARCHAR2 DEFAULT '12/31/2021', 
                    format_date IN VARCHAR2 DEFAULT 'MM/DD/YYYY', 
                    count_rows IN NUMBER DEFAULT 800, 
                    nls_ter IN VARCHAR2 DEFAULT 'UNITED KINGDOM');

   PROCEDURE load_T_DAYS;
   
   PROCEDURE load_T_WEEKS;
      
   PROCEDURE load_T_MONTHS;
   
   PROCEDURE load_T_QUARTERS;
      
   PROCEDURE load_T_YEARS;
   
END pkg_load_t_time;
/





CREATE OR REPLACE PACKAGE BODY u_dw_ext_references.pkg_load_t_time
AS

   PROCEDURE generate_T_CALENDAR (
                    prev_start_date IN VARCHAR2 DEFAULT '12/31/2021', 
                    format_date IN VARCHAR2 DEFAULT 'MM/DD/YYYY', 
                    count_rows IN NUMBER DEFAULT 800, 
                    nls_ter IN VARCHAR2 DEFAULT 'UNITED KINGDOM')
   AS
      l_query VARCHAR2 (100) := 'alter session set nls_territory = ''' || nls_ter || '''';

   BEGIN

      EXECUTE IMMEDIATE l_query ;
      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_ext_references.CLS_CALENDAR';

      --Extract data
      INSERT INTO u_dw_ext_references.CLS_CALENDAR
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
              TO_DATE( prev_start_date, format_date ) sd,
              rownum rn
            FROM dual
              CONNECT BY level <= count_rows
          );

      --Commit Data
      COMMIT;
   END generate_T_CALENDAR;

   PROCEDURE load_T_DAYS
   AS
   BEGIN

--      EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.T_DAYS';
        DELETE FROM u_dw_references.W_DAYS;

      --Extract data
      INSERT INTO u_dw_references.W_DAYS ( TIME_ID 
                                            ,DAY_NAME 
                                            ,DAY_NUMBER_IN_WEEK
                                            ,DAY_NUMBER_IN_MONTH 
                                            ,DAY_NUMBER_IN_YEAR )
         SELECT  TIME_ID 
                ,DAY_NAME 
                ,DAY_NUMBER_IN_WEEK
                ,DAY_NUMBER_IN_MONTH 
                ,DAY_NUMBER_IN_YEAR
           FROM u_dw_ext_references.CLS_CALENDAR;

      --Commit Data
      COMMIT;
   END load_T_DAYS;
   
--------------------------------------------------------------------
   PROCEDURE load_T_WEEKS
   AS
   BEGIN

       DELETE FROM u_dw_references.W_WEEKS;

      --Extract data
      INSERT INTO u_dw_references.W_WEEKS (TIME_ID 
                                            ,CALENDAR_WEEK_NUMBER_MONTH
                                            ,CALENDAR_WEEK_NUMBER
                                        --	,WEEK_NUMBER_IN_YEAR_FULL
                                            ,WEEK_NUMBER_IN_YEAR
                                            ,WEEK_NUMBER_IN_MONTH
                                            ,WEEK_ENDING_DATE )
         SELECT  TIME_ID 
                ,CALENDAR_WEEK_NUMBER_MONTH
                ,CALENDAR_WEEK_NUMBER
            --	,WEEK_NUMBER_IN_YEAR_FULL
                , FLOOR((ROW_NUMBER() OVER (PARTITION BY CALENDAR_YEAR ORDER BY TIME_ID)  - day_number_in_week)/7) + 2 WEEK_NUMBER_IN_YEAR
                , FLOOR((ROW_NUMBER() OVER (PARTITION BY CALENDAR_YEAR, calendar_month_number ORDER BY TIME_ID)  - day_number_in_week)/7) + 2 WEEK_NUMBER_IN_MONTH
                ,WEEK_ENDING_DATE
           FROM u_dw_ext_references.CLS_CALENDAR;

      --Commit Data
      COMMIT;
   END load_T_WEEKS;
   
--------------------------------------------------------------------
   PROCEDURE load_T_MONTHS
   AS
   BEGIN

       DELETE FROM u_dw_references.W_MONTHS;

      --Extract data
      INSERT INTO u_dw_references.W_MONTHS (TIME_ID 
                                            ,CALENDAR_MONTH_NUMBER 
                                            ,DAYS_IN_CAL_MONTH
                                            ,END_OF_CAL_MONTH 
                                            ,CALENDAR_MONTH_NAME )
         SELECT  TIME_ID 
                ,CALENDAR_MONTH_NUMBER 
                ,DAYS_IN_CAL_MONTH
                ,END_OF_CAL_MONTH 
                ,CALENDAR_MONTH_NAME
           FROM u_dw_ext_references.CLS_CALENDAR;

      --Commit Data
      COMMIT;
   END load_T_MONTHS;
   
--------------------------------------------------------------------
   PROCEDURE load_T_QUARTERS
   AS
   BEGIN

       DELETE FROM u_dw_references.W_QUARTERS;

      --Extract data
      INSERT INTO u_dw_references.W_QUARTERS (TIME_ID 
                                            ,DAYS_IN_CAL_QUARTER 
                                            ,BEG_OF_CAL_QUARTER
                                            ,END_OF_CAL_QUARTER 
                                            ,CALENDAR_QUARTER_NUMBER )
         SELECT TIME_ID 
                ,DAYS_IN_CAL_QUARTER 
                ,BEG_OF_CAL_QUARTER
                ,END_OF_CAL_QUARTER 
                ,CALENDAR_QUARTER_NUMBER
           FROM u_dw_ext_references.CLS_CALENDAR;

      --Commit Data
      COMMIT;
   END load_T_QUARTERS;

   
--------------------------------------------------------------------
   PROCEDURE load_T_YEARS
   AS
   BEGIN

       DELETE FROM u_dw_references.W_YEARS;

      --Extract data
      INSERT INTO u_dw_references.W_YEARS ( TIME_ID 
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

      --Commit Data
      COMMIT;
   END load_T_YEARS;
    
END pkg_load_t_time;
/


EXEC u_dw_ext_references.pkg_load_t_time.generate_T_CALENDAR('12/31/2021', 'MM/DD/YYYY', 800, 'UNITED KINGDOM');

EXEC u_dw_ext_references.pkg_load_t_time.load_T_DAYS;
EXEC u_dw_ext_references.pkg_load_t_time.load_T_WEEKS;
EXEC u_dw_ext_references.pkg_load_t_time.load_T_MONTHS;
EXEC u_dw_ext_references.pkg_load_t_time.load_T_QUARTERS;
EXEC u_dw_ext_references.pkg_load_t_time.load_T_YEARS;


