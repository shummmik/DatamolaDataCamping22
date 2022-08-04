/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_ADDRESS                                             */
/*==============================================================*/
create table U_DW_PERSONS.T_ADDRESS (
   ID_ADDRES            NUMBER                not null,
   ID_COUNTRY           NUMBER,
   CITY                 CHAR(50),
   STREET               CHAR(50),
   constraint PK_T_ADDRESS primary key (ID_ADDRES)
)
   tablespace TS_PRODUCT_DATA_01;

alter table U_DW_PERSONS.T_ADDRESS
   add constraint FK_T_ADDRES_REFERENCE_T_COUNTR foreign key (ID_COUNTRY)
      references U_DW_PERSONS.T_COUNTRIES (GEO_ID);

