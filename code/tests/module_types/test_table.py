import io
from unittest.mock import MagicMock, patch
from collections import namedtuple as nt
from src.module_types.table import write_tests

ConRecord = nt("ConRecord", ["columns_are"])
PartitionRecord = nt("PartitionRecord", ["parent_schema", "parent_table"])
FamilyBranch = nt("FamilyBranch", ["ancestor_schema", "ancestor_table", "descendent_schema", "descendent_table"])


def call_write_tests(
    schema_name="public",
    table_name="my_table",
    owner_is="alice",
    has_constraints=None,
    partitions_are=None,
    columns_are=None,
    indexes_are=None,
    triggers_are=None,
    rules_are=None,
    con_columns_are=None,
    con_columns_arent=None,
    family_tree=None,
    is_partition_of=None,
    inherited_records=None,
    **kwargs,
):
    buf = io.StringIO()
    cursor = MagicMock()

    if has_constraints is None:
        has_constraints = {}
    if partitions_are is None:
        partitions_are = []
    if columns_are is None:
        columns_are = []
    if indexes_are is None:
        indexes_are = []
    if triggers_are is None:
        triggers_are = []
    if rules_are is None:
        rules_are = []
    if con_columns_are is None:
        con_columns_are = []
    if con_columns_arent is None:
        con_columns_arent = []
    if family_tree is None:
        family_tree = []
    if is_partition_of is None:
        is_partition_of = []
    if inherited_records is None:
        inherited_records = []

    table_privs = kwargs.get("table_privs", [])
    policies_are = kwargs.get("policies_are", [])
    policy_info = kwargs.get("policy_info", [])
    with (
        patch("src.module_types.table.get_partitions_are", side_effect=[partitions_are, inherited_records]),
        patch("src.module_types.table.get_columns_are", return_value=columns_are),
        patch("src.module_types.table.get_indexes_are", return_value=indexes_are),
        patch("src.module_types.table.get_triggers_are", return_value=triggers_are),
        patch("src.module_types.table.get_rules_are", return_value=rules_are),
        patch("src.module_types.table.get_con_columns_are", return_value=con_columns_are),
        patch("src.module_types.table.get_con_columns_arent", return_value=con_columns_arent),
        patch("src.module_types.table.get_table_family_tree", return_value=family_tree),
        patch("src.module_types.table.get_is_partition_of", return_value=is_partition_of),
        patch("src.module_types.table.get_table_privs", return_value=table_privs),
        patch("src.module_types.table.get_policies_are", return_value=policies_are),
        patch("src.module_types.table.get_policy_info", return_value=policy_info),
    ):
        write_tests(buf, cursor, schema_name=schema_name, table_name=table_name,
                    owner_is=owner_is, has_constraints=has_constraints)

    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(schema_name="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_table_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table")
    assert "SELECT has_table('public', 'my_table'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="bob")
    assert "SELECT has_role('bob'," in out


def test_table_owner_is_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", owner_is="alice")
    assert "SELECT table_owner_is('public', 'my_table', 'alice'," in out


def test_columns_are_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", columns_are=["id", "name"])
    assert "SELECT columns_are(" in out


def test_indexes_are_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", indexes_are=["my_idx"])
    assert "SELECT indexes_are(" in out


def test_triggers_are_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", triggers_are=["my_trg"])
    assert "SELECT triggers_are(" in out


def test_rules_are_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", rules_are=["my_rule"])
    assert "SELECT rules_are(" in out


# ---------------------------------------------------------------------------
# Primary key constraints
# ---------------------------------------------------------------------------

def test_has_pk_writes_has_pk():
    out = call_write_tests(has_constraints={"has_pk": True})
    assert "SELECT has_pk(" in out
    assert "SELECT hasnt_pk(" not in out


def test_no_pk_writes_hasnt_pk():
    out = call_write_tests(has_constraints={"has_pk": False})
    assert "SELECT hasnt_pk(" in out
    assert "SELECT has_pk(" not in out


def test_pk_columns_are_written():
    records = [ConRecord(columns_are=["id"])]
    out = call_write_tests(has_constraints={"has_pk": True}, con_columns_are=records)
    assert "SELECT col_is_pk(" in out


def test_non_pk_columns_written_as_col_isnt_pk():
    records = [ConRecord(columns_are=["name"])]
    out = call_write_tests(has_constraints={"has_pk": True}, con_columns_arent=records)
    assert "SELECT col_isnt_pk(" in out


# ---------------------------------------------------------------------------
# Foreign key constraints
# ---------------------------------------------------------------------------

