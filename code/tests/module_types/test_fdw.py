import io
from collections import namedtuple
from src.module_types.fdw import write_tests

PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        fdw_name="postgres_fdw",
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_fdw_name_appears_when_privs_present():
    out = call_write_tests(fdw_name="postgres_fdw", privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "postgres_fdw" in out


def test_with_fdw_privs_writes_privs_are():
    out = call_write_tests(privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "SELECT fdw_privs_are(" in out


def test_with_no_fdw_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT fdw_privs_are(" not in out


def test_fdw_privs_role_and_privileges_appear():
    out = call_write_tests(fdw_name="postgres_fdw", privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "'dbo'" in out
    assert "'USAGE'" in out
