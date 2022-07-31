/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_TIME                                            */
/*==============================================================*/
create table u_dw_references.DIM_TIME (
   TIME_ID              DATE                  not null,
   DAY_NAME             VARCHAR2(50),
   DAY_NUMBER_IN_WEEK   VARCHAR2(1),
   DAY_NUMBER_IN_MONTH  VARCHAR2(2),
   DAY_NUMBER_IN_YEAR   VARCHAR2(3),
   CALENDAR_WEEK_NUMBER_MONTH VARCHAR2(2),
   CALENDAR_WEEK_NUMBER VARCHAR2(2),
   WEEK_ENDING_DATE     DATE,
   CALENDAR_MONTH_NUMBER VARCHAR2(2),
   DAYS_IN_CAL_MONTH    VARCHAR2(2),
   END_OF_CAL_MONTH     DATE,
   CALENDAR_MONTH_NAME  VARCHAR2(50),
   DAYS_IN_CAL_QUARTER  NUMBER,
   BEG_OF_CAL_QUARTER   DATE,
   END_OF_CAL_QUARTER   DATE,
   CALENDAR_QUARTER_NUMBER VARCHAR2(1),
   CALENDAR_YEAR        VARCHAR2(5),
   DAYS_IN_CAL_YEAR     NUMBER,
   BEG_OF_CAL_YEAR      DATE,
   END_OF_CAL_YEAR      DATE,
   WEEK_NUMBER_IN_YEAR  VARCHAR2(2),
   WEEK_NUMBER_IN_MONTH VARCHAR2(1),
   constraint PK_DIM_TIME primary key (TIME_ID)
)
   tablespace TS_REFERENCES_DATA_01;
   
   

