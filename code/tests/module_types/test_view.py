import io
from src.module_types.view import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        view_schema="public",
        view_name="my_view",
        owner_is="alice",
        table_info=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(view_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_view_always_written():
    out = call_write_tests(view_schema="public", view_name="my_view")
    assert "SELECT has_view('public', 'my_view'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="bob")
    assert "SELECT has_role('bob'," in out


def test_view_owner_is_always_written():
    out = call_write_tests(view_schema="public", view_name="my_view", owner_is="alice")
    assert "SELECT view_owner_is('public', 'my_view', 'alice'," in out
