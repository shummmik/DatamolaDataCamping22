/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* View: w_countries                                            */
/*==============================================================*/
create or replace view u_dw_references.w_countries as
select
   geo_id,
   country_id
from
   t_countries
;

 comment on table u_dw_references.w_countries is
'Work View: T_COUNTRIES'
;

comment on column u_dw_references.w_countries.geo_id is
'Unique ID for All Geography objects'
;

comment on column u_dw_references.w_countries.country_id is
'ID Code of Country'
;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_countries to u_dw_ext_references
;

