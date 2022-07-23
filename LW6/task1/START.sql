--DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

--DROP TABLESPACE ts_dw_idx_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_persons_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_persons_idx_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_data_01 INCLUDING CONTENTS AND DATAFILES  CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_ext_data_01 INCLUDING CONTENTS AND DATAFILES  CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_idx_01 INCLUDING CONTENTS AND DATAFILES  CASCADE CONSTRAINTS;
--
--DROP USER u_dw_data CASCADE ;
--
--DROP USER u_dw_ext_references CASCADE ;
--
--DROP USER u_dw_persons;
--
--DROP USER u_dw_references CASCADE;
--
--DROP USER u_dw_str_cls;
--
--DROP USER u_str_data;
--
--DROP USER u_dw_common CASCADE;



@".\System\tablespaces\init_tablespaces.sql";

@".\System\users_roles\init_users.sql";

GRANT UNLIMITED TABLESPACE TO u_dw_references;
GRANT UNLIMITED TABLESPACE TO u_dw_ext_references;

ALTER USER u_dw_references QUOTA UNLIMITED ON TS_REFERENCES_DATA_01;
ALTER USER u_dw_ext_references QUOTA UNLIMITED ON ts_references_ext_data_01;

@".\System\directories\init_directories.sql";

@".\u_dw_ext_references\Tables\t_ext_lng_macro2ind_iso693.sql";
@".\u_dw_ext_references\Tables\t_ext_languages_iso693.sql";
@".\u_dw_ext_references\Tables\cls_lng_macro2ind_iso693.sql";
@".\u_dw_ext_references\Tables\cls_languages_iso693.sql";



@".\u_dw_references\tables\t_localizations\t_localizations.sql";
@".\u_dw_references\tables\t_localizations\t_localizations_init.sql";
@".\u_dw_references\tables\t_localizations\w_localization.sql";


@".\u_dw_common\packages\pkg_session_params\pkg_session_params-def.sql";
@".\u_dw_common\packages\pkg_session_params\pkg_session_params-impl.sql";
@".\u_dw_common\packages\pkg_session_params\pkg_session_params - Syn.sql";


@".\u_dw_references\tables\t_lng_scopes\t_lng_scopes.sql";
@".\u_dw_references\tables\t_lng_scopes\t_lng_scopes-init.sql";
@".\u_dw_references\tables\t_lng_scopes\w_lng_scopes.sql";
@".\u_dw_references\tables\t_lng_scopes\lc_lng_scopes.sql";
@".\u_dw_references\tables\t_lng_scopes\sq_t_lng_scopes.sql";
@".\u_dw_references\tables\t_lng_scopes\vl_lng_scopes.sql";
@".\u_dw_references\tables\t_lng_scopes\cu_lng_scopes.sql";



@".\u_dw_references\tables\t_lng_types\t_lng_types.sql";
@".\u_dw_references\tables\t_lng_types\w_lng_types.sql";
@".\u_dw_references\tables\t_lng_types\lc_lng_types.sql";
@".\u_dw_references\tables\t_lng_types\sq_lng_types_t_id.sql";
@".\u_dw_references\tables\t_lng_types\vl_lng_types.sql";
@".\u_dw_references\tables\t_lng_types\cu_lng_types.sql";



@".\u_dw_references\tables\t_languages\t_languages.sql";
@".\u_dw_references\tables\t_languages\w_languages.sql";
@".\u_dw_references\tables\t_languages\cu_languages.sql";
@".\u_dw_references\tables\t_languages\sq_languages_t_id.sql";




@".\u_dw_references\tables\t_lng_links\t_lng_links.sql";
@".\u_dw_references\tables\t_lng_links\w_lng_links.sql";

@".\u_dw_ext_references\Packages\pkg_load_ext_ref_lang\pkg_load_ext_ref_languages-def.sql";
@".\u_dw_ext_references\Packages\pkg_load_ext_ref_lang\pkg_load_ext_ref_languages-impl.sql";

@".\u_dw_ext_references\reload_languages_refs.sql";


 

select * from U_DW_REFERENCES.cu_lng_scopes;
select * from U_DW_REFERENCES.cu_lng_types;
select * from U_DW_REFERENCES.cu_languages;
select * from U_DW_REFERENCES.t_localizations;
select * from U_DW_REFERENCES.w_lng_links;


