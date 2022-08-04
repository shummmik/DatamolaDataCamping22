/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_SUBSCRIPTIONS_NAME                                  */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME (
   ID_SUBSCRIPTIONS_NAME NUMBER                not null,
   NAME                 VARCHAR2(50),
   constraint PK_T_SUBSCRIPTIONS_NAME primary key (ID_SUBSCRIPTIONS_NAME)
)
   tablespace TS_SUBSCRIPTION_DATA_01;

