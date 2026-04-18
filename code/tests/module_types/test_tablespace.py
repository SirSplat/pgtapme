import io
from src.module_types.tablespace import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        tablespace_name="pg_default",
        owner_is="postgres",
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_tablespace_always_written():
    out = call_write_tests(tablespace_name="my_ts")
    assert "SELECT has_tablespace('my_ts'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="bob")
    assert "SELECT has_role('bob'," in out


def test_tablespace_owner_is_always_written():
    out = call_write_tests(tablespace_name="my_ts", owner_is="alice")
    assert "SELECT tablespace_owner_is('my_ts', 'alice'," in out


def test_with_tablespace_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(privs_are=[PrivRow("dbo", ["CREATE"])])
    assert "SELECT tablespace_privs_are(" in out


def test_with_no_tablespace_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT tablespace_privs_are(" not in out


def test_tablespace_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(tablespace_name="pg_default", privs_are=[PrivRow("dbo", ["CREATE"])])
    assert "'dbo'" in out
    assert "'CREATE'" in out
