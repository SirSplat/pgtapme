import io
from src.module_types.function import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        pro_schema="public",
        pro_name="my_func",
        pro_owner="alice",
        pro_lang="plpgsql",
        is_strict=False,
        is_definer=False,
        pro_volatility="v",
        pro_kind="f",
        pro_returns="integer",
        pro_args=["integer", "text"],
        pro_signature="my_func(integer_text)",
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


# ---------------------------------------------------------------------------
# Header / footer
# ---------------------------------------------------------------------------

def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


# ---------------------------------------------------------------------------
# Always-written assertions
# ---------------------------------------------------------------------------

def test_has_schema_always_written():
    out = call_write_tests(pro_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_function_always_written():
    out = call_write_tests(pro_schema="public", pro_name="my_func", pro_args=["integer"])
    assert "SELECT has_function('public', 'my_func', ARRAY['integer']::TEXT[]," in out


def test_has_function_description_contains_signature_not_none():
    out = call_write_tests(pro_signature="my_func(integer_text)")
    assert "Function public.None" not in out
    assert "my_func(integer_text)" in out


def test_has_role_always_written():
    out = call_write_tests(pro_owner="alice")
    assert "SELECT has_role('alice'," in out


def test_function_owner_is_always_written():
    out = call_write_tests(pro_schema="public", pro_name="my_func", pro_owner="alice", pro_signature="my_func(integer_text)")
    assert "SELECT function_owner_is('public', 'my_func'," in out
    assert "'alice'" in out


def test_function_lang_is_always_written():
    out = call_write_tests(pro_lang="plpgsql", pro_signature="my_func(integer_text)")
    assert "SELECT function_lang_is(" in out
    assert "'plpgsql'" in out


def test_function_returns_always_written():
    out = call_write_tests(pro_returns="integer", pro_signature="my_func(integer_text)")
    assert "SELECT function_returns(" in out
    assert "'integer'" in out


def test_volatility_is_always_written():
    out = call_write_tests(pro_volatility="i", pro_signature="my_func(integer_text)")
    assert "SELECT volatility_is(" in out
    assert "'i'" in out


# ---------------------------------------------------------------------------
# Security definer / invoker
# ---------------------------------------------------------------------------

def test_is_definer_true_writes_is_definer():
    out = call_write_tests(is_definer=True)
    assert "SELECT is_definer(" in out
    assert "SELECT isnt_definer(" not in out


def test_is_definer_false_writes_isnt_definer():
    out = call_write_tests(is_definer=False)
    assert "SELECT isnt_definer(" in out
    assert "SELECT is_definer(" not in out


# ---------------------------------------------------------------------------
# Strictness
# ---------------------------------------------------------------------------

def test_is_strict_true_writes_is_strict():
    out = call_write_tests(is_strict=True)
    assert "SELECT is_strict(" in out
    assert "SELECT isnt_strict(" not in out


def test_is_strict_false_writes_isnt_strict():
    out = call_write_tests(is_strict=False)
    assert "SELECT isnt_strict(" in out
    assert "SELECT is_strict(" not in out


# ---------------------------------------------------------------------------
# Function kind — normal function
# ---------------------------------------------------------------------------

def test_normal_function_writes_is_normal_function_and_isnt_others():
    out = call_write_tests(pro_kind="f")
    assert "SELECT is_normal_function(" in out
    assert "SELECT isnt_aggregate(" in out
    assert "SELECT isnt_window(" in out
    assert "SELECT isnt_procedure(" in out


# ---------------------------------------------------------------------------
# Function kind — aggregate
# ---------------------------------------------------------------------------

def test_aggregate_writes_is_aggregate_and_isnt_others():
    out = call_write_tests(pro_kind="a")
    assert "SELECT is_aggregate(" in out
    assert "SELECT isnt_normal_function(" in out
    assert "SELECT isnt_window(" in out
    assert "SELECT isnt_procedure(" in out


# ---------------------------------------------------------------------------
# Function kind — window
# ---------------------------------------------------------------------------

def test_window_function_writes_is_window_and_isnt_others():
    out = call_write_tests(pro_kind="w")
    assert "SELECT is_window(" in out
    assert "SELECT isnt_normal_function(" in out
    assert "SELECT isnt_aggregate(" in out
    assert "SELECT isnt_procedure(" in out


# ---------------------------------------------------------------------------
# Function kind — procedure
# ---------------------------------------------------------------------------

def test_procedure_writes_is_procedure_and_isnt_others():
    out = call_write_tests(pro_kind="p")
    assert "SELECT is_procedure(" in out
    assert "SELECT isnt_normal_function(" in out
    assert "SELECT isnt_aggregate(" in out
    assert "SELECT isnt_window(" in out


# ---------------------------------------------------------------------------
# No-arg function
# ---------------------------------------------------------------------------

def test_no_arg_function_uses_empty_array():
    out = call_write_tests(pro_args=[], pro_signature="my_func()")
    assert "ARRAY[]::TEXT[]" in out


def test_with_function_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(privs_are=[PrivRow("dbo", ["EXECUTE"])])
    assert "SELECT function_privs_are(" in out


def test_with_no_function_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT function_privs_are(" not in out


def test_function_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(pro_schema="public", pro_name="my_func", pro_args=["integer"], privs_are=[PrivRow("dbo", ["EXECUTE"])])
    assert "'dbo'" in out
    assert "'EXECUTE'" in out
