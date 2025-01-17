SELECT distinct catalog, objid
FROM (
      SELECT 'pg_extprotocol' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_extprotocol'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_extprotocol'::regclass
      ) d
      LEFT OUTER JOIN pg_extprotocol c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_extprotocol' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_extprotocol'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_extprotocol'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_extprotocol c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_partition' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_partition'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_partition'::regclass
      ) d
      LEFT OUTER JOIN pg_partition c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_partition' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_partition'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_partition'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_partition c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_partition_rule' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_partition_rule'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_partition_rule'::regclass
      ) d
      LEFT OUTER JOIN pg_partition_rule c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_partition_rule' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_partition_rule'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_partition_rule'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_partition_rule c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_filespace' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_filespace'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_filespace'::regclass
      ) d
      LEFT OUTER JOIN pg_filespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_filespace' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_filespace'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_filespace'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_filespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_compression' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_compression'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_compression'::regclass
      ) d
      LEFT OUTER JOIN pg_compression c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_compression' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_compression'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_compression'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_compression c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_foreign_data_wrapper' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_foreign_data_wrapper'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_foreign_data_wrapper'::regclass
      ) d
      LEFT OUTER JOIN pg_foreign_data_wrapper c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_foreign_data_wrapper' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_foreign_data_wrapper'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_foreign_data_wrapper'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_foreign_data_wrapper c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_foreign_server' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_foreign_server'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_foreign_server'::regclass
      ) d
      LEFT OUTER JOIN pg_foreign_server c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_foreign_server' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_foreign_server'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_foreign_server'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_foreign_server c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_database' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_database'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_database'::regclass
      ) d
      LEFT OUTER JOIN pg_database c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_database' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_database'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_database'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_database c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_authid' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_authid'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_authid'::regclass
      ) d
      LEFT OUTER JOIN pg_authid c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_authid' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_authid'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_authid'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_authid c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_user_mapping' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_user_mapping'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_user_mapping'::regclass
      ) d
      LEFT OUTER JOIN pg_user_mapping c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_user_mapping' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_user_mapping'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_user_mapping'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_user_mapping c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_type' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_type'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_type'::regclass
      ) d
      LEFT OUTER JOIN pg_type c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_type' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_type'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_type'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_type c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_proc' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_proc'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_proc'::regclass
      ) d
      LEFT OUTER JOIN pg_proc c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_proc' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_proc'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_proc'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_proc c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_class' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_class'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_class'::regclass
      ) d
      LEFT OUTER JOIN pg_class c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_class' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_class'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_class'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_class c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_attrdef' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_attrdef'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_attrdef'::regclass
      ) d
      LEFT OUTER JOIN pg_attrdef c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_attrdef' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_attrdef'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_attrdef'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_attrdef c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_constraint' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_constraint'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_constraint'::regclass
      ) d
      LEFT OUTER JOIN pg_constraint c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_constraint' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_constraint'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_constraint'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_constraint c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_operator' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_operator'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_operator'::regclass
      ) d
      LEFT OUTER JOIN pg_operator c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_operator' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_operator'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_operator'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_operator c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_opclass' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_opclass'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_opclass'::regclass
      ) d
      LEFT OUTER JOIN pg_opclass c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_opclass' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_opclass'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_opclass'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_opclass c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_am' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_am'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_am'::regclass
      ) d
      LEFT OUTER JOIN pg_am c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_am' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_am'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_am'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_am c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_language' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_language'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_language'::regclass
      ) d
      LEFT OUTER JOIN pg_language c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_language' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_language'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_language'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_language c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_rewrite' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_rewrite'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_rewrite'::regclass
      ) d
      LEFT OUTER JOIN pg_rewrite c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_rewrite' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_rewrite'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_rewrite'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_rewrite c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_trigger' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_trigger'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_trigger'::regclass
      ) d
      LEFT OUTER JOIN pg_trigger c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_trigger' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_trigger'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_trigger'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_trigger c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_cast' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_cast'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_cast'::regclass
      ) d
      LEFT OUTER JOIN pg_cast c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_cast' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_cast'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_cast'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_cast c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_namespace' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_namespace'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_namespace'::regclass
      ) d
      LEFT OUTER JOIN pg_namespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL

      SELECT 'pg_namespace' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_namespace'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_namespace'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_namespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_conversion' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_conversion'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_conversion'::regclass
      ) d
      LEFT OUTER JOIN pg_conversion c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_conversion' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_conversion'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_conversion'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_conversion c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_tablespace' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_tablespace'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_tablespace'::regclass
      ) d
      LEFT OUTER JOIN pg_tablespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_tablespace' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_tablespace'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_tablespace'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_tablespace c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_resqueue' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_resqueue'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_resqueue'::regclass
      ) d
      LEFT OUTER JOIN pg_resqueue c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_resqueue' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_resqueue'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_resqueue'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_resqueue c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_resourcetype' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_resourcetype'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_resourcetype'::regclass
      ) d
      LEFT OUTER JOIN pg_resourcetype c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_resourcetype' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_resourcetype'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_resourcetype'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_resourcetype c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
      UNION ALL
      SELECT 'pg_resqueuecapability' as catalog, objid FROM (
        SELECT objid FROM pg_depend
          WHERE classid = 'pg_resqueuecapability'::regclass
        UNION ALL
        SELECT refobjid FROM pg_depend
          WHERE refclassid = 'pg_resqueuecapability'::regclass
      ) d
      LEFT OUTER JOIN pg_resqueuecapability c on (d.objid = c.oid)
      WHERE c.oid is NULL
      UNION ALL
      SELECT 'pg_resqueuecapability' as catalog, objid FROM (
        SELECT dbid, objid FROM pg_shdepend
          WHERE classid = 'pg_resqueuecapability'::regclass
        UNION ALL
        SELECT dbid, refobjid FROM pg_shdepend
          WHERE refclassid = 'pg_resqueuecapability'::regclass
      ) d JOIN pg_database db
        ON (d.dbid = db.oid and datname= current_database())
      LEFT OUTER JOIN pg_resqueuecapability c on (d.objid = c.oid)
      WHERE c.oid is NULL
 
) q;
