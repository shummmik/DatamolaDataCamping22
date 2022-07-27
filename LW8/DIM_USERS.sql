/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_USERS                                             */
/*==============================================================*/
create table U_DW_PERSONS.DIM_USERS (
   ID_USER              NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_DIM_USERS primary key (ID_USER)
)
   tablespace TS_PRODUCT_DATA_01;

