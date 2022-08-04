/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_cntr_group_systems                                  */
/*==============================================================*/
create table u_dw_references.t_cntr_group_systems 
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUP_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_cntr_group_systems is
'Referense store:  Grouping Systems of Countries'
;

comment on column u_dw_references.t_cntr_group_systems.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications'
;

alter table u_dw_references.t_cntr_group_systems
   add constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

