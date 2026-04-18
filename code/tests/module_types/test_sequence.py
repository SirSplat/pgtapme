import io
from src.module_types.sequence import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        seq_schema="public",
        seq_name="my_seq",
        seq_owner="alice",
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(seq_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_sequence_always_written():
    out = call_write_tests(seq_schema="public", seq_name="my_seq")
    assert "SELECT has_sequence('public', 'my_seq'," in out


def test_has_role_always_written():
    out = call_write_tests(seq_owner="bob")
    assert "SELECT has_role('bob'," in out


def test_sequence_owner_is_always_written():
    out = call_write_tests(seq_schema="public", seq_name="my_seq", seq_owner="alice")
    assert "SELECT sequence_owner_is('public', 'my_seq', 'alice'," in out


def test_with_sequence_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(privs_are=[PrivRow("dbo", ["USAGE", "SELECT"])])
    assert "SELECT sequence_privs_are(" in out


def test_with_no_sequence_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT sequence_privs_are(" not in out


def test_sequence_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(seq_schema="public", seq_name="my_seq", privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "'dbo'" in out
    assert "'USAGE'" in out
