/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_cntr_groups                                         */
/*==============================================================*/
create table u_dw_references.t_cntr_groups 
(
   geo_id               NUMBER(22,0)         not null,
   group_id             NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUPS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_cntr_groups is
'Referense store: Grouping Countries - Groups'
;

comment on column u_dw_references.t_cntr_groups.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_cntr_groups.group_id is
'ID Code of Countries Groups'
;

alter table u_dw_references.t_cntr_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_GROUPS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

