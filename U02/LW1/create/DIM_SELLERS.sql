/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_SELLERS                                           */
/*==============================================================*/
create table U_DW_PERSONS.DIM_SELLERS (
   ID_SELLERS           NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_DIM_SELLERS primary key (ID_SELLERS)
)
   tablespace TS_PRODUCT_DATA_01;


/*==============================================================*/
/* Table: SAL_DW_CL_USERS_SELLER                                */
/*==============================================================*/
create table U_DW_PERSONS.SAL_DW_CL_USERS_SELLER (
   ID_SELLERS           NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_SAL_DW_CL_USERS_SELLER primary key (ID_SELLERS)
)
   tablespace TS_PRODUCT_DATA_01;