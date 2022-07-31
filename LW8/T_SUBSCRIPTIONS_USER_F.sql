/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_SUBSCRIPTIONS_USER_F                                */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F (
   ID_SUBSCRIPTIONS     NUMBER                not null,
   ID_USER              NUMBER,
   PAYMENT              FLOAT,
   START_DTM            DATE,
   END_DTM              DATE,
   constraint PK_T_SUBSCRIPTIONS_USER_F primary key (ID_SUBSCRIPTIONS)
)
   tablespace TS_SUBSCRIPTION_DATA_01
   PARTITION BY RANGE (START_DTM)
  ( PARTITION START_2021 values less than (to_date('01-01-2022', 'DD-MM-YYYY')),
    PARTITION START_2022 values less than (to_date('01-01-2023', 'DD-MM-YYYY'))
   );

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   add constraint FK_T_SUBSCR_FK_T_SUBS_T_SUBSCR foreign key (ID_SUBSCRIPTIONS)
      references U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (ID_SUBSCRIPTIONS);

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   add constraint FK_T_SUBSCR_FK_T_SUBS_T_USER foreign key (ID_USER)
      references U_DW_PERSONS.T_USER (ID_USER);



