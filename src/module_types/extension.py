import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_extension_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_extension,
    write_has_schema,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_extension_info(cursor):
        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.schema_name,
            "extensions",
            data.extension_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f, schema_name=data.schema_name, extension_name=data.extension_name
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(f: TextIOWrapper, schema_name: str, extension_name: str) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_extension(f, schema_name, extension_name)

    write_tests_footer(f)
