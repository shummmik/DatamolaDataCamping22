/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_AUCTIONS_F                                          */
/*==============================================================*/
create table U_DW_AUCTIONS.T_AUCTIONS_F (
   ID_AUCTION           NUMBER               not null,
   ID_PROD              NUMBER,
   START_DTM            TIMESTAMP,
   FINISH_DTM           TIMESTAMP,
   DURATION             INTEGER,
   START_COST           FLOAT,
   COST                 FLOAT,
   SELLER               NUMBER(22),
   BUYER                NUMBER(22),
   ID_CURRENCY          NUMBER,
   DESCRIPTION          VARCHAR2(250),
   COMPLETE             SMALLINT             default 0,
   constraint PK_T_AUCTIONS_F primary key (ID_AUCTION)
)
   tablespace TS_AUCTION_DATA_01;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   add constraint FK_T_AUCTIO_T_USER_BUYER foreign key (BUYER)
      references U_DW_PERSONS.T_USER (ID_USER);

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   add constraint FK_T_AUCTIO_T_USER_SELLER foreign key (SELLER)
      references U_DW_PERSONS.T_USER (ID_USER);

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   add constraint FK_T_AUCTIO_REFERENCE_T_CURREN foreign key (ID_CURRENCY)
      references U_DW_AUCTIONS.T_CURRENCY (ID_CURRENCY);

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   add constraint FK_T_AUCTIO_REFERENCE_T_PRODUC foreign key (ID_PROD)
      references U_DW_PRODUCTS.T_PRODUCTS (ID_PROD);

