/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_geo_parts                                           */
/*==============================================================*/
create table u_dw_references.t_geo_parts 
(
   geo_id               NUMBER(22,0)         not null,
   part_id              NUMBER(22,0)         not null,
   constraint PK_T_GEO_PARTS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_geo_parts is
'Referense store: Geographical Parts of Worlds'
;

comment on column u_dw_references.t_geo_parts.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_geo_parts.part_id is
'ID Code of Geographical Part of World'
;

alter table u_dw_references.t_geo_parts
   add constraint FK_T_GEO_OBJECTS2PARTS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

