import io
import pytest
from src.writers.write_pgtap_tests import (
    write_tests_header,
    write_tests_footer,
    write_languages_are,
    write_tablespaces_are,
    write_roles_are,
    write_groups_are,
    write_users_are,
    write_casts_are,
    write_schemas_are,
    write_tables_are,
    write_foreign_tables_are,
    write_views_are,
    write_materialized_views_are,
    write_sequences_are,
    write_functions_are,
    write_opclasses_are,
    write_types_are,
    write_domains_are,
    write_enums_are,
    write_operators_are,
    write_extensions_are,
    write_partitions_are,
    write_columns_are,
    write_indexes_are,
    write_triggers_are,
    write_rules_are,
    write_db_owner_is,
    write_has_schema,
    write_schema_owner_is,
    write_has_language,
    write_language_owner_is,
    write_language_is_trusted,
    write_tablespace_owner_is,
    write_has_tablespace,
    write_has_role,
    write_has_group,
    write_has_user,
    write_is_member_of,
    write_isnt_member_of,
    write_isnt_superuser,
    write_is_superuser,
    write_has_extension,
    write_has_table,
    write_table_owner_is,
    write_has_pk,
    write_hasnt_pk,
    write_has_fk,
    write_hasnt_fk,
    write_col_is_pk,
    write_col_isnt_pk,
    write_col_is_fk,
    write_col_isnt_fk,
    write_has_unique,
    write_col_is_unique,
    write_has_check,
    write_col_has_check,
    write_is_ancestor_of,
    write_is_descendent_of,
    write_isnt_ancestor_of,
    write_isnt_descendent_of,
    write_is_partitioned,
    write_isnt_partitioned,
    write_has_inherited_tables,
    write_hasnt_inherited_tables,
    write_has_column,
    write_col_type_is,
    write_col_has_default,
    write_col_hasnt_default,
    write_col_is_null,
    write_col_not_null,
    write_col_default_is,
    write_has_type,
    write_has_index,
    write_index_is_unique,
    write_index_is_primary,
    write_index_type_is,
    write_index_is_clustered,
    write_has_rule,
    write_rule_is_instead,
    write_rule_is_on,
    write_fk_ok,
    write_has_trigger,
    write_trigger_is,
    write_has_function,
    write_has_sequence,
    write_sequence_owner_is,
    write_has_view,
    write_view_owner_is,
    write_has_materialized_view,
    write_materialized_view_owner_is,
    write_has_foreign_table,
    write_foreign_table_owner_is,
    write_function_owner_is,
    write_function_language_is,
    write_function_returns,
    write_function_is_definer,
    write_function_isnt_definer,
    write_function_is_strict,
    write_function_isnt_strict,
    write_function_is_normal_function,
    write_function_isnt_normal_function,
    write_function_is_aggregate,
    write_function_isnt_aggregate,
    write_function_is_window,
    write_function_isnt_window,
    write_function_is_procedure,
    write_function_isnt_procedure,
    write_function_volatility_is,
    write_has_enum,
    write_enum_has_labels,
    write_database_privs_are,
    write_schema_privs_are,
    write_table_privs_are,
    write_sequence_privs_are,
    write_function_privs_are,
    write_language_privs_are,
    write_column_privs_are,
    write_tablespace_privs_are,
    write_policies_are,
    write_policy_roles_are,
    write_policy_cmd_is,
    write_is_partition_of,
    write_index_owner_is,
    write_type_owner_is,
    write_domain_type_is,
    write_has_domain,
    write_extension_schema_is,
    write_hasnt_schema,
    write_hasnt_table,
    write_hasnt_view,
    write_hasnt_materialized_view,
    write_hasnt_sequence,
    write_hasnt_foreign_table,
    write_hasnt_type,
    write_hasnt_domain,
    write_hasnt_enum,
    write_hasnt_function,
    write_hasnt_role,
    write_hasnt_language,
    write_hasnt_cast,
    write_is_indexed,
    write_hasnt_column,
    write_hasnt_trigger,
    write_hasnt_rule,
    write_hasnt_index,
    write_hasnt_group,
    write_hasnt_user,
    write_hasnt_extension,
    write_hasnt_relation,
    write_hasnt_composite,
    write_hasnt_operator,
    write_hasnt_leftop,
    write_hasnt_rightop,
    write_hasnt_opclass,
    write_hasnt_tablespace,
)


@pytest.fixture
def buf():
    return io.StringIO()


def output(buf):
    return buf.getvalue()


# ---------------------------------------------------------------------------
# Header / footer
# ---------------------------------------------------------------------------

def test_write_tests_header_emits_begin_and_plan(buf):
    write_tests_header(buf)
    assert output(buf) == "BEGIN;\n  SELECT plan(0);\n\n"


def test_write_tests_footer_emits_finish_and_rollback(buf):
    write_tests_footer(buf)
    assert output(buf) == "  SELECT * FROM finish();\nROLLBACK;\n"


# ---------------------------------------------------------------------------
# Cluster-level assertions
# ---------------------------------------------------------------------------

def test_write_languages_are(buf):
    write_languages_are(buf, ["plpgsql", "sql"])
    assert output(buf) == "  SELECT languages_are( ARRAY['plpgsql', 'sql']::TEXT[], 'Cluster should have the correct languages.');\n\n"


def test_write_tablespaces_are(buf):
    write_tablespaces_are(buf, ["pg_default", "pg_global"])
    assert output(buf) == "  SELECT tablespaces_are( ARRAY['pg_default', 'pg_global']::TEXT[], 'Cluster should have the correct tablespaces.');\n\n"


def test_write_roles_are(buf):
    write_roles_are(buf, ["admin", "readonly"])
    assert output(buf) == "  SELECT roles_are( ARRAY['admin', 'readonly']::TEXT[], 'Cluster should have the correct roles.');\n\n"


def test_write_groups_are(buf):
    write_groups_are(buf, ["grp_a"])
    assert output(buf) == "  SELECT groups_are( ARRAY['grp_a']::TEXT[], 'Cluster should have the correct groups.');\n\n"


