import io
from unittest.mock import MagicMock, patch
from src.module_types.schema import write_tests


def call_write_tests(schema_name="myschema", owner_is="alice", **getter_returns):
    buf = io.StringIO()
    cursor = MagicMock()

    defaults = dict(
        tables_are=[],
        foreign_tables_are=[],
        views_are=[],
        materialized_views_are=[],
        sequences_are=[],
        functions_are=[],
        opclasses_are=[],
        types_are=[],
        domains_are=[],
        enums_are=[],
        operators_are=[],
        extensions_are=[],
        schema_privs=[],
    )
    defaults.update(getter_returns)

    with (
        patch("src.module_types.schema.get_tables_are", return_value=defaults["tables_are"]),
        patch("src.module_types.schema.get_foreign_tables_are", return_value=defaults["foreign_tables_are"]),
        patch("src.module_types.schema.get_views_are", return_value=defaults["views_are"]),
        patch("src.module_types.schema.get_materialized_views_are", return_value=defaults["materialized_views_are"]),
        patch("src.module_types.schema.get_sequences_are", return_value=defaults["sequences_are"]),
        patch("src.module_types.schema.get_functions_are", return_value=defaults["functions_are"]),
        patch("src.module_types.schema.get_opclasses_are", return_value=defaults["opclasses_are"]),
        patch("src.module_types.schema.get_types_are", return_value=defaults["types_are"]),
        patch("src.module_types.schema.get_domains_are", return_value=defaults["domains_are"]),
        patch("src.module_types.schema.get_enums_are", return_value=defaults["enums_are"]),
        patch("src.module_types.schema.get_operators_are", return_value=defaults["operators_are"]),
        patch("src.module_types.schema.get_extensions_are", return_value=defaults["extensions_are"]),
        patch("src.module_types.schema.get_schema_privs", return_value=defaults["schema_privs"]),
    ):
        write_tests(buf, cursor, schema_name=schema_name, owner_is=owner_is)

    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(schema_name="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="alice")
    assert "SELECT has_role('alice'," in out


def test_schema_owner_is_always_written():
    out = call_write_tests(schema_name="myschema", owner_is="alice")
    assert "SELECT schema_owner_is('myschema', 'alice'," in out


def test_tables_are_written_with_data():
    out = call_write_tests(schema_name="myschema", tables_are=["users", "orders"])
    assert "SELECT tables_are(" in out
    assert "'users'" in out
    assert "'orders'" in out


def test_views_are_written_with_data():
    out = call_write_tests(schema_name="myschema", views_are=["my_view"])
    assert "SELECT views_are(" in out
    assert "'my_view'" in out


def test_sequences_are_written_with_data():
    out = call_write_tests(schema_name="myschema", sequences_are=["my_seq"])
    assert "SELECT sequences_are(" in out
    assert "'my_seq'" in out


def test_with_schema_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(schema_privs=[PrivRow("dbo", ["USAGE"])])
    assert "SELECT schema_privs_are(" in out


def test_with_no_schema_privs_omits_privs_are():
    out = call_write_tests(schema_privs=[])
    assert "SELECT schema_privs_are(" not in out


def test_schema_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(schema_name="public", schema_privs=[PrivRow("dbo", ["CREATE", "USAGE"])])
    assert "'dbo'" in out
    assert "'CREATE'" in out
    assert "'USAGE'" in out
