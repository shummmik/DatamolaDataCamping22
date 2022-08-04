/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_CATEGORY                                            */
/*==============================================================*/
create table U_DW_PRODUCTS.T_CATEGORY (
   ID_CATEGORY          NUMBER                not null,
   NAME                 VARCHAR2(100),
   constraint PK_T_CATEGORY primary key (ID_CATEGORY)
)
   tablespace TS_PRODUCT_DATA_01;

