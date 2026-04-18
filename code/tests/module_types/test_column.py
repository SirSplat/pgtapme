import io
from src.module_types.column import write_tests


def call_write_tests(**kwargs):
    buf = io.StringIO()
    defaults = dict(
        schema_name="public",
        table_name="users",
        column_name="name",
        is_nullable=True,
        has_default=False,
        dt_schema="pg_catalog",
        dt_type="text",
        type_name="text",
        column_default=None,
        privs_are=[],
    )
    defaults.update(kwargs)
    write_tests(buf, **defaults)
    return buf.getvalue()


# ---------------------------------------------------------------------------
# Header and footer always present
# ---------------------------------------------------------------------------

def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


# ---------------------------------------------------------------------------
# Schema / table / column existence always written
# ---------------------------------------------------------------------------

def test_has_schema_for_table_schema_always_written():
    out = call_write_tests(schema_name="myschema")
    assert "SELECT has_schema('myschema'," in out


def test_has_table_always_written():
    out = call_write_tests(schema_name="myschema", table_name="mytable")
    assert "SELECT has_table('myschema', 'mytable'," in out


def test_has_column_always_written():
    out = call_write_tests(schema_name="myschema", table_name="mytable", column_name="mycol")
    assert "SELECT has_column('myschema', 'mytable', 'mycol'," in out


# ---------------------------------------------------------------------------
# Type schema and type name always written
# ---------------------------------------------------------------------------

def test_has_schema_for_type_schema_always_written():
    out = call_write_tests(dt_schema="pg_catalog")
    assert out.count("SELECT has_schema('pg_catalog',") == 1


def test_has_type_always_written():
    out = call_write_tests(dt_schema="pg_catalog", type_name="text")
    assert "SELECT has_type('pg_catalog', 'text'," in out


# ---------------------------------------------------------------------------
# col_type_is always written, schema prefix stripped from dt_type
# ---------------------------------------------------------------------------

def test_col_type_is_written_with_plain_type():
    out = call_write_tests(dt_schema="pg_catalog", dt_type="integer", type_name="int4")
    assert "SELECT col_type_is('public', 'users', 'name', 'pg_catalog', 'integer'," in out


def test_col_type_is_strips_schema_prefix_from_dt_type():
    out = call_write_tests(dt_schema="dvdrental", dt_type="dvdrental.year", type_name="year")
    assert "SELECT col_type_is('public', 'users', 'name', 'dvdrental', 'year'," in out


# ---------------------------------------------------------------------------
# Nullability — is_nullable here is attnotnull (True = NOT NULL constraint)
# ---------------------------------------------------------------------------

def test_not_null_column_writes_col_not_null():
    out = call_write_tests(is_nullable=True)
    assert "SELECT col_not_null(" in out
    assert "SELECT col_is_null(" not in out


def test_nullable_column_writes_col_is_null():
    out = call_write_tests(is_nullable=False)
    assert "SELECT col_is_null(" in out
    assert "SELECT col_not_null(" not in out


# ---------------------------------------------------------------------------
# Default — no default
# ---------------------------------------------------------------------------

def test_no_default_writes_col_hasnt_default():
    out = call_write_tests(has_default=False, column_default=None)
    assert "SELECT col_hasnt_default(" in out
    assert "SELECT col_has_default(" not in out
    assert "SELECT col_default_is(" not in out


# ---------------------------------------------------------------------------
# Default — has default with plain value
# ---------------------------------------------------------------------------

def test_has_default_with_plain_value_writes_col_has_default_and_col_default_is():
    out = call_write_tests(has_default=True, column_default="42")
    assert "SELECT col_has_default(" in out
    assert "SELECT col_default_is('public', 'users', 'name', '42'," in out


# ---------------------------------------------------------------------------
# Default — has default with nextval (dollar-quoted)
# ---------------------------------------------------------------------------

def test_has_default_with_nextval_dollar_quotes_in_col_default_is():
    default = "nextval('users_id_seq'::regclass)"
    out = call_write_tests(has_default=True, column_default=default)
    assert "SELECT col_has_default(" in out
    assert f"SELECT col_default_is('public', 'users', 'name', $${default}$$," in out


# ---------------------------------------------------------------------------
# Default — has_default True but column_default is None (generated column)
# ---------------------------------------------------------------------------

def test_has_default_true_but_no_expression_writes_col_has_default_only():
    out = call_write_tests(has_default=True, column_default=None)
    assert "SELECT col_has_default(" in out
    assert "SELECT col_default_is(" not in out
    assert "SELECT col_hasnt_default(" not in out


def test_with_column_privs_writes_privs_are():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(privs_are=[PrivRow("dbo", ["SELECT"])])
    assert "SELECT column_privs_are(" in out


def test_with_no_column_privs_omits_privs_are():
    out = call_write_tests(privs_are=[])
    assert "SELECT column_privs_are(" not in out


def test_column_privs_role_and_privileges_appear():
    from collections import namedtuple
    PrivRow = namedtuple("PrivRow", ["role_name", "privileges"])
    out = call_write_tests(schema_name="public", table_name="users", column_name="email", privs_are=[PrivRow("dbo", ["SELECT", "UPDATE"])])
    assert "'dbo'" in out
    assert "'SELECT'" in out
    assert "'UPDATE'" in out
