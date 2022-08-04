
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
      INSERT INTO u_dw_references.W_DAYS parallel 10 ( TIME_ID 
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
      INSERT INTO u_dw_references.W_WEEKS parallel 10 (TIME_ID 
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
      INSERT INTO u_dw_references.W_MONTHS parallel 10 (TIME_ID 
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
      INSERT INTO u_dw_references.W_QUARTERS parallel 10 (TIME_ID 
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

      --Commit Data
      COMMIT;
   END load_T_YEARS;
    
END pkg_load_t_time;