import io
from src.module_types.rule import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        schema_name="public",
        table_name="my_table",
        rule_name="my_rule",
        is_instead=False,
        is_on="",
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


def test_has_table_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table")
    assert "SELECT has_table('public', 'my_table'," in out


def test_has_rule_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", rule_name="my_rule")
    assert "SELECT has_rule('public', 'my_table', 'my_rule'," in out


def test_is_instead_true_writes_rule_is_instead():
    out = call_write_tests(is_instead=True)
    assert "SELECT rule_is_instead(" in out


def test_is_instead_false_omits_rule_is_instead():
    out = call_write_tests(is_instead=False)
    assert "SELECT rule_is_instead(" not in out


def test_is_on_truthy_writes_rule_is_on():
    out = call_write_tests(is_on="INSERT")
    assert "SELECT rule_is_on(" in out
    assert "'INSERT'" in out


def test_is_on_empty_omits_rule_is_on():
    out = call_write_tests(is_on="")
    assert "SELECT rule_is_on(" not in out
