drop trigger u_dw_references.bi_t_cntr_group_systems
/

drop trigger u_dw_references.bi_t_cntr_groups
/

drop trigger u_dw_references.bi_t_cntr_sub_groups
/

drop trigger u_dw_references.bi_t_countries
/

drop trigger u_dw_references.bi_t_geo_parts
/

drop trigger u_dw_references.bi_t_regions
/

drop trigger u_dw_references.bi_t_geo_system
/

alter table u_dw_references.lc_cntr_group_systems
   drop constraint FK_LC_CNTR_GROUP_SYSTEMS
/

alter table u_dw_references.lc_cntr_group_systems
   drop constraint FK_LOC2CNTR_GROUP_SYSTEMS
/

alter table u_dw_references.lc_cntr_groups
   drop constraint FK_LC_CNTR_GROUPS
/

alter table u_dw_references.lc_cntr_groups
   drop constraint FK_LOC2CNTR_GROUPS
/

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LC_CNTR_SUB_GROUPS
/

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LOC2CNTR_SUB_GROUPS
/

alter table u_dw_references.lc_countries
   drop constraint FK_LC_COUNTRIES
/

alter table u_dw_references.lc_countries
   drop constraint FK_LOC2COUNTRIES
/

alter table u_dw_references.lc_geo_parts
   drop constraint FK_LC_CONTINENTS
/

alter table u_dw_references.lc_geo_parts
   drop constraint FK_LOC2CONTINENTS
/

alter table u_dw_references.lc_geo_regions
   drop constraint FK_LC_GEO_REGIONS
/

alter table u_dw_references.lc_geo_regions
   drop constraint FK_LOC2LC_GEO_REGIONS
/

alter table u_dw_references.lc_geo_systems
   drop constraint FK_LC_GEO_SYSTEMS
/

alter table u_dw_references.lc_geo_systems
   drop constraint FK_LOC2GEO_SYSTEMS
/

alter table u_dw_references.t_addresses
   drop constraint FK_Adress2ADRS_Types
/

alter table u_dw_references.t_cntr_group_systems
   drop constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM
/

alter table u_dw_references.t_cntr_groups
   drop constraint FK_T_GEO_OBJECTS2CNTR_GROUPS
/

alter table u_dw_references.t_cntr_sub_groups
   drop constraint FK_T_GEO_OBJECTS2CNTR_S_GROUPS
/

alter table u_dw_references.t_countries
   drop constraint FK_T_GEO_OBJECTS2COUNTRIES
/

alter table u_dw_references.t_geo_object_links
   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_C
/

alter table u_dw_references.t_geo_object_links
   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_P
/

alter table u_dw_references.t_geo_objects
   drop constraint FK_T_GEO_OB_FK_T_GEO__T_GEO_TY
/

alter table u_dw_references.t_geo_parts
   drop constraint FK_T_GEO_OBJECTS2PARTS
/

alter table u_dw_references.t_geo_regions
   drop constraint FK_T_GEO_OBJECTS2GEO_REGIONS
/

alter table u_dw_references.t_geo_systems
   drop constraint FK_T_GEO_SY_FK_T_GEO__T_GEO_OB
/

drop view u_dw_references.w_geo_types
/

drop view u_dw_references.w_geo_systems
/

drop view u_dw_references.w_geo_regions
/

drop view u_dw_references.w_geo_parts
/

drop view u_dw_references.w_geo_objects
/

drop view u_dw_references.w_geo_object_links
/

drop view u_dw_references.w_countries
/

drop view u_dw_references.w_cntr_sub_groups
/

drop view u_dw_references.w_cntr_group_systems
/

drop view u_dw_references.vl_geo_systems
/

drop view u_dw_references.vl_geo_regions
/

drop view u_dw_references.vl_geo_parts
/

drop view u_dw_references.vl_countries
/

drop view u_dw_references.vl_cntr_sub_groups
/

drop view u_dw_references.vl_cntr_groups
/

drop view u_dw_references.vl_cntr_group_systems
/

drop view u_dw_references.cu_geo_systems
/

drop view u_dw_references.cu_geo_regions
/

drop view u_dw_references.cu_geo_parts
/

drop view u_dw_references.cu_countries
/

drop view u_dw_references.cu_cntr_sub_groups
/

drop view u_dw_references.cu_cntr_groups
/

drop view u_dw_references.w_cntr_groups
/

drop view u_dw_references.cu_cntr_group_systems
/

drop table u_dw_ext_references.cls_cntr2grouping_iso3166 cascade constraints
/

drop table u_dw_ext_references.cls_cntr2structure_iso3166 cascade constraints
/

drop table u_dw_ext_references.cls_cntr_grouping_iso3166 cascade constraints;

drop table u_dw_ext_references.cls_geo_countries2_iso3166 cascade constraints;

drop table u_dw_ext_references.cls_geo_countries_iso3166 cascade constraints
/

