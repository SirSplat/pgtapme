import io
from src.module_types.role import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        role_name="myrole",
        is_superuser=False,
        members=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_role_always_written():
    out = call_write_tests(role_name="myrole")
    assert "SELECT has_role('myrole'," in out


def test_superuser_true_writes_is_superuser():
    out = call_write_tests(is_superuser=True)
    assert "SELECT is_superuser(" in out
    assert "SELECT isnt_superuser(" not in out


def test_superuser_false_writes_isnt_superuser():
    out = call_write_tests(is_superuser=False)
    assert "SELECT isnt_superuser(" in out
    assert "SELECT is_superuser(" not in out


# ---------------------------------------------------------------------------
# Role membership
# ---------------------------------------------------------------------------

def test_with_members_writes_is_member_of():
    out = call_write_tests(members=["analysts"])
    assert "SELECT is_member_of(" in out


def test_member_names_appear_in_output():
    out = call_write_tests(members=["analysts", "managers"])
    assert "'analysts'" in out
    assert "'managers'" in out


def test_with_empty_members_omits_is_member_of():
    out = call_write_tests(members=[])
    assert "SELECT is_member_of(" not in out


def test_with_null_members_omits_is_member_of():
    # ARRAY_AGG returns [None] when no rows match — must not produce SQL
    out = call_write_tests(members=[None])
    assert "SELECT is_member_of(" not in out
