import io
from src.module_types.enum import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        typ_schema="public",
        typ_name="my_enum",
        typ_owner="alice",
        typ_label=["active", "inactive"],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(typ_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_role_always_written():
    out = call_write_tests(typ_owner="bob")
    assert "SELECT has_role('bob'," in out


def test_type_owner_is_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_enum", typ_owner="alice")
    assert "SELECT type_owner_is('public', 'my_enum', 'alice'," in out


def test_has_enum_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_enum")
    assert "SELECT has_enum('public', 'my_enum'," in out


def test_enum_has_labels_always_written():
    out = call_write_tests(typ_schema="public", typ_name="my_enum", typ_label=["active", "inactive"])
    assert "SELECT enum_has_labels('public', 'my_enum', ARRAY['active', 'inactive']::TEXT[]," in out