drop table u_dw_ext_references.cls_geo_structure_iso3166 cascade constraints
/

drop table u_dw_references.lc_cntr_group_systems cascade constraints
/

drop table u_dw_references.lc_cntr_groups cascade constraints
/

drop table u_dw_references.lc_cntr_sub_groups cascade constraints
/

drop table u_dw_references.lc_countries cascade constraints
/

drop table u_dw_references.lc_geo_parts cascade constraints
/

drop table u_dw_references.lc_geo_regions cascade constraints
/

drop table u_dw_references.lc_geo_systems cascade constraints
/

drop table u_dw_references.t_address_types cascade constraints
/

drop table u_dw_references.t_addresses cascade constraints
/

drop table u_dw_references.t_cntr_group_systems cascade constraints
/

drop table u_dw_references.t_cntr_groups cascade constraints
/

drop table u_dw_references.t_cntr_sub_groups cascade constraints
/

drop table u_dw_references.t_countries cascade constraints
/

drop table u_dw_ext_references.t_ext_cntr2grouping_iso3166 cascade constraints
/

drop table u_dw_ext_references.t_ext_cntr2structure_iso3166 cascade constraints
/

drop table u_dw_ext_references.t_ext_cntr_grouping_iso3166 cascade constraints
/

drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints
/

drop table u_dw_ext_references.t_ext_geo_countries_iso3166 cascade constraints;

drop table u_dw_ext_references.t_ext_geo_structure_iso3166 cascade constraints
/

drop table u_dw_references.t_geo_object_links cascade constraints
/
--
drop index u_dw_references.ui_geo_objects_codes
/

drop table u_dw_references.t_geo_objects cascade constraints
/

drop table u_dw_references.t_geo_parts cascade constraints
/

drop table u_dw_references.t_geo_regions cascade constraints
/

drop table u_dw_references.t_geo_systems cascade constraints
/

drop table u_dw_references.t_geo_types cascade constraints
/
--
--drop user u_dw_common
--/
--
--drop user u_dw_data
--/
--
--drop user u_dw_ext_references
--/
--
--drop user u_dw_persons
--/
--
--drop user u_dw_references
--/
--
--drop user u_dw_str_cls
--/
--
--drop user u_str_data
--/
--
--drop tablespace TS_DW_DATA_01 including contents cascade constraints
--/
--
--drop tablespace TS_DW_IDX_01 including contents cascade constraints
--/
--
--drop tablespace TS_PERSONS_DATA_01 including contents cascade constraints
--/
--
--drop tablespace TS_PERSONS_IDX_01 including contents cascade constraints
--/
--
--drop tablespace TS_REFERENCES_DATA_01 including contents cascade constraints
--/
--
--drop tablespace TS_REFERENCES_EXT_DATA_01 including contents cascade constraints
--/
--
--drop tablespace TS_REFERENCES_IDX_01 including contents cascade constraints
--/
--
--create tablespace TS_DW_DATA_01
--datafile 'db_qpt_dw_data_01.dat'
--size 200M
-- autoextend on next 100M
-- segment space management auto
--/
--
--create tablespace TS_DW_IDX_01
--datafile 'db_qpt_dw_idx_01.dat'
--size 150M
-- autoextend on next 50M
-- segment space management auto
--/
--
--create tablespace TS_PERSONS_DATA_01
--datafile 'db_qpt_person_data_01.dat'
--size 150M
-- autoextend on next 50M
-- segment space management auto
--/
--
--create tablespace TS_PERSONS_IDX_01
--datafile 'db_qpt_person_idx_01.dat'
--size 50M
-- autoextend on next 50M
-- segment space management auto
--/
--
--create tablespace TS_REFERENCES_DATA_01
--datafile 'db_qpt_references_data_01.dat'
--size 150M
-- autoextend on next 50
-- segment space management auto
--/
--
--create tablespace TS_REFERENCES_EXT_DATA_01
--datafile 'db_qpt_ext_references_data_01.dat'
--size 20M
-- autoextend on
--    next 20M
--    maxsize 60M
-- segment space management auto
--/
--
--create tablespace TS_REFERENCES_IDX_01
--datafile 'db_qpt_references_idx_01.dat'
--size 50M
-- autoextend on next 50M
-- segment space management auto
--/



--start u_dw_common.sql
--/
--
--start u_dw_data.sql
--/
--
--start u_dw_ext_references.sql
--/
--
--start u_dw_persons.sql
--/
--
--start u_dw_references.sql
--/
--
--start u_dw_str_cls.sql
--/
--
--start u_str_data.sql
--/
start sq_geo_t_id.sql

start t_ext_cntr2grouping_iso3166.sql;

start t_ext_cntr2structure_iso3166.sql;

start t_ext_cntr_grouping_iso3166.sql;

start t_ext_geo_countries2_iso3166.sql;

start t_ext_geo_countries_iso3166.sql;

