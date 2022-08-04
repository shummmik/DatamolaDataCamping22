/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     27-Jul-22 23:28:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: T_USER                                                */
/*==============================================================*/
create table U_DW_PERSONS.T_USER (
   ID_USER              NUMBER(22)            not null,
   ID_ADDRES            NUMBER (22, 0),
   F_NAME               CHAR(100),
   S_NAME               CHAR(100),
   PHONE                CHAR(15),
   EMAIL                CHAR(50),
   DATE_REG             TIMESTAMP,
   IMAGE                VARCHAR2(200),
   constraint PK_T_USER primary key (ID_USER)
)
   tablespace ts_persons_data_01;

alter table U_DW_PERSONS.T_USER
   add constraint FK_T_USER_REFERENCE_T_ADDRES foreign key (ID_ADDRES)
      references U_DW_REFERENCES.T_ADDRESSES (ADRESS_ID);