def test_write_users_are(buf):
    write_users_are(buf, ["alice", "bob"])
    assert output(buf) == "  SELECT users_are( ARRAY['alice', 'bob']::TEXT[], 'Cluster should have the correct users.');\n\n"


def test_write_casts_are(buf):
    write_casts_are(buf, ["(integer AS text)"])
    assert output(buf) == "  SELECT casts_are( ARRAY['(integer AS text)']::TEXT[], 'Cluster should have the correct casts.');\n\n"


# ---------------------------------------------------------------------------
# Database-level assertions
# ---------------------------------------------------------------------------

def test_write_schemas_are(buf):
    write_schemas_are(buf, "mydb", ["public", "app"])
    assert output(buf) == "  SELECT schemas_are( ARRAY['public', 'app']::TEXT[], 'Database mydb should have the correct schemas.');\n\n"


def test_write_db_owner_is(buf):
    write_db_owner_is(buf, "mydb", "postgres")
    assert output(buf) == "  SELECT db_owner_is('mydb', 'postgres', 'Database mydb should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# Schema-level assertions
# ---------------------------------------------------------------------------

def test_write_has_schema(buf):
    write_has_schema(buf, "public")
    assert output(buf) == "  SELECT has_schema('public', 'Schema public should exist.');\n\n"


def test_write_schema_owner_is(buf):
    write_schema_owner_is(buf, "public", "postgres")
    assert output(buf) == "  SELECT schema_owner_is('public', 'postgres', 'Schema public should have the correct owner.');\n\n"


def test_write_tables_are(buf):
    write_tables_are(buf, "public", ["users", "orders"])
    assert output(buf) == "  SELECT tables_are('public', ARRAY['users', 'orders']::TEXT[], 'Schema public should have the correct tables.');\n\n"


def test_write_foreign_tables_are(buf):
    write_foreign_tables_are(buf, "public", ["ext_tbl"])
    assert output(buf) == "  SELECT foreign_tables_are('public', ARRAY['ext_tbl']::TEXT[], 'Schema public should have the correct foreign tables.');\n\n"


def test_write_views_are(buf):
    write_views_are(buf, "public", ["v_users"])
    assert output(buf) == "  SELECT views_are('public', ARRAY['v_users']::TEXT[], 'Schema public should have the correct views.');\n\n"


def test_write_materialized_views_are(buf):
    write_materialized_views_are(buf, "public", ["mv_summary"])
    assert output(buf) == "  SELECT materialized_views_are('public', ARRAY['mv_summary']::TEXT[], 'Schema public should have the correct materialized views.');\n\n"


def test_write_sequences_are(buf):
    write_sequences_are(buf, "public", ["users_id_seq"])
    assert output(buf) == "  SELECT sequences_are('public', ARRAY['users_id_seq']::TEXT[], 'Schema public should have the correct sequences.');\n\n"


def test_write_functions_are(buf):
    write_functions_are(buf, "public", ["my_func(integer)"])
    assert output(buf) == "  SELECT functions_are('public', ARRAY['my_func(integer)']::TEXT[], 'Schema public should have the correct functions.');\n\n"


def test_write_opclasses_are(buf):
    write_opclasses_are(buf, "public", ["my_opclass"])
    assert output(buf) == "  SELECT opclasses_are('public', ARRAY['my_opclass']::TEXT[], 'Schema public should have the correct opclasses.');\n\n"


def test_write_types_are(buf):
    write_types_are(buf, "public", ["my_type"])
    assert output(buf) == "  SELECT types_are('public', ARRAY['my_type']::TEXT[], 'Schema public should have the correct types.');\n\n"


def test_write_domains_are(buf):
    write_domains_are(buf, "public", ["my_domain"])
    assert output(buf) == "  SELECT domains_are('public', ARRAY['my_domain']::TEXT[], 'Schema public should have the correct domains.');\n\n"


def test_write_enums_are(buf):
    write_enums_are(buf, "public", ["my_enum"])
    assert output(buf) == "  SELECT enums_are('public', ARRAY['my_enum']::TEXT[], 'Schema public should have the correct enums.');\n\n"


def test_write_operators_are(buf):
    write_operators_are(buf, "public", ["+(integer,integer)"])
    assert output(buf) == "  SELECT operators_are('public', ARRAY['+(integer,integer)']::TEXT[], 'Schema public should have the correct operators.');\n\n"


def test_write_extensions_are_without_schema(buf):
    # NOTE: no space after ( — write_select_for_schema_name differs from other writers
    write_extensions_are(buf, ["pgtap", "btree_gist"])
    assert output(buf) == "  SELECT extensions_are(ARRAY['pgtap', 'btree_gist']::TEXT[], 'Cluster should have the correct extensions');\n\n"


def test_write_extensions_are_with_schema(buf):
    # NOTE: no space after ( — write_select_for_schema_name differs from other writers
    write_extensions_are(buf, ["btree_gist"], schema_name="public")
    assert output(buf) == "  SELECT extensions_are('public', ARRAY['btree_gist']::TEXT[], 'Cluster should have the correct extensions');\n\n"


# ---------------------------------------------------------------------------
# Language assertions
# ---------------------------------------------------------------------------

def test_write_has_language(buf):
    write_has_language(buf, "plpgsql")
    assert output(buf) == "  SELECT has_language('plpgsql', 'Language plpgsql should exist.');\n\n"


def test_write_language_owner_is(buf):
    write_language_owner_is(buf, "plpgsql", "postgres")
    assert output(buf) == "  SELECT language_owner_is('plpgsql', 'postgres', 'Language plpgsql should have the correct owner.');\n\n"


def test_write_language_is_trusted(buf):
    write_language_is_trusted(buf, "plpgsql")
    assert output(buf) == "  SELECT language_is_trusted('plpgsql', 'Language plpgsql should exist.');\n\n"


