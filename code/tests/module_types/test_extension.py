import io
from src.module_types.extension import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        schema_name="public",
        extension_name="btree_gist",
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_always_written():
    out = call_write_tests(schema_name="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_extension_always_written():
    out = call_write_tests(schema_name="public", extension_name="btree_gist")
    assert "SELECT has_extension('public', 'btree_gist'," in out
