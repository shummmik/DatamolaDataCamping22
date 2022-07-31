/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_BUYERS                                            */
/*==============================================================*/
create table U_DW_PERSONS.DIM_BUYERS (
   ID_BUYERS            NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_DIM_BUYERS primary key (ID_BUYERS)
)
   tablespace TS_PRODUCT_DATA_01;
   

/*==============================================================*/
/* Table: W_SAL_CL_USERS_BUYER                                  */
/*==============================================================*/
create table U_DW_PERSONS.W_SAL_CL_USERS_BUYER (
   ID_BUYERS            NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_W_SAL_CL_USERS_BUYER primary key (ID_BUYERS)
)
   tablespace TS_PRODUCT_DATA_01;
   
   
/*==============================================================*/
/* Table: SAL_DW_CL_USERS_BUYER                                 */
/*==============================================================*/
create table U_DW_PERSONS.SAL_DW_CL_USERS_BUYER (
   ID_BUYERS            NUMBER(22)            not null,
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   COUNTRY_ID           CHAR(200),
   CITY                 CHAR(50),
   STREET               CHAR(300),
   IMAGE                CHAR(200),
   DATE_REG             TIMESTAMP,
   constraint PK_SAL_DW_CL_USERS_BUYER primary key (ID_BUYERS)
)
   tablespace TS_PRODUCT_DATA_01;