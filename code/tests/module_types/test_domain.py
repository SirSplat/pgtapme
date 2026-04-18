import io
from src.module_types.domain import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        typ_schema="public",
        typ_name="my_domain",
        typ_owner="alice",
        dt_schema="pg_catalog",
        dt_name="integer",
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_for_type_schema_always_written():
    out = call_write_tests(typ_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_domain_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_domain")
    assert "SELECT has_domain('public', 'my_domain'," in out


def test_has_role_always_written():
    out = call_write_tests(typ_owner="bob")
    assert "SELECT has_role('bob'," in out


def test_type_owner_is_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_domain", typ_owner="alice")
    assert "SELECT type_owner_is('public', 'my_domain', 'alice'," in out


def test_has_schema_for_data_type_schema_always_written():
    out = call_write_tests(dt_schema="pg_catalog")
    assert out.count("SELECT has_schema('pg_catalog',") == 1


def test_domain_type_is_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_domain", dt_schema="pg_catalog", dt_name="integer")
    assert "SELECT domain_type_is('public', 'my_domain', 'pg_catalog', 'integer'," in out