# ---------------------------------------------------------------------------
# Tablespace assertions
# ---------------------------------------------------------------------------

def test_write_has_tablespace(buf):
    write_has_tablespace(buf, "pg_default")
    assert output(buf) == "  SELECT has_tablespace('pg_default', 'Tablespace pg_default should exist.');\n\n"


def test_write_tablespace_owner_is(buf):
    write_tablespace_owner_is(buf, "pg_default", "postgres")
    assert output(buf) == "  SELECT tablespace_owner_is('pg_default', 'postgres', 'Tablespace pg_default should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# Role assertions
# ---------------------------------------------------------------------------

def test_write_has_role(buf):
    write_has_role(buf, "alice")
    assert output(buf) == "  SELECT has_role('alice', 'Role alice should exist.');\n\n"


def test_write_has_group(buf):
    write_has_group(buf, "grp_a")
    assert output(buf) == "  SELECT has_group('grp_a', 'Group grp_a should exist.');\n\n"


def test_write_has_user(buf):
    write_has_user(buf, "alice")
    assert output(buf) == "  SELECT has_user('alice', 'User alice should exist.');\n\n"


def test_write_is_superuser(buf):
    write_is_superuser(buf, "postgres")
    assert output(buf) == "  SELECT is_superuser('postgres', 'Role postgres should be a superuser.');\n\n"


def test_write_isnt_superuser(buf):
    write_isnt_superuser(buf, "alice")
    assert output(buf) == "  SELECT isnt_superuser('alice', 'Group alice should not be a superuser.');\n\n"


def test_write_is_member_of(buf):
    write_is_member_of(buf, "grp_a", ["alice", "bob"])
    assert output(buf) == "  SELECT is_member_of('grp_a', ARRAY['alice', 'bob']::TEXT[], 'Role grp_a should have the correct members.');\n\n"


def test_write_isnt_member_of(buf):
    write_isnt_member_of(buf, "grp_a", ["charlie"])
    assert output(buf) == "  SELECT isnt_member_of('grp_a', ARRAY['charlie']::TEXT[], 'Role grp_a should not have  members.');\n\n"


# ---------------------------------------------------------------------------
# Extension assertions
# ---------------------------------------------------------------------------

def test_write_has_extension(buf):
    write_has_extension(buf, "public", "pgtap")
    assert output(buf) == "  SELECT has_extension('public', 'pgtap', 'Extension public.pgtap should exist.');\n\n"


# ---------------------------------------------------------------------------
# Table assertions
# ---------------------------------------------------------------------------

def test_write_has_table(buf):
    write_has_table(buf, "public", "users")
    assert output(buf) == "  SELECT has_table('public', 'users', 'Table public.users should exist.');\n\n"


def test_write_table_owner_is(buf):
    write_table_owner_is(buf, "public", "users", "alice")
    assert output(buf) == "  SELECT table_owner_is('public', 'users', 'alice', 'Table public.users should have the correct owner.');\n\n"


def test_write_partitions_are(buf):
    write_partitions_are(buf, "public", "orders", ["orders_2020", "orders_2021"])
    assert output(buf) == "  SELECT partitions_are('public', 'orders', ARRAY['orders_2020', 'orders_2021']::TEXT[], 'Table public.orders should have the correct partitions.');\n\n"


def test_write_columns_are(buf):
    write_columns_are(buf, "public", "users", ["id", "name", "email"])
    assert output(buf) == "  SELECT columns_are('public', 'users', ARRAY['id', 'name', 'email']::TEXT[], 'Table public.users should have the correct columns.');\n\n"


def test_write_indexes_are(buf):
    write_indexes_are(buf, "public", "users", ["users_pkey", "users_email_idx"])
    assert output(buf) == "  SELECT indexes_are('public', 'users', ARRAY['users_pkey', 'users_email_idx']::TEXT[], 'Table public.users should have the correct indexes.');\n\n"


def test_write_triggers_are(buf):
    write_triggers_are(buf, "public", "users", ["audit_trg"])
    assert output(buf) == "  SELECT triggers_are('public', 'users', ARRAY['audit_trg']::TEXT[], 'Table public.users should have the correct triggers.');\n\n"


def test_write_rules_are(buf):
    write_rules_are(buf, "public", "users", ["_RETURN"])
    assert output(buf) == "  SELECT rules_are('public', 'users', ARRAY['_RETURN']::TEXT[], 'Table public.users should have the correct rules.');\n\n"


def test_write_has_pk(buf):
    write_has_pk(buf, "public", "users")
    assert output(buf) == "  SELECT has_pk('public', 'users', 'Table public.users should have a primary key.');\n\n"


def test_write_hasnt_pk(buf):
    write_hasnt_pk(buf, "public", "log")
    assert output(buf) == "  SELECT hasnt_pk('public', 'log', 'Table public.log should not have a primary key.');\n\n"


def test_write_has_fk(buf):
    write_has_fk(buf, "public", "orders")
    assert output(buf) == "  SELECT has_fk('public', 'orders', 'Table public.orders should have a foreign key.');\n\n"


def test_write_hasnt_fk(buf):
    write_hasnt_fk(buf, "public", "lookup")
    assert output(buf) == "  SELECT hasnt_fk('public', 'lookup', 'Table public.lookup should not have a foreign key.');\n\n"


def test_write_col_is_pk(buf):
    write_col_is_pk(buf, "public", "users", ["id"])
    assert output(buf) == "  SELECT col_is_pk('public', 'users', ARRAY['id']::TEXT[], 'Table public.users should have the correct primary key columns.');\n\n"


def test_write_col_isnt_pk(buf):
    write_col_isnt_pk(buf, "public", "users", ["name", "email"])
    assert output(buf) == "  SELECT col_isnt_pk('public', 'users', ARRAY['name', 'email']::TEXT[], 'Table public.users should have the correct primary key columns.');\n\n"