def test_has_fk_writes_has_fk():
    out = call_write_tests(has_constraints={"has_fk": True})
    assert "SELECT has_fk(" in out
    assert "SELECT hasnt_fk(" not in out


def test_no_fk_writes_hasnt_fk():
    out = call_write_tests(has_constraints={"has_fk": False})
    assert "SELECT hasnt_fk(" in out
    assert "SELECT has_fk(" not in out


# ---------------------------------------------------------------------------
# Unique constraints
# ---------------------------------------------------------------------------

def test_has_unique_writes_has_unique():
    out = call_write_tests(has_constraints={"has_unique": True})
    assert "SELECT has_unique(" in out


def test_no_unique_omits_has_unique():
    out = call_write_tests(has_constraints={"has_unique": False})
    assert "SELECT has_unique(" not in out


# ---------------------------------------------------------------------------
# Check constraints
# ---------------------------------------------------------------------------

def test_has_check_writes_has_check():
    out = call_write_tests(has_constraints={"has_check": True})
    assert "SELECT has_check(" in out


def test_no_check_omits_has_check():
    out = call_write_tests(has_constraints={"has_check": False})
    assert "SELECT has_check(" not in out


# ---------------------------------------------------------------------------
# Partitioning
# ---------------------------------------------------------------------------

def test_partitioned_table_writes_is_partitioned():
    out = call_write_tests(partitions_are=["child1"])
    assert "SELECT is_partitioned(" in out
    assert "SELECT isnt_partitioned(" not in out


def test_non_partitioned_table_writes_isnt_partitioned():
    out = call_write_tests(partitions_are=[])
    assert "SELECT isnt_partitioned(" in out
    assert "SELECT is_partitioned(" not in out


# ---------------------------------------------------------------------------
# Inheritance
# ---------------------------------------------------------------------------

def test_inherited_tables_writes_has_inherited_tables():
    out = call_write_tests(inherited_records=["child"])
    assert "SELECT has_inherited_tables(" in out
    assert "SELECT hasnt_inherited_tables(" not in out


def test_no_inherited_tables_writes_hasnt_inherited_tables():
    out = call_write_tests(inherited_records=[])
    assert "SELECT hasnt_inherited_tables(" in out
    assert "SELECT has_inherited_tables(" not in out


# ---------------------------------------------------------------------------
# Family tree
# ---------------------------------------------------------------------------

def test_ancestor_table_writes_is_ancestor_of():
    branch = FamilyBranch("public", "my_table", "public", "child_table")
    out = call_write_tests(schema_name="public", table_name="my_table", family_tree=[branch])
    assert "SELECT is_ancestor_of(" in out


def test_descendent_table_writes_is_descendent_of():
    branch = FamilyBranch("public", "parent_table", "public", "my_table")
    out = call_write_tests(schema_name="public", table_name="my_table", family_tree=[branch])
    assert "SELECT is_descendent_of(" in out


def test_with_table_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(table_privs=[PrivRow("dbo", ["SELECT"])])
    assert "SELECT table_privs_are(" in out


def test_with_no_table_privs_omits_privs_are():
    out = call_write_tests(table_privs=[])
    assert "SELECT table_privs_are(" not in out


def test_table_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(schema_name="public", table_name="my_table", table_privs=[PrivRow("dbo", ["INSERT", "SELECT"])])
    assert "'dbo'" in out
    assert "'INSERT'" in out
    assert "'SELECT'" in out


# ---------------------------------------------------------------------------
# RLS policies
# ---------------------------------------------------------------------------

PolicyInfo = nt("PolicyInfo", ["policy_name", "policy_roles", "policy_cmd"])


def test_with_policies_are_writes_policies_are():
    out = call_write_tests(policies_are=["allow_select"])
    assert "SELECT policies_are(" in out


def test_with_no_policies_omits_policies_are():
    out = call_write_tests(policies_are=[])
    assert "SELECT policies_are(" not in out


def test_policy_info_writes_policy_cmd_is():
    p = PolicyInfo(policy_name="allow_select", policy_roles=["dbo"], policy_cmd="SELECT")
    out = call_write_tests(policies_are=["allow_select"], policy_info=[p])
    assert "SELECT policy_cmd_is(" in out


def test_policy_info_writes_policy_roles_are():
    p = PolicyInfo(policy_name="allow_select", policy_roles=["dbo"], policy_cmd="SELECT")
    out = call_write_tests(policies_are=["allow_select"], policy_info=[p])
    assert "SELECT policy_roles_are(" in out


