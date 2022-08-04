/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_geo_regions                                         */
/*==============================================================*/
create table u_dw_references.t_geo_regions 
(
   geo_id               NUMBER(22,0)         not null,
   region_id            NUMBER(22,0)         not null,
   constraint PK_T_GEO_REGIONS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
;

comment on table u_dw_references.t_geo_regions is
'Referense store: Geographical Continents - Regions'
;

comment on column u_dw_references.t_geo_regions.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.t_geo_regions.region_id is
'ID Code of Geographical Continent - Regions'
;

alter table u_dw_references.t_geo_regions
   add constraint FK_T_GEO_OBJECTS2GEO_REGIONS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
;

