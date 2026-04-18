import io
from src.writers.write_pgtap_tests import write_has_foreign_table


def test_write_has_foreign_table_calls_has_foreign_table_not_has_materialized_view():
    buf = io.StringIO()
    write_has_foreign_table(buf, "public", "ext_tbl")
    result = buf.getvalue()
    assert "has_foreign_table" in result
    assert "has_materialized_view" not in result
