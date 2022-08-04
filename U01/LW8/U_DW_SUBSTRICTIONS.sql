/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     27-Jul-22 17:50:50                           */
/*==============================================================*/


/*==============================================================*/
/* User: U_DW_SUBSTRICTIONS                                     */
/*==============================================================*/
create user U_DW_SUBSTRICTIONS IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE TS_SUBSCRIPTION_DATA_01;

GRANT CONNECT,RESOURCE TO U_DW_SUBSTRICTIONS;