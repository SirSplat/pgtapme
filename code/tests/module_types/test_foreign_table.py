import io
from src.module_types.foreign_table import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        ft_schema="public",
        ft_name="my_ft",
        ft_owner="alice",
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(ft_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_foreign_table_always_written():
    out = call_write_tests(ft_schema="public", ft_name="my_ft")
    assert "SELECT has_foreign_table('public', 'my_ft'," in out


def test_has_role_always_written():
    out = call_write_tests(ft_owner="bob")
    assert "SELECT has_role('bob'," in out


def test_foreign_table_owner_is_always_written():
    out = call_write_tests(ft_schema="public", ft_name="my_ft", ft_owner="alice")
    assert "SELECT foreign_table_owner_is('public', 'my_ft', 'alice'," in out
