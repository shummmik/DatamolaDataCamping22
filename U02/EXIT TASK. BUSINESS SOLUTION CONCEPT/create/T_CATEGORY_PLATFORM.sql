/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_CATEGORY_PLATFORM                                   */
/*==============================================================*/
create table U_DW_PRODUCTS.T_CATEGORY_PLATFORM (
   ID_CATEGORY_PLATFORM NUMBER                not null,
   NAME                 VARCHAR2(100),
   constraint PK_T_CATEGORY_PLATFORM primary key (ID_CATEGORY_PLATFORM)
)
   tablespace TS_PRODUCT_DATA_01;

