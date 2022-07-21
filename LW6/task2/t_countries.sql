/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_countries                                           */
/*==============================================================*/
create table u_dw_references.t_countries 
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   constraint PK_T_COUNTRIES primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_countries is
'Referense store: Geographical Countries'
;

comment on column u_dw_references.t_countries.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_countries.country_id is
'ID Code of Country'
;

alter table u_dw_references.t_countries
   add constraint FK_T_GEO_OBJECTS2COUNTRIES foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

