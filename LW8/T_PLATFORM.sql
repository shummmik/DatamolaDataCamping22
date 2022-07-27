/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_PLATFORM                                            */
/*==============================================================*/
create table U_DW_PRODUCTS.T_PLATFORM (
   ID_PLATFORM          NUMBER                not null,
   NAME                 CHAR(200),
   ID_CATEGORY_PLATFORM NUMBER,
   IMAGE                CHAR(200),
   DESCRIPTION          CHAR(200),
   constraint PK_T_PLATFORM primary key (ID_PLATFORM)
)
   tablespace TS_PRODUCT_DATA_01;

alter table U_DW_PRODUCTS.T_PLATFORM
   add constraint FK_T_PLATFO_FK_T_PLAT_T_CATEGO foreign key (ID_CATEGORY_PLATFORM)
      references U_DW_PRODUCTS.T_CATEGORY_PLATFORM (ID_CATEGORY_PLATFORM);

