/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_CURRENCY                                            */
/*==============================================================*/
create table U_DW_AUCTIONS.T_CURRENCY (
   ID_CURRENCY          NUMBER                not null,
   NAME                 VARCHAR2(20),
   SHORT_NAME           VARCHAR2(5),
   constraint PK_T_CURRENCY primary key (ID_CURRENCY)
)
   tablespace TS_AUCTION_DATA_01;

