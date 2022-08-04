alter session set current_schema=U_DW_COMMON;

create or replace public synonym pkg_session_params for U_DW_COMMON.PKG_SESSION_PARAMS;

grant execute on U_DW_COMMON.PKG_SESSION_PARAMS to PUBLIC;