def test_write_col_is_fk(buf):
    write_col_is_fk(buf, "public", "orders", ["user_id"])
    assert output(buf) == "  SELECT col_is_fk('public', 'orders', ARRAY['user_id']::TEXT[], 'Table public.orders should have the correct foreign key columns.');\n\n"


def test_write_col_isnt_fk(buf):
    write_col_isnt_fk(buf, "public", "orders", ["amount"])
    assert output(buf) == "  SELECT col_isnt_fk('public', 'orders', ARRAY['amount']::TEXT[], 'Table public.orders should have the correct foreign key columns.');\n\n"


def test_write_has_unique(buf):
    write_has_unique(buf, "public", "users")
    assert output(buf) == "  SELECT has_unique('public', 'users', 'Table public.users should have a unique key.');\n\n"


def test_write_col_is_unique(buf):
    write_col_is_unique(buf, "public", "users", ["email"])
    assert output(buf) == "  SELECT col_is_unique('public', 'users', ARRAY['email']::TEXT[], 'Table public.users should have the correct unique key columns.');\n\n"


def test_write_has_check(buf):
    write_has_check(buf, "public", "users")
    assert output(buf) == "  SELECT has_check('public', 'users', 'Table public.users should have a check constraint.');\n\n"


def test_write_col_has_check(buf):
    write_col_has_check(buf, "public", "users", ["age"])
    assert output(buf) == "  SELECT col_has_check('public', 'users', ARRAY['age']::TEXT[], 'Table public.users should have the correct check constraint columns.');\n\n"


def test_write_is_ancestor_of(buf):
    write_is_ancestor_of(buf, "public", "parent_tbl", "public", "child_tbl")
    assert output(buf) == "  SELECT is_ancestor_of('public', 'parent_tbl', 'public', 'child_tbl', 'Table public.parent_tbl should have the correct descendent.');\n\n"


def test_write_is_descendent_of(buf):
    write_is_descendent_of(buf, "public", "child_tbl", "public", "parent_tbl")
    assert output(buf) == "  SELECT is_descendent_of('public', 'child_tbl', 'public', 'parent_tbl', 'Table public.child_tbl should have the correct ancestor.');\n\n"


def test_write_isnt_ancestor_of(buf):
    write_isnt_ancestor_of(buf, "public", "tbl_a", "public", "tbl_b")
    assert output(buf) == "  SELECT isnt_ancestor_of('public', 'tbl_a', 'public', 'tbl_b', 'Table public.tbl_a should not have a descendent.');\n\n"


def test_write_isnt_descendent_of(buf):
    write_isnt_descendent_of(buf, "public", "tbl_b", "public", "tbl_a")
    assert output(buf) == "  SELECT isnt_descendent_of('public', 'tbl_b', 'public', 'tbl_a', 'Table public.tbl_b should not have an ancestor.');\n\n"


def test_write_is_partitioned(buf):
    write_is_partitioned(buf, "public", "orders")
    assert output(buf) == "  SELECT is_partitioned('public', 'orders', 'Table public.orders should be partitioned.');\n\n"


def test_write_isnt_partitioned(buf):
    write_isnt_partitioned(buf, "public", "users")
    assert output(buf) == "  SELECT isnt_partitioned('public', 'users', 'Table public.users should not be partitioned.');\n\n"


def test_write_has_inherited_tables(buf):
    write_has_inherited_tables(buf, "public", "parent_tbl")
    assert output(buf) == "  SELECT has_inherited_tables('public', 'parent_tbl', 'Table public.parent_tbl should have the correct child tables.');\n\n"


def test_write_hasnt_inherited_tables(buf):
    write_hasnt_inherited_tables(buf, "public", "users")
    assert output(buf) == "  SELECT hasnt_inherited_tables('public', 'users', 'Table public.users should not have child tables.');\n\n"


# ---------------------------------------------------------------------------
# Column assertions
# ---------------------------------------------------------------------------

def test_write_has_column(buf):
    write_has_column(buf, "public", "users", "email")
    assert output(buf) == "  SELECT has_column('public', 'users', 'email', 'Column public.users.email should exist.');\n\n"


def test_write_col_type_is(buf):
    write_col_type_is(buf, "public", "users", "email", "pg_catalog", "text")
    assert output(buf) == "  SELECT col_type_is('public', 'users', 'email', 'pg_catalog', 'text', 'Column public.users.email should have the correct type.');\n\n"


def test_write_col_has_default(buf):
    write_col_has_default(buf, "public", "users", "created_at")
    assert output(buf) == "  SELECT col_has_default('public', 'users', 'created_at', 'Column public.users.created_at should have DEFAULT.');\n\n"


def test_write_col_hasnt_default(buf):
    write_col_hasnt_default(buf, "public", "users", "name")
    assert output(buf) == "  SELECT col_hasnt_default('public', 'users', 'name', 'Column public.users.name should not have DEFAULT.');\n\n"


def test_write_col_not_null(buf):
    write_col_not_null(buf, "public", "users", "id")
    assert output(buf) == "  SELECT col_not_null('public', 'users', 'id', 'Column public.users.id should be NOT NULL.');\n\n"


def test_write_col_is_null(buf):
    write_col_is_null(buf, "public", "users", "bio")
    assert output(buf) == "  SELECT col_is_null('public', 'users', 'bio', 'Column public.users.bio should not be NOT NULL.');\n\n"


def test_write_col_default_is(buf):
    write_col_default_is(buf, "public", "users", "active", "'true'::boolean")
    assert output(buf) == "  SELECT col_default_is('public', 'users', 'active', 'true'::boolean, 'Column public.users.active should have the correct default.');\n\n"


# ---------------------------------------------------------------------------
# Type assertions
# ---------------------------------------------------------------------------

def test_write_has_type(buf):
    write_has_type(buf, "public", "my_type")
    assert output(buf) == "  SELECT has_type('public', 'my_type', 'Data type public.my_type should exist.');\n\n"


# ---------------------------------------------------------------------------
# Index assertions
# ---------------------------------------------------------------------------

