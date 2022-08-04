/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     27-Jul-22 17:50:50                           */
/*==============================================================*/


/*==============================================================*/
/* User: U_DW_AUCTIONS                                          */
/*==============================================================*/
create user U_DW_AUCTIONS IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE TS_AUCTION_DATA_01;

GRANT CONNECT,RESOURCE TO U_DW_AUCTIONS;