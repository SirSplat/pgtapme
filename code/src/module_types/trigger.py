import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_trigger_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_function,
    write_has_schema,
    write_has_table,
    write_has_trigger,
    write_tests_footer,
    write_tests_header,
    write_trigger_is,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_trigger_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.trg_schema,
            "tables",
            data.trg_table,
            "triggers",
            data.trg_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    trg_schema=data.trg_schema,
                    trg_table=data.trg_table,
                    trg_name=data.trg_name,
                    trg_function_schema=data.trg_function_schema,
                    trg_function=data.trg_function,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    trg_schema: str,
    trg_table: str,
    trg_name: str,
    trg_function_schema: str,
    trg_function: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, trg_schema)
    write_has_table(f, trg_schema, trg_table)

    write_has_schema(f, trg_function_schema)
    write_has_function(f, trg_function_schema, trg_function)

    write_has_trigger(f, trg_schema, trg_table, trg_name)
    write_trigger_is(
        f, trg_schema, trg_table, trg_name, trg_function_schema, trg_function
    )

    write_tests_footer(f)
