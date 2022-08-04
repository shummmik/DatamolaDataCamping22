alter table U_DW_PERSONS.T_ADDRESS
   drop constraint FK_T_ADDRES_REFERENCE_T_COUNTR;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_T_USER_BUYER;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_T_USER_SELLER;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_FK_T_PROD_DIM_PROD;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_FK_T_USER_DIM_USER;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIONS_T_USER_DIM_USER;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_REFERENCE_T_CURREN;

alter table U_DW_AUCTIONS.T_AUCTIONS_F
   drop constraint FK_T_AUCTIO_REFERENCE_T_PRODUC;

alter table U_DW_AUCTIONS.T_BETS_F
   drop constraint FK_T_BETS_F_FK_T_BETS_T_USER;

alter table U_DW_AUCTIONS.T_BETS_F
   drop constraint FK_T_BETS_F_REFERENCE_T_AUCTIO;

alter table U_DW_AUCTIONS.T_BETS_F
   drop constraint FK_T_BETS_T_AUCTIONS;

alter table U_DW_AUCTIONS.T_BETS_F
   drop constraint FK_T_BETS_F_FK_T_BETS_DIM_USER;

alter table U_DW_PRODUCTS.T_PLATFORM
   drop constraint FK_T_PLATFO_FK_T_PLAT_T_CATEGO;

alter table U_DW_PRODUCTS.T_PRODUCTS
   drop constraint FK_T_PRODUC_FK_T_PLAT_T_PLATFO;

alter table U_DW_PRODUCTS.T_PRODUCTS
   drop constraint FK_T_PRODUC_T_PRODUCT_T_CATEGO;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS
   drop constraint FK_T_SUBSCR_T_SUBSCR;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   drop constraint FK_T_SUBSCR_FK_T_SUBS_T_SUBSCR;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   drop constraint FK_T_SUBSCR_FK_T_SUBS_T_USER;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   drop constraint FK_T_SUBSCR_USER_DIM_SUBSCR;

alter table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
   drop constraint FK_T_SUBSCR_FK_T_SUBS_DIM_USER;

alter table U_DW_PERSONS.T_USER
   drop constraint FK_T_USER_REFERENCE_T_ADDRES;

drop table u_dw_references.DIM_TIME cascade constraints;

drop table U_DW_PERSONS.W_SAL_CL_USERS_BUYER cascade constraints;

drop table U_DW_PERSONS.SAL_DW_CL_USERS_BUYER cascade constraints;

drop table U_DW_PERSONS.SAL_DW_CL_USERS_SELLER cascade constraints;

drop table U_DW_PRODUCTS.DIM_PRODUCTS cascade constraints;

drop table U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS cascade constraints;

drop table U_DW_PERSONS.DIM_SELLERS cascade constraints;

drop table U_DW_PERSONS.DIM_BUYERS cascade constraints;

drop table U_DW_PERSONS.T_ADDRESS cascade constraints;

drop table U_DW_AUCTIONS.T_AUCTIONS_F cascade constraints;

drop table U_DW_AUCTIONS.T_BETS_F cascade constraints;

drop table U_DW_PRODUCTS.T_CATEGORY cascade constraints;

drop table U_DW_PRODUCTS.T_CATEGORY_PLATFORM cascade constraints;

drop table U_DW_PERSONS.T_COUNTRIES cascade constraints;

drop table U_DW_AUCTIONS.T_CURRENCY cascade constraints;

drop table U_DW_PRODUCTS.T_PLATFORM cascade constraints;

drop table U_DW_PRODUCTS.T_PRODUCTS cascade constraints;

drop table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS cascade constraints;

drop table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME cascade constraints;

drop table U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F cascade constraints;

drop table U_DW_PERSONS.T_USER cascade constraints;


create TABLESPACE TS_AUCTION_DATA_01
DATAFILE '/oracle/u02/oradata/AShumilovdb/db_qpt_AUCTION_data_01.dat'
size 150M
autoextend on next 50M
segment space management auto;

create TABLESPACE TS_PRODUCT_DATA_01
DATAFILE '/oracle/u02/oradata/AShumilovdb/db_qpt_product_data_01.dat'
size 150M
autoextend on next 50M
segment space management auto;

create TABLESPACE TS_SUBSCRIPTION_DATA_01
DATAFILE '/oracle/u02/oradata/AShumilovdb/db_qpt_substriction_data_01.dat'
size 150M
autoextend on next 50M
segment space management auto;


start U_DW_AUCTIONS.sql;

start U_DW_PRODUCTS.sql;

start U_DW_SUBSTRICTIONS.sql;





-- start T_COUNTRIES.sql;

start DIM_TIME.sql;

start T_CURRENCY.sql;

start T_CATEGORY.sql;

start T_CATEGORY_PLATFORM.sql;

start T_PLATFORM.sql;

start T_PRODUCTS.sql;

start DIM_PRODUCTS.sql;

GRANT REFERENCES ON U_DW_REFERENCES.T_ADDRESSES TO U_DW_PERSONS;

start T_USER.sql;

start DIM_SELLERS.sql;

start DIM_BUYERS.sql;

GRANT REFERENCES ON U_DW_PERSONS.T_USER TO U_DW_AUCTIONS;

GRANT REFERENCES ON U_DW_PRODUCTS.DIM_PRODUCTS TO U_DW_AUCTIONS;

GRANT REFERENCES ON U_DW_PERSONS.DIM_USERS TO U_DW_AUCTIONS;

GRANT REFERENCES ON U_DW_AUCTIONS.T_CURRENCY TO U_DW_AUCTIONS;

GRANT REFERENCES ON U_DW_PRODUCTS.T_PRODUCTS TO U_DW_AUCTIONS;

start T_AUCTIONS_F.sql;

start T_BETS_F.sql;

start T_SUBSCRIPTIONS_NAME.sql;

start T_SUBSCRIPTIONS.sql;

GRANT REFERENCES ON U_DW_PERSONS.DIM_USERS TO U_DW_SUBSTRICTIONS;

GRANT REFERENCES ON U_DW_PERSONS.T_USER TO U_DW_SUBSTRICTIONS;

start DIM_SUBSCRIPTIONS.sql;

start T_SUBSCRIPTIONS_USER_F.sql;

GRANT read ON U_DW_AUCTIONS.T_AUCTIONS_F TO U_DW_PERSONS;

