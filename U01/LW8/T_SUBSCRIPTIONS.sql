/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_SUBSCRIPTIONS                                       */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (
   ID_SUBSCRIPTIONS     NUMBER                not null,
   ID_SUBSCRIPTIONS_NAME NUMBER,
   RATE                 FLOAT,
   DURATION_DAY         NUMBER,
   DESCRIPTION          VARCHAR2(200),
   START_DTM            DATE,
   END_DTM              DATE,
   constraint PK_T_SUBSCRIPTIONS primary key (ID_SUBSCRIPTIONS)
)
   tablespace TS_SUBSCRIPTION_DATA_01;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS
   add constraint FK_T_SUBSCR_T_SUBSCR foreign key (ID_SUBSCRIPTIONS_NAME)
      references U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME (ID_SUBSCRIPTIONS_NAME);

