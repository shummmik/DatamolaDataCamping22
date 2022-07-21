--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY EXT_REFERENCES
AS
  '/oracle/u02/oradata/AShumilovdb';
--  '/mnt/ext_references/AShumilov';
--  '/mnt/ext_references/';
  

GRANT READ ON DIRECTORY EXT_REFERENCES TO u_dw_ext_references;
GRANT WRITE ON DIRECTORY EXT_REFERENCES TO u_dw_ext_references;
GRANT WRITE ON DIRECTORY EXT_REFERENCES TO PUBLIC;
