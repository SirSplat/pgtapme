import io
from src.module_types.language import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        language_name="plpgsql",
        owner_is="postgres",
        is_trusted=True,
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_language_always_written():
    out = call_write_tests(language_name="plpgsql")
    assert "SELECT has_language('plpgsql'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="alice")
    assert "SELECT has_role('alice'," in out


def test_language_owner_is_always_written():
    out = call_write_tests(language_name="plpgsql", owner_is="postgres")
    assert "SELECT language_owner_is('plpgsql', 'postgres'," in out


def test_trusted_language_writes_language_is_trusted():
    out = call_write_tests(is_trusted=True)
    assert "SELECT language_is_trusted(" in out


def test_untrusted_language_omits_language_is_trusted():
    out = call_write_tests(is_trusted=False)
    assert "SELECT language_is_trusted(" not in out


def test_with_language_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "SELECT language_privs_are(" in out


def test_with_no_language_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT language_privs_are(" not in out


def test_language_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(language_name="plpgsql", privs_are=[PrivRow("dbo", ["USAGE"])])
    assert "'dbo'" in out
    assert "'USAGE'" in out
