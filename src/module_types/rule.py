import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_rule_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_rule,
    write_has_schema,
    write_has_table,
    write_rule_is_instead,
    write_rule_is_on,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_rule_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.schema_name,
            "tables",
            data.table_name,
            "rules",
            data.rule_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    schema_name=data.schema_name,
                    table_name=data.table_name,
                    rule_name=data.rule_name,
                    is_instead=data.is_instead,
                    is_on=data.dml_type,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    rule_name: str,
    is_instead: str,
    is_on: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_table(f, schema_name, table_name)
    write_has_rule(f, schema_name, table_name, rule_name)

    if is_instead:
        write_rule_is_instead(f, schema_name, table_name, rule_name)

    if is_on:
        write_rule_is_on(f, schema_name, table_name, rule_name, is_on)

    write_tests_footer(f)
