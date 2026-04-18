import io
from src.module_types.trigger import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        trg_schema="public",
        trg_table="my_table",
        trg_name="my_trigger",
        trg_function_schema="public",
        trg_function="my_trigger_fn",
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_for_table_always_written():
    out = call_write_tests(trg_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_table_always_written():
    out = call_write_tests(trg_schema="public", trg_table="my_table")
    assert "SELECT has_table('public', 'my_table'," in out


def test_has_schema_for_function_always_written():
    out = call_write_tests(trg_function_schema="fn_schema")
    assert "SELECT has_schema('fn_schema'," in out


def test_has_function_always_written():
    out = call_write_tests(trg_function_schema="public", trg_function="my_trigger_fn")
    assert "SELECT has_function('public', 'my_trigger_fn'," in out


def test_has_trigger_always_written():
    out = call_write_tests(trg_schema="public", trg_table="my_table", trg_name="my_trigger")
    assert "SELECT has_trigger('public', 'my_table', 'my_trigger'," in out


def test_trigger_is_always_written():
    out = call_write_tests(
        trg_schema="public",
        trg_table="my_table",
        trg_name="my_trigger",
        trg_function_schema="public",
        trg_function="my_trigger_fn",
    )
    assert "SELECT trigger_is('public', 'my_table', 'my_trigger', 'public', 'my_trigger_fn'," in out