def test_write_has_index(buf):
    write_has_index(buf, "public", "users", "users_pkey", ["id"])
    assert output(buf) == "  SELECT has_index('public', 'users', 'users_pkey', ARRAY['id']::TEXT[], 'Index public.users.users_pkey should exist.');\n\n"


def test_write_index_is_unique(buf):
    write_index_is_unique(buf, "public", "users", "users_email_idx")
    assert output(buf) == "  SELECT index_is_unique('public', 'users', 'users_email_idx', 'Index public.users.users_email_idx should be a unique index.');\n\n"


def test_write_index_is_primary(buf):
    write_index_is_primary(buf, "public", "users", "users_pkey")
    assert output(buf) == "  SELECT index_is_primary('public', 'users', 'users_pkey', 'Index public.users.users_pkey should be a primary key index.');\n\n"


def test_write_index_type_is(buf):
    write_index_type_is(buf, "public", "users", "users_pkey", "btree")
    assert output(buf) == "  SELECT index_is_type('public', 'users', 'users_pkey', 'btree', 'Index public.users.users_pkey should be of the correct type.');\n\n"


def test_write_index_is_clustered(buf):
    write_index_is_clustered(buf, "public", "users", "users_pkey")
    assert output(buf) == "  SELECT is_clustered('public', 'users', 'users_pkey', 'Index public.users.users_pkey should be clustered.');\n\n"


# ---------------------------------------------------------------------------
# Rule assertions
# ---------------------------------------------------------------------------

def test_write_has_rule(buf):
    write_has_rule(buf, "public", "users", "users_ins_rule")
    assert output(buf) == "  SELECT has_rule('public', 'users', 'users_ins_rule', 'Rule public.users.users_ins_rule should exist.');\n\n"


def test_write_rule_is_instead(buf):
    write_rule_is_instead(buf, "public", "users", "users_ins_rule")
    assert output(buf) == "  SELECT rule_is_instead('public', 'users', 'users_ins_rule', 'Rule public.users.users_ins_rule should be a instead rule.');\n\n"


def test_write_rule_is_on(buf):
    write_rule_is_on(buf, "public", "users", "users_ins_rule", "INSERT")
    assert output(buf) == "  SELECT rule_is_on('public', 'users', 'users_ins_rule', 'INSERT', 'Rule public.users.users_ins_rule should be on INSERT.');\n\n"


# ---------------------------------------------------------------------------
# Foreign key assertions
# ---------------------------------------------------------------------------

def test_write_fk_ok(buf):
    write_fk_ok(buf, "public", "orders", ["user_id"], "public", "users", ["id"], "orders_user_id_fk")
    assert output(buf) == "  SELECT fk_ok('public', 'orders', ARRAY['user_id']::TEXT[], 'public', 'users', ARRAY['id']::TEXT[], 'Foreign key public.orders.orders_user_id_fk should exist.');\n\n"


# ---------------------------------------------------------------------------
# Trigger assertions
# ---------------------------------------------------------------------------

def test_write_has_trigger(buf):
    write_has_trigger(buf, "public", "users", "audit_trg")
    assert output(buf) == "  SELECT has_trigger('public', 'users', 'audit_trg', 'Trigger public.users.audit_trg should exist.');\n\n"


def test_write_trigger_is(buf):
    write_trigger_is(buf, "public", "users", "audit_trg", "public", "audit_func")
    assert output(buf) == "  SELECT trigger_is('public', 'users', 'audit_trg', 'public', 'audit_func', 'Trigger public.users.audit_trg should exist.');\n\n"


# ---------------------------------------------------------------------------
# Function assertions
# ---------------------------------------------------------------------------

def test_write_has_function(buf):
    write_has_function(buf, "public", "my_func", ["integer", "text"], "my_func(integer, text)")
    assert output(buf) == "  SELECT has_function('public', 'my_func', ARRAY['integer', 'text']::TEXT[], 'Function public.my_func(integer, text) should exist.');\n\n"


def test_write_function_owner_is(buf):
    write_function_owner_is(buf, "public", "my_func", ["integer"], "alice", "my_func(integer)")
    assert output(buf) == "  SELECT function_owner_is('public', 'my_func', ARRAY['integer']::TEXT[], 'alice', 'Function public.my_func(integer) should have the correct owner.');\n\n"


def test_write_function_language_is(buf):
    write_function_language_is(buf, "public", "my_func", ["integer"], "plpgsql", "my_func(integer)")
    assert output(buf) == "  SELECT function_lang_is('public', 'my_func', ARRAY['integer']::TEXT[], 'plpgsql', 'Function public.my_func(integer) should have the correct language.');\n\n"


def test_write_function_returns(buf):
    write_function_returns(buf, "public", "my_func", ["integer"], "text", "my_func(integer)")
    assert output(buf) == "  SELECT function_returns('public', 'my_func', ARRAY['integer']::TEXT[], 'text', 'Function public.my_func(integer) should have the correct return type.');\n\n"


