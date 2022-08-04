/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: DIM_PRODUCTS                                          */
/*==============================================================*/
create table U_DW_PRODUCTS.DIM_PRODUCTS (
   ID_PROD              NUMBER              not null,
   NAME                 CHAR(200),
   START_OF_COSTS       FLOAT,
   FINISH_OF_COST       FLOAT,
   DESCRIPTION          CHAR(500),
   CATEGORY             CHAR(50),
   IMAGE                VARCHAR2(100),
   PLATFORM             VARCHAR2(100),
   CATEGORY_PLATFORM    VARCHAR2(100),
   IMAGE_PLATFORM       VARCHAR2(100),
   DESCRIPTION_PLATFORM VARCHAR2(200),
   constraint PK_DIM_PRODUCTS primary key (ID_PROD)
)
   tablespace TS_PRODUCT_DATA_01;

