import io
from src.module_types.foreign_key import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        fk_schema="public",
        fk_table="orders",
        fk_name="fk_orders_customer",
        fk_columns=["customer_id"],
        pk_schema="public",
        pk_table="customers",
        pk_columns=["id"],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_has_schema_for_fk_table_always_written():
    out = call_write_tests(fk_schema="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_table_for_fk_table_always_written():
    out = call_write_tests(fk_schema="public", fk_table="orders")
    assert "SELECT has_table('public', 'orders'," in out


def test_has_column_for_each_fk_column():
    out = call_write_tests(fk_schema="public", fk_table="orders", fk_columns=["customer_id", "order_type"])
    assert "SELECT has_column('public', 'orders', 'customer_id'," in out
    assert "SELECT has_column('public', 'orders', 'order_type'," in out


def test_has_schema_for_pk_table_always_written():
    out = call_write_tests(pk_schema="other_schema")
    assert "SELECT has_schema('other_schema'," in out


def test_has_table_for_pk_table_always_written():
    out = call_write_tests(pk_schema="public", pk_table="customers")
    assert "SELECT has_table('public', 'customers'," in out


def test_has_column_for_each_pk_column():
    out = call_write_tests(pk_schema="public", pk_table="customers", pk_columns=["id", "type"])
    assert "SELECT has_column('public', 'customers', 'id'," in out
    assert "SELECT has_column('public', 'customers', 'type'," in out


def test_fk_ok_always_written():
    out = call_write_tests(
        fk_schema="public", fk_table="orders", fk_columns=["customer_id"],
        pk_schema="public", pk_table="customers", pk_columns=["id"],
    )
    assert "SELECT fk_ok('public', 'orders', ARRAY['customer_id']::TEXT[], 'public', 'customers', ARRAY['id']::TEXT[]," in out


def test_is_indexed_emitted_for_single_column_fk():
    out = call_write_tests(
        fk_schema="public", fk_table="orders", fk_columns=["customer_id"],
        fk_columns_ordered=["customer_id"],
    )
    assert (
        "SELECT is_indexed('public', 'orders', ARRAY['customer_id']::TEXT[], "
        "'FK column(s) public.orders(customer_id) should be indexed.');" in out
    )


def test_is_indexed_not_emitted_for_multi_column_fk():
    # Multi-column FKs are covered by the prefix-tolerant covering-index query
    # in the schema_lint module type, not by is_indexed (which would
    # false-positive on a wider prefix index). See Silas design call 1.
    out = call_write_tests(
        fk_schema="public", fk_table="orders", fk_columns=["a", "b"],
        fk_columns_ordered=["a", "b"],
    )
    assert "is_indexed" not in out


def test_is_indexed_falls_back_to_fk_columns_when_ordered_absent():
    # Backward compatibility: if fk_columns_ordered is not supplied, the
    # single-column emission still works off fk_columns.
    out = call_write_tests(
        fk_schema="public", fk_table="orders", fk_columns=["customer_id"],
    )
    assert "SELECT is_indexed('public', 'orders', ARRAY['customer_id']::TEXT[]," in out
