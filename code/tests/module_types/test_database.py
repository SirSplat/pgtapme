import io
from unittest.mock import MagicMock, patch
from src.module_types.database import write_tests


def call_write_tests(database_name="mydb", owner_is="alice", schemas_are=None, database_privs=None):
    buf = io.StringIO()
    cursor = MagicMock()
    schemas = schemas_are if schemas_are is not None else []
    privs = database_privs if database_privs is not None else []

    with (
        patch("src.module_types.database.get_schemas_are", return_value=schemas),
        patch("src.module_types.database.get_database_privs", return_value=privs),
    ):
        write_tests(buf, cursor, database_name=database_name, owner_is=owner_is)

    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_role_always_written():
    out = call_write_tests(owner_is="alice")
    assert "SELECT has_role('alice'," in out


def test_db_owner_is_always_written():
    out = call_write_tests(database_name="mydb", owner_is="alice")
    assert "SELECT db_owner_is('mydb', 'alice'," in out


def test_schemas_are_written_with_data():
    out = call_write_tests(database_name="mydb", schemas_are=["public", "private"])
    assert "SELECT schemas_are(" in out
    assert "'public'" in out
    assert "'private'" in out


def test_with_database_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(database_privs=[PrivRow("dbo", ["CONNECT"])])
    assert "SELECT database_privs_are(" in out


def test_with_no_database_privs_omits_privs_are():
    out = call_write_tests(database_privs=[])
    assert "SELECT database_privs_are(" not in out


def test_database_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(database_privs=[PrivRow("dbo", ["CONNECT", "TEMPORARY"])])
    assert "'dbo'" in out
    assert "'CONNECT'" in out
    assert "'TEMPORARY'" in out
