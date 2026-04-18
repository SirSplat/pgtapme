import io
from src.module_types.index import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        schema_name="public",
        table_name="my_table",
        index_name="my_idx",
        owner_is="alice",
        index_columns=["id"],
        column_names=["id"],
        is_unique=False,
        is_primary_key=False,
        is_clustered=False,
        index_type="btree",
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


def test_has_column_for_each_column_name():
    out = call_write_tests(schema_name="public", table_name="my_table", column_names=["id", "name"])
    assert "SELECT has_column('public', 'my_table', 'id'," in out
    assert "SELECT has_column('public', 'my_table', 'name'," in out


def test_has_role_always_written():
    out = call_write_tests(owner_is="bob")
    assert "SELECT has_role('bob'," in out


def test_index_owner_is_always_written():
    out = call_write_tests(schema_name="public", table_name="my_table", index_name="my_idx", owner_is="alice")
    assert "SELECT index_owner_is('public', 'my_table', 'my_idx', 'alice'," in out


def test_primary_key_true_writes_index_is_primary():
    out = call_write_tests(is_primary_key=True)
    assert "SELECT index_is_primary(" in out


def test_primary_key_false_omits_index_is_primary():
    out = call_write_tests(is_primary_key=False)
    assert "SELECT index_is_primary(" not in out


def test_unique_true_writes_index_is_unique():
    out = call_write_tests(is_unique=True)
    assert "SELECT index_is_unique(" in out


def test_unique_false_omits_index_is_unique():
    out = call_write_tests(is_unique=False)
    assert "SELECT index_is_unique(" not in out


def test_clustered_true_writes_is_clustered():
    out = call_write_tests(is_clustered=True)
    assert "SELECT is_clustered(" in out


def test_clustered_false_omits_is_clustered():
    out = call_write_tests(is_clustered=False)
    assert "SELECT is_clustered(" not in out


def test_index_type_is_always_written():
    out = call_write_tests(index_name="my_idx", index_type="hash")
    assert "SELECT index_is_type(" in out
    assert "'hash'" in out


def test_no_columns_writes_no_has_column():
    out = call_write_tests(column_names=[])
    assert "SELECT has_column(" not in out
