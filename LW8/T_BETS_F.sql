/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_BETS_F                                              */
/*==============================================================*/
create table U_DW_AUCTIONS.T_BETS_F (
   ID_USER              NUMBER                not null,
   ID_AUCTION           NUMBER                not null,
   MAKE_DTM             TIMESTAMP             not null,
   COST                 FLOAT,
   constraint PK_T_BETS_F primary key (ID_USER, ID_AUCTION, MAKE_DTM)
)
   tablespace TS_AUCTION_DATA_01  
   PARTITION BY HASH (ID_USER)
  SUBPARTITION BY HASH (ID_AUCTION)
  ( PARTITION P1 SUBPARTITION P1S1 SUBPARTITION P1S2 SUBPARTITION P1S3,
    PARTITION P2 SUBPARTITION P2S1 SUBPARTITION P2S2 SUBPARTITION P2S3,
    PARTITION P3 SUBPARTITION P3S1 SUBPARTITION P3S2 SUBPARTITION P3S3,
    PARTITION P4 SUBPARTITION P4S1 SUBPARTITION P4S2 SUBPARTITION P4S3
   );

alter table U_DW_AUCTIONS.T_BETS_F
   add constraint FK_T_BETS_F_FK_T_BETS_T_USER foreign key (ID_USER)
      references U_DW_PERSONS.T_USER (ID_USER);

alter table U_DW_AUCTIONS.T_BETS_F
   add constraint FK_T_BETS_F_REFERENCE_T_AUCTIO foreign key (ID_AUCTION)
      references U_DW_AUCTIONS.T_AUCTIONS_F (ID_AUCTION);

alter table U_DW_AUCTIONS.T_BETS_F
   add constraint FK_T_BETS_F_FK_T_BETS_DIM_USER foreign key (ID_USER)
      references U_DW_PERSONS.DIM_USERS (ID_USER);

