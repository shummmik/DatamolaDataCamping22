/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_PRODUCTS                                            */
/*==============================================================*/
create table U_DW_PRODUCTS.T_PRODUCTS (
   ID_PROD              NUMBER                not null,
   NAME                 CHAR(200),
   ID_PLATFORM          NUMBER,
   START_OF_COSTS       FLOAT,
   FINISH_OF_COST       FLOAT,
   DESCRIPTION          CHAR(500),
   ID_CATEGORY          NUMBER,
   IMAGE                CHAR(10),
   constraint PK_T_PRODUCTS primary key (ID_PROD)
)
   tablespace TS_PRODUCT_DATA_01;

alter table U_DW_PRODUCTS.T_PRODUCTS
   add constraint FK_T_PRODUC_FK_T_PLAT_T_PLATFO foreign key (ID_PLATFORM)
      references U_DW_PRODUCTS.T_PLATFORM (ID_PLATFORM);

alter table U_DW_PRODUCTS.T_PRODUCTS
   add constraint FK_T_PRODUC_T_PRODUCT_T_CATEGO foreign key (ID_CATEGORY)
      references U_DW_PRODUCTS.T_CATEGORY (ID_CATEGORY);

