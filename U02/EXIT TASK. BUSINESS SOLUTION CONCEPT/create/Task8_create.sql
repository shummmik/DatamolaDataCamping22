drop table U_DW_AUCTIONS.FCT_T_AUCTIONS_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_AUCTIONS_F                                      */
/*==============================================================*/
create table U_DW_AUCTIONS.FCT_T_AUCTIONS_F (
   ID_AUCTION           NUMBER                not null,
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
   LOAD_DTM             TIMESTAMP            default SYSDATE,
   constraint PK_FCT_T_AUCTIONS_F primary key (ID_AUCTION, LOAD_DTM)
)
   tablespace TS_AUCTION_DATA_01;




drop table U_DW_AUCTIONS.FCT_T_BETS_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_BETS_F                                          */
/*==============================================================*/
create table U_DW_AUCTIONS.FCT_T_BETS_F (
   ID_USER              NUMBER                not null,
   ID_AUCTION           NUMBER                not null,
   MAKE_DTM             TIMESTAMP             not null,
   COST                 FLOAT,
   LOAD_DTM             TIMESTAMP            default SYSDATE,
   constraint PK_FCT_T_BETS_F primary key (ID_USER, ID_AUCTION, MAKE_DTM)
)
   tablespace TS_AUCTION_DATA_01;




drop table U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_SUBSCRIPTIONS_USER_F                            */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F (
   ID_SUBSCRIPTIONS     NUMBER                not null,
   ID_USER              NUMBER                not null,
   PAYMENT              FLOAT,
   START_DTM            DATE                  not null,
   END_DTM              DATE,
   LOAD_DTM             TIMESTAMP            default SYSTIMESTAMP,
   ACTUAL_DTM           TIMESTAMP,
   constraint PK_FCT_T_SUBSCRIPTIONS_USER_F primary key (ID_SUBSCRIPTIONS, ID_USER, START_DTM, LOAD_DTM)
)
   tablespace TS_SUBSCRIPTION_DATA_01;