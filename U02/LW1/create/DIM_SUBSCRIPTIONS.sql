/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_SUBSCRIPTIONS                                     */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS (
   ID_SUBSCRIPTIONS     NUMBER,
   NAME                 VARCHAR2(50),
   RATE                 FLOAT,
   DURATION_DAY         NUMBER,
   DESCRIPTION          VARCHAR2(200),
   START_DTM            DATE,
   END_DTM              DATE
)
   tablespace TS_SUBSCRIPTION_DATA_01;

