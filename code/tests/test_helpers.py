import pytest
from src.helpers import format_array_parameter, format_single_quote, remove_schema


def test_none_returns_empty_array():
    assert format_array_parameter(None) == "ARRAY[]::TEXT[]"


def test_empty_list_returns_empty_array():
    assert format_array_parameter([]) == "ARRAY[]::TEXT[]"


def test_single_item_list():
    assert format_array_parameter(["plpgsql"]) == "ARRAY['plpgsql']::TEXT[]"


def test_multi_item_list():
    assert format_array_parameter(["plpgsql", "sql"]) == "ARRAY['plpgsql', 'sql']::TEXT[]"


def test_single_string():
    assert format_array_parameter("hello") == "ARRAY['hello']::TEXT[]"


def test_tuple_produces_valid_postgres_array_syntax():
    # Tuples can arrive from psycopg2 row results; output must be valid SQL ARRAY syntax
    assert format_array_parameter(("plpgsql", "sql")) == "ARRAY['plpgsql', 'sql']::TEXT[]"


def test_invalid_type_raises_type_error():
    with pytest.raises(TypeError):
        format_array_parameter(42)


def test_item_containing_single_quote_is_escaped():
    # Identifiers with single quotes must not break the generated SQL
    assert format_array_parameter(["O'Brien"]) == "ARRAY['O''Brien']::TEXT[]"


# ---------------------------------------------------------------------------
# format_single_quote
# ---------------------------------------------------------------------------

def test_format_single_quote_plain_string_wraps_in_single_quotes():
    assert format_single_quote("42") == "'42'"


def test_format_single_quote_true_boolean_default():
    assert format_single_quote("true") == "'true'"


def test_format_single_quote_nextval_wraps_in_dollar_quotes():
    assert format_single_quote("nextval('users_id_seq'::regclass)") == "$$nextval('users_id_seq'::regclass)$$"


def test_format_single_quote_now_without_embedded_quote_wraps_in_single_quotes():
    # now() has no embedded single quote, so plain wrapping applies
    assert format_single_quote("now()") == "'now()'"


def test_format_single_quote_now_with_embedded_quote_wraps_in_dollar_quotes():
    # dollar-quoting only triggers when the string already contains a single quote AND nextval/now
    assert format_single_quote("now('UTC'::text)") == "$$now('UTC'::text)$$"


def test_format_single_quote_string_with_quote_but_not_nextval_or_now_returns_as_is():
    # e.g. 'active'::my_enum — already SQL-literal, returned unchanged
    assert format_single_quote("'active'::my_enum") == "'active'::my_enum"


def test_format_single_quote_non_string_raises_type_error():
    with pytest.raises(TypeError):
        format_single_quote(42)


# ---------------------------------------------------------------------------
# remove_schema
# ---------------------------------------------------------------------------

def test_remove_schema_strips_schema_prefix():
    assert remove_schema("dvdrental.year") == "year"


def test_remove_schema_no_dot_returns_unchanged():
    assert remove_schema("integer") == "integer"


def test_remove_schema_multiple_dots_returns_last_part():
    assert remove_schema("a.b.c") == "c"


def test_remove_schema_empty_string_returns_empty_string():
    assert remove_schema("") == ""
