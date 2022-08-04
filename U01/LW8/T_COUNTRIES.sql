/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_COUNTRIES                                           */
/*==============================================================*/
create table U_DW_PERSONS.T_COUNTRIES (
   GEO_ID               NUMBER                not null,
   COUNTRY_ID           NUMBER(200),
   constraint PK_T_COUNTRIES primary key (GEO_ID)
)
   tablespace TS_PRODUCT_DATA_01;

