/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     20-Jul-22 14:19:16                           */
/*==============================================================*/


/*==============================================================*/
/* Table: t_ext_geo_countries_iso3166                           */
/*==============================================================*/
create table u_dw_ext_references.t_ext_geo_countries_iso3166 
(
   country_id           NUMBER(10,0),
   country_desc          VARCHAR2(200 CHAR),
   country_code         VARCHAR2(30 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_id integer external (4), country_desc char(200), country_code char(3) ) )
    location ('iso_3166.tab')
)
reject limit unlimited
;

