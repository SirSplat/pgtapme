import io
from src.module_types.acl import write_tests


def test_output_starts_with_begin():
    buf = io.StringIO()
    write_tests(buf)
    assert buf.getvalue().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    buf = io.StringIO()
    write_tests(buf)
    assert buf.getvalue().endswith("ROLLBACK;\n")