start t_ext_geo_structure_iso3166.sql;

start cls_cntr2grouping_iso3166.sql;

start cls_cntr2structure_iso3166.sql;

start cls_cntr_grouping_iso3166.sql;

start cls_geo_countries2_iso3166.sql;

start cls_geo_countries_iso3166.sql;

start cls_geo_structure_iso3166.sql;

start t_geo_types.sql;

start t_geo_objects.sql;

start w_geo_types.sql;

start t_geo_types-init.sql

start t_cntr_group_systems.sql;

start t_cntr_groups.sql;

start t_cntr_sub_groups.sql;

start t_geo_object_links.sql;

start t_countries.sql;

start t_geo_parts.sql;

start t_geo_regions.sql;

start t_geo_systems.sql;

start t_address_types.sql;

start t_addresses.sql;

start w_geo_objects.sql;


start bi_t_cntr_group_systems.sql;

start bi_t_cntr_groups.sql;

start bi_t_cntr_sub_groups.sql;

start bi_t_countries.sql;

start bi_t_geo_parts.sql;

start bi_t_regions.sql;

start bi_t_geo_system.sql;

start lc_cntr_group_systems.sql;

start lc_cntr_groups.sql;

start lc_cntr_sub_groups.sql;

start lc_countries.sql;

start lc_geo_parts.sql;

start lc_geo_regions.sql;

start lc_geo_systems.sql;



start w_cntr_group_systems.sql;

start w_cntr_groups.sql;

start w_cntr_sub_groups.sql;

start w_countries.sql;

start w_geo_object_links.sql;

start w_geo_parts.sql;

start w_geo_regions.sql;

start w_geo_systems.sql;








start vl_cntr_group_systems.sql;

start vl_cntr_groups.sql;

start vl_cntr_sub_groups.sql;

start vl_countries.sql;

start vl_geo_parts.sql;

start vl_geo_regions.sql;

start vl_geo_systems.sql;


@".\u_dw_ext_references\packages\pkg_load_ext_ref_geo\pkg_load_ext_ref_geo-def.sql";
@".\u_dw_ext_references\packages\pkg_load_ext_ref_geo\pkg_load_ext_ref_geo-impl.sql";


start cu_cntr_group_systems.sql;

start cu_cntr_groups.sql;

start cu_cntr_sub_groups.sql;

start cu_countries.sql;

start cu_geo_parts.sql;

start cu_geo_regions.sql;

start cu_geo_systems.sql;


--Transport Countries
exec  pkg_load_ext_ref_geography.load_cls_languages_alpha3;
exec  pkg_load_ext_ref_geography.load_cls_languages_alpha2;
alter session set current_schema=u_dw_ext_references;
exec  pkg_load_ext_ref_geography.load_ref_geo_countries;



--Cleansing
exec pkg_load_ext_ref_geography.load_cls_geo_structure;
exec pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
exec pkg_load_ext_ref_geography.load_cls_countries_grouping;
exec pkg_load_ext_ref_geography.load_cls_countries2groups;
--Transport References
exec pkg_load_ext_ref_geography.load_ref_geo_systems;
exec pkg_load_ext_ref_geography.load_ref_geo_parts;
exec pkg_load_ext_ref_geography.load_ref_geo_regions;
exec pkg_load_ext_ref_geography.load_ref_cntr_group_systems;
exec pkg_load_ext_ref_geography.load_ref_cntr_groups;
exec pkg_load_ext_ref_geography.load_ref_cntr_sub_groups;   
--Transport Links
exec pkg_load_ext_ref_geography.load_lnk_geo_structure;
exec pkg_load_ext_ref_geography.load_lnk_geo_countries;
exec pkg_load_ext_ref_geography.load_lnk_cntr_grouping;
exec pkg_load_ext_ref_geography.load_lnk_cntr2groups;



select * from cls_geo_countries_iso3166;
select * from cls_geo_countries2_iso3166;
select * from u_dw_references.w_countries;
select * from u_dw_references.vl_countries;
select * from cls_geo_structure_iso3166;
select * from cls_cntr2structure_iso3166;
select * from u_dw_references.w_geo_systems;
select * from u_dw_references.vl_geo_systems;
select * from u_dw_references.w_geo_parts;
select * from u_dw_references.vl_geo_parts;
select * from u_dw_references.w_geo_regions;
select * from u_dw_references.vl_geo_regions;
select * from cls_cntr_grouping_iso3166;
select * from cls_cntr2grouping_iso3166;
select * from u_dw_references.w_cntr_group_systems;
select * from u_dw_references.vl_cntr_group_systems;
select * from u_dw_references.w_cntr_groups;
select * from u_dw_references.vl_cntr_groups;
select * from u_dw_references.w_cntr_sub_groups;
select * from u_dw_references.vl_cntr_sub_groups;
select * from u_dw_references.w_geo_object_links;



