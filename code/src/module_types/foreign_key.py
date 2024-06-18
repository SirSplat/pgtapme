import logging
from typing import TextIO, List
from io import TextIOWrapper
from src.helpers import set_plan_count, create_file_path, log_function_call
from src.getters.get_catalog_data import get_foreign_key_info
from src.writers.write_pgtap_tests import (
    write_tests_header,
    write_has_schema,
    write_has_table,
    write_has_column,
    write_fk_ok,
    write_tests_footer,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_foreign_key_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.fk_schema,
            "tables",
            data.fk_table,
            "foreign_key",
            data.fk_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    fk_schema=data.fk_schema,
                    fk_table=data.fk_table,
                    fk_name=data.fk_name,
                    fk_columns=data.fk_columns,
                    pk_schema=data.pk_schema,
                    pk_table=data.pk_table,
                    pk_columns=data.pk_columns,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    fk_schema: str,
    fk_table: str,
    fk_name: str,
    fk_columns: List[str],
    pk_schema: str,
    pk_table: str,
    pk_columns: List[str],
) -> None:
    write_tests_header(f)

    write_has_schema(f, fk_schema)
    write_has_table(f, fk_schema, fk_table)

    for column in fk_columns:
        write_has_column(f, fk_schema, fk_table, column)

    write_has_schema(f, pk_schema)
    write_has_table(f, pk_schema, pk_table)

    for column in pk_columns:
        write_has_column(f, pk_schema, pk_table, column)

    write_fk_ok(
        f, fk_schema, fk_table, fk_columns, pk_schema, pk_table, pk_columns, fk_name
    )

    write_tests_footer(f)
