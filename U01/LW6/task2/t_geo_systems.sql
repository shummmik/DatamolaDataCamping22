/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_geo_systems                                         */
/*==============================================================*/
create table u_dw_references.t_geo_systems 
(
   geo_id               NUMBER(22,0)         not null,
   geo_system_id        NUMBER(22,0)         not null,
   constraint PK_T_GEO_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_geo_systems is
'Referense store:  Geographical Systems of Specifications'
;

comment on column u_dw_references.t_geo_systems.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_geo_systems.geo_system_id is
'ID Code of Geography System Specifications'
;

alter table u_dw_references.t_geo_systems
   add constraint FK_T_GEO_SY_FK_T_GEO__T_GEO_OB foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