def test_write_function_is_definer(buf):
    write_function_is_definer(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT is_definer('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should have the correct security definer.');\n\n"


def test_write_function_isnt_definer(buf):
    write_function_isnt_definer(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_definer('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should have the correct security invoker.');\n\n"


def test_write_function_is_strict(buf):
    write_function_is_strict(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT is_strict('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should be strict.');\n\n"


def test_write_function_isnt_strict(buf):
    write_function_isnt_strict(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_strict('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should not be strict.');\n\n"


def test_write_function_is_normal_function(buf):
    write_function_is_normal_function(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT is_normal_function('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should be a normal function.');\n\n"


def test_write_function_isnt_normal_function(buf):
    write_function_isnt_normal_function(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_normal_function('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should not be a normal function.');\n\n"


def test_write_function_is_aggregate(buf):
    write_function_is_aggregate(buf, "public", "my_agg", ["text"], "my_agg(text)")
    assert output(buf) == "  SELECT is_aggregate('public', 'my_agg', ARRAY['text']::TEXT[], 'Function public.my_agg(text) should be an aggregate function.');\n\n"


def test_write_function_isnt_aggregate(buf):
    write_function_isnt_aggregate(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_aggregate('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should not be an aggregate function.');\n\n"


def test_write_function_is_window(buf):
    write_function_is_window(buf, "public", "my_win", ["integer"], "my_win(integer)")
    assert output(buf) == "  SELECT is_window('public', 'my_win', ARRAY['integer']::TEXT[], 'Function public.my_win(integer) should be a window function.');\n\n"


def test_write_function_isnt_window(buf):
    write_function_isnt_window(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_window('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should not be a window function.');\n\n"


def test_write_function_is_procedure(buf):
    write_function_is_procedure(buf, "public", "my_proc", ["integer"], "my_proc(integer)")
    assert output(buf) == "  SELECT is_procedure('public', 'my_proc', ARRAY['integer']::TEXT[], 'Function public.my_proc(integer) should be a procedure.');\n\n"


def test_write_function_isnt_procedure(buf):
    write_function_isnt_procedure(buf, "public", "my_func", ["integer"], "my_func(integer)")
    assert output(buf) == "  SELECT isnt_procedure('public', 'my_func', ARRAY['integer']::TEXT[], 'Function public.my_func(integer) should not be a procedure.');\n\n"


def test_write_function_volatility_is(buf):
    write_function_volatility_is(buf, "public", "my_func", ["integer"], "IMMUTABLE", "my_func(integer)")
    assert output(buf) == "  SELECT volatility_is('public', 'my_func', ARRAY['integer']::TEXT[], 'IMMUTABLE', 'Function public.my_func(integer) should have the correct volatility.');\n\n"


# ---------------------------------------------------------------------------
# Sequence assertions
# ---------------------------------------------------------------------------

def test_write_has_sequence(buf):
    write_has_sequence(buf, "public", "users_id_seq")
    assert output(buf) == "  SELECT has_sequence('public', 'users_id_seq', 'Sequence public.users_id_seq should exist.');\n\n"


def test_write_sequence_owner_is(buf):
    write_sequence_owner_is(buf, "public", "users_id_seq", "alice")
    assert output(buf) == "  SELECT sequence_owner_is('public', 'users_id_seq', 'alice', 'Sequence public.users_id_seq should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# View assertions
# ---------------------------------------------------------------------------

def test_write_has_view(buf):
    write_has_view(buf, "public", "v_users")
    assert output(buf) == "  SELECT has_view('public', 'v_users', 'View public.v_users should exist.');\n\n"


def test_write_view_owner_is(buf):
    write_view_owner_is(buf, "public", "v_users", "alice")
    assert output(buf) == "  SELECT view_owner_is('public', 'v_users', 'alice', 'View public.v_users should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# Materialized view assertions
# ---------------------------------------------------------------------------

def test_write_has_materialized_view(buf):
    write_has_materialized_view(buf, "public", "mv_summary")
    assert output(buf) == "  SELECT has_materialized_view('public', 'mv_summary', 'Materialized view public.mv_summary should exist.');\n\n"


def test_write_materialized_view_owner_is(buf):
    write_materialized_view_owner_is(buf, "public", "mv_summary", "alice")
    assert output(buf) == "  SELECT materialized_view_owner_is('public', 'mv_summary', 'alice', 'Materialized view public.mv_summary should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# Foreign table assertions
# ---------------------------------------------------------------------------

def test_write_has_foreign_table(buf):
    write_has_foreign_table(buf, "public", "ext_tbl")
    assert output(buf) == "  SELECT has_foreign_table('public', 'ext_tbl', 'Foreign table public.ext_tbl should exist.');\n\n"


def test_write_foreign_table_owner_is(buf):
    write_foreign_table_owner_is(buf, "public", "ext_tbl", "alice")
    assert output(buf) == "  SELECT foreign_table_owner_is('public', 'ext_tbl', 'alice', 'Foreign table public.ext_tbl should have the correct owner.');\n\n"


# ---------------------------------------------------------------------------
# Enum assertions
# ---------------------------------------------------------------------------

def test_write_has_enum(buf):
    write_has_enum(buf, "public", "my_enum")
    assert output(buf) == "  SELECT has_enum('public', 'my_enum', 'ENUM public.my_enum should exist.');\n\n"


def test_write_enum_has_labels(buf):
    write_enum_has_labels(buf, "public", "my_enum", ["active", "inactive", "pending"])
    assert output(buf) == "  SELECT enum_has_labels('public', 'my_enum', ARRAY['active', 'inactive', 'pending']::TEXT[], 'ENUM public.my_enum should have the correct labels.');\n\n"


# ---------------------------------------------------------------------------
# Privilege (ACL) assertions
# ---------------------------------------------------------------------------

def test_write_database_privs_are(buf):
    write_database_privs_are(buf, "mydb", "dbo", ["CONNECT", "TEMPORARY"])
    assert output(buf) == "  SELECT database_privs_are('mydb', 'dbo', ARRAY['CONNECT', 'TEMPORARY']::TEXT[], 'Database mydb should have the correct privileges for dbo.');\n\n"


def test_write_schema_privs_are(buf):
    write_schema_privs_are(buf, "public", "dbo", ["USAGE", "CREATE"])
    assert output(buf) == "  SELECT schema_privs_are('public', 'dbo', ARRAY['USAGE', 'CREATE']::TEXT[], 'Schema public should have the correct privileges for dbo.');\n\n"


def test_write_table_privs_are(buf):
    write_table_privs_are(buf, "public", "my_table", "dbo", ["SELECT", "INSERT"])
    assert output(buf) == "  SELECT table_privs_are('public', 'my_table', 'dbo', ARRAY['SELECT', 'INSERT']::TEXT[], 'Table public.my_table should have the correct privileges for dbo.');\n\n"


def test_write_sequence_privs_are(buf):
    write_sequence_privs_are(buf, "public", "my_seq", "dbo", ["USAGE", "SELECT"])
    assert output(buf) == "  SELECT sequence_privs_are('public', 'my_seq', 'dbo', ARRAY['USAGE', 'SELECT']::TEXT[], 'Sequence public.my_seq should have the correct privileges for dbo.');\n\n"


def test_write_function_privs_are(buf):
    write_function_privs_are(buf, "public", "my_func", ["integer", "text"], "dbo", ["EXECUTE"])
    assert output(buf) == "  SELECT function_privs_are('public', 'my_func', ARRAY['integer', 'text']::TEXT[], 'dbo', ARRAY['EXECUTE']::TEXT[], 'Function public.my_func should have the correct privileges for dbo.');\n\n"


def test_write_language_privs_are(buf):
    write_language_privs_are(buf, "plpgsql", "dbo", ["USAGE"])
    assert output(buf) == "  SELECT language_privs_are('plpgsql', 'dbo', ARRAY['USAGE']::TEXT[], 'Language plpgsql should have the correct privileges for dbo.');\n\n"


def test_write_column_privs_are(buf):
    write_column_privs_are(buf, "public", "my_table", "my_col", "dbo", ["SELECT", "UPDATE"])
    assert output(buf) == "  SELECT column_privs_are('public', 'my_table', 'my_col', 'dbo', ARRAY['SELECT', 'UPDATE']::TEXT[], 'Column public.my_table.my_col should have the correct privileges for dbo.');\n\n"


def test_write_tablespace_privs_are(buf):
    write_tablespace_privs_are(buf, "pg_default", "dbo", ["CREATE"])
    assert output(buf) == "  SELECT tablespace_privs_are('pg_default', 'dbo', ARRAY['CREATE']::TEXT[], 'Tablespace pg_default should have the correct privileges for dbo.');\n\n"


# ---------------------------------------------------------------------------
# RLS Policy assertions
# ---------------------------------------------------------------------------

def test_write_policies_are(buf):
    write_policies_are(buf, "public", "my_table", ["allow_select", "deny_delete"])
    assert output(buf) == "  SELECT policies_are('public', 'my_table', ARRAY['allow_select', 'deny_delete']::TEXT[], 'Table public.my_table should have the correct policies.');\n\n"


def test_write_policy_roles_are(buf):
    write_policy_roles_are(buf, "public", "my_table", "allow_select", ["dbo", "readonly"])
    assert output(buf) == "  SELECT policy_roles_are('public', 'my_table', 'allow_select', ARRAY['dbo', 'readonly']::TEXT[], 'Policy allow_select on public.my_table should apply to the correct roles.');\n\n"


def test_write_policy_cmd_is(buf):
    write_policy_cmd_is(buf, "public", "my_table", "allow_select", "SELECT")
    assert output(buf) == "  SELECT policy_cmd_is('public', 'my_table', 'allow_select', 'SELECT', 'Policy allow_select on public.my_table should apply to the correct command.');\n\n"


# ---------------------------------------------------------------------------
# Existing writers previously untested
# ---------------------------------------------------------------------------

def test_write_is_partition_of(buf):
    from collections import namedtuple
    Rec = namedtuple("Rec", ["parent_schema", "parent_table"])
    write_is_partition_of(buf, "public", "child_tbl", Rec("public", "parent_tbl"))
    assert output(buf) == "  SELECT is_partition_of('public', 'child_tbl', 'public', 'parent_tbl', 'Table public.child_tbl should be a partition.');\n\n"


def test_write_index_owner_is(buf):
    write_index_owner_is(buf, "public", "my_table", "my_idx", "alice")
    assert output(buf) == "  SELECT index_owner_is('public', 'my_table', 'my_idx', 'alice', 'Index public.my_table.my_idx should have the correct owner.');\n\n"


def test_write_type_owner_is(buf):
    write_type_owner_is(buf, "public", "my_type", "alice")
    assert output(buf) == "  SELECT type_owner_is('public', 'my_type', 'alice', 'Type public.my_type should have the correct owner.');\n\n"


def test_write_domain_type_is(buf):
    write_domain_type_is(buf, "public", "my_domain", "pg_catalog", "integer")
    assert output(buf) == "  SELECT domain_type_is('public', 'my_domain', 'pg_catalog', 'integer', 'Domain public.my_domain should have the correct type.');\n\n"


def test_write_has_domain(buf):
    write_has_domain(buf, "public", "my_domain")
    assert output(buf) == "  SELECT has_domain('public', 'my_domain', 'Domain public.my_domain should exist.');\n\n"


# ---------------------------------------------------------------------------
# hasnt_* writers — absence assertions
# ---------------------------------------------------------------------------

def test_write_hasnt_schema(buf):
    write_hasnt_schema(buf, "old_schema")
    assert output(buf) == "  SELECT hasnt_schema('old_schema', 'Schema old_schema should not exist.');\n\n"


def test_write_hasnt_table(buf):
    write_hasnt_table(buf, "public", "dropped_tbl")
    assert output(buf) == "  SELECT hasnt_table('public', 'dropped_tbl', 'Table public.dropped_tbl should not exist.');\n\n"


def test_write_hasnt_view(buf):
    write_hasnt_view(buf, "public", "old_view")
    assert output(buf) == "  SELECT hasnt_view('public', 'old_view', 'View public.old_view should not exist.');\n\n"


def test_write_hasnt_materialized_view(buf):
    write_hasnt_materialized_view(buf, "public", "old_mv")
    assert output(buf) == "  SELECT hasnt_materialized_view('public', 'old_mv', 'Materialized view public.old_mv should not exist.');\n\n"


def test_write_hasnt_sequence(buf):
    write_hasnt_sequence(buf, "public", "old_seq")
    assert output(buf) == "  SELECT hasnt_sequence('public', 'old_seq', 'Sequence public.old_seq should not exist.');\n\n"


def test_write_hasnt_foreign_table(buf):
    write_hasnt_foreign_table(buf, "public", "old_ft")
    assert output(buf) == "  SELECT hasnt_foreign_table('public', 'old_ft', 'Foreign table public.old_ft should not exist.');\n\n"


def test_write_hasnt_type(buf):
    write_hasnt_type(buf, "public", "old_type")
    assert output(buf) == "  SELECT hasnt_type('public', 'old_type', 'Type public.old_type should not exist.');\n\n"


def test_write_hasnt_domain(buf):
    write_hasnt_domain(buf, "public", "old_domain")
    assert output(buf) == "  SELECT hasnt_domain('public', 'old_domain', 'Domain public.old_domain should not exist.');\n\n"


def test_write_hasnt_enum(buf):
    write_hasnt_enum(buf, "public", "old_enum")
    assert output(buf) == "  SELECT hasnt_enum('public', 'old_enum', 'ENUM public.old_enum should not exist.');\n\n"


def test_write_hasnt_function(buf):
    write_hasnt_function(buf, "public", "old_fn", ["integer", "text"])
    assert output(buf) == "  SELECT hasnt_function('public', 'old_fn', ARRAY['integer', 'text']::TEXT[], 'Function public.old_fn should not exist.');\n\n"


def test_write_hasnt_role(buf):
    write_hasnt_role(buf, "old_role")
    assert output(buf) == "  SELECT hasnt_role('old_role', 'Role old_role should not exist.');\n\n"


def test_write_hasnt_language(buf):
    write_hasnt_language(buf, "plperl")
    assert output(buf) == "  SELECT hasnt_language('plperl', 'Language plperl should not exist.');\n\n"


def test_write_hasnt_cast(buf):
    write_hasnt_cast(buf, "integer", "text")
    assert output(buf) == "  SELECT hasnt_cast('integer', 'text', 'Cast integer->text should not exist.');\n\n"


def test_write_is_indexed(buf):
    write_is_indexed(buf, "public", "my_table", "my_idx")
    assert output(buf) == "  SELECT is_indexed('public', 'my_table', 'my_idx', 'Table public.my_table should have index/column my_idx indexed.');\n\n"


def test_write_hasnt_column(buf):
    write_hasnt_column(buf, "public", "my_table", "old_col")
    assert output(buf) == "  SELECT hasnt_column('public', 'my_table', 'old_col', 'Column public.my_table.old_col should not exist.');\n\n"


def test_write_hasnt_trigger(buf):
    write_hasnt_trigger(buf, "public", "my_table", "old_trg")
    assert output(buf) == "  SELECT hasnt_trigger('public', 'my_table', 'old_trg', 'Trigger old_trg on public.my_table should not exist.');\n\n"


def test_write_hasnt_rule(buf):
    write_hasnt_rule(buf, "public", "my_table", "old_rule")
    assert output(buf) == "  SELECT hasnt_rule('public', 'my_table', 'old_rule', 'Rule old_rule on public.my_table should not exist.');\n\n"


def test_write_hasnt_index(buf):
    write_hasnt_index(buf, "public", "my_table", "old_idx")
    assert output(buf) == "  SELECT hasnt_index('public', 'my_table', 'old_idx', 'Index public.my_table.old_idx should not exist.');\n\n"


# ---------------------------------------------------------------------------
# extension_schema_is
# ---------------------------------------------------------------------------

def test_write_extension_schema_is(buf):
    write_extension_schema_is(buf, "btree_gist", "exts")
    assert output(buf) == "  SELECT extension_schema_is('btree_gist', 'exts', 'Extension btree_gist should be in schema exts.');\n\n"


# ---------------------------------------------------------------------------
# Remaining hasnt_* writers
# ---------------------------------------------------------------------------

def test_write_hasnt_group(buf):
    write_hasnt_group(buf, "old_group")
    assert output(buf) == "  SELECT hasnt_group('old_group', 'Group old_group should not exist.');\n\n"


def test_write_hasnt_user(buf):
    write_hasnt_user(buf, "old_user")
    assert output(buf) == "  SELECT hasnt_user('old_user', 'User old_user should not exist.');\n\n"


def test_write_hasnt_extension(buf):
    write_hasnt_extension(buf, "public", "old_ext")
    assert output(buf) == "  SELECT hasnt_extension('public', 'old_ext', 'Extension public.old_ext should not exist.');\n\n"


def test_write_hasnt_relation(buf):
    write_hasnt_relation(buf, "public", "old_rel")
    assert output(buf) == "  SELECT hasnt_relation('public', 'old_rel', 'Relation public.old_rel should not exist.');\n\n"


def test_write_hasnt_composite(buf):
    write_hasnt_composite(buf, "public", "old_comp")
    assert output(buf) == "  SELECT hasnt_composite('public', 'old_comp', 'Composite type public.old_comp should not exist.');\n\n"


def test_write_hasnt_operator(buf):
    write_hasnt_operator(buf, "public", "old_op", "integer", "integer")
    assert output(buf) == "  SELECT hasnt_operator('old_op', 'public', 'integer', 'integer', 'Operator public.old_op should not exist.');\n\n"


def test_write_hasnt_leftop(buf):
    write_hasnt_leftop(buf, "old_op", "integer", "public")
    assert output(buf) == "  SELECT hasnt_leftop('old_op', 'integer', 'public', 'Left operator old_op(integer, ?) in public should not exist.');\n\n"


def test_write_hasnt_rightop(buf):
    write_hasnt_rightop(buf, "old_op", "integer", "public")
    assert output(buf) == "  SELECT hasnt_rightop('old_op', 'integer', 'public', 'Right operator old_op(?, integer) in public should not exist.');\n\n"


def test_write_hasnt_opclass(buf):
    write_hasnt_opclass(buf, "public", "old_opc")
    assert output(buf) == "  SELECT hasnt_opclass('public', 'old_opc', 'Operator class public.old_opc should not exist.');\n\n"


def test_write_hasnt_tablespace(buf):
    write_hasnt_tablespace(buf, "old_ts")
    assert output(buf) == "  SELECT hasnt_tablespace('old_ts', 'Tablespace old_ts should not exist.');\n\n"


