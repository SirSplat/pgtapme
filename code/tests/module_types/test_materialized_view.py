import io
from src.module_types.materialized_view import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        mtv_schema="public",
        mtv_name="my_mtv",
        mtv_owner="alice",
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(mtv_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_materialized_view_always_written():
    out = call_write_tests(mtv_schema="public", mtv_name="my_mtv")
    assert "SELECT has_materialized_view('public', 'my_mtv'," in out


def test_has_role_always_written():
    out = call_write_tests(mtv_owner="bob")
    assert "SELECT has_role('bob'," in out


def test_materialized_view_owner_is_always_written():
    out = call_write_tests(mtv_schema="public", mtv_name="my_mtv", mtv_owner="alice")
    assert "SELECT materialized_view_owner_is('public', 'my_mtv', 'alice'," in out
