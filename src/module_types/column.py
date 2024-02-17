import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_column_info
from src.helpers import (
    create_file_path,
    format_single_quote,
    log_function_call,
    remove_schema,
    set_plan_count,
)
from src.writers.write_pgtap_tests import (
    write_col_default_is,
    write_col_has_default,
    write_col_hasnt_default,
    write_col_is_null,
    write_col_not_null,
    write_col_type_is,
    write_has_column,
    write_has_schema,
    write_has_table,
    write_has_type,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_column_info(cursor):
        if not data:
            logging.error("There was a problem with the column data: %s", data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.schema_name,
            "tables",
            data.table_name,
            "columns",
            data.column_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    schema_name=data.schema_name,
                    table_name=data.table_name,
                    column_name=data.column_name,
                    is_nullable=data.is_nullable,
                    has_default=data.has_default,
                    dt_schema=data.type_schema,
                    dt_type=data.dt_type,
                    type_name=data.type_name,
                    column_default=data.column_default,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    column_name: str,
    is_nullable: str,
    has_default: str,
    dt_schema: str,
    dt_type: str,
    type_name: str,
    column_default: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_table(f, schema_name, table_name)
    write_has_column(f, schema_name, table_name, column_name)

    write_has_schema(f, dt_schema)
    write_has_type(f, dt_schema, type_name)

    if is_nullable:
        write_col_not_null(f, schema_name, table_name, column_name)
    else:
        write_col_is_null(f, schema_name, table_name, column_name)
    if has_default:
        write_col_has_default(f, schema_name, table_name, column_name)

        if column_default:
            column_default = format_single_quote(column_default)
            write_col_default_is(
                f, schema_name, table_name, column_name, column_default
            )
    else:
        write_col_hasnt_default(f, schema_name, table_name, column_name)

    """
    Need to remove schema qualification from dt_type as returned by PostgerSQl format_type i.e.
        'dvdrental.year' should endup as 'year' as this is what the PGTap tests are looking for!
    """
    write_col_type_is(
        f, schema_name, table_name, column_name, dt_schema, remove_schema(dt_type)
    )

    write_tests_footer(f)
