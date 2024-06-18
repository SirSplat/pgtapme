import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_foreign_table_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_foreign_table_owner_is,
    write_has_foreign_table,
    write_has_role,
    write_has_schema,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_foreign_table_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.ft_schema,
            "foreign_tables",
            data.ft_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    ft_schema=data.ft_schema,
                    ft_name=data.ft_name,
                    ft_owner=data.ft_owner,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(f: TextIOWrapper, ft_schema: str, ft_name: str, ft_owner: str) -> None:
    write_tests_header(f)

    write_has_schema(f, ft_schema)
    write_has_foreign_table(f, ft_schema, ft_name)
    write_has_role(f, ft_owner)
    write_foreign_table_owner_is(f, ft_schema, ft_name, ft_owner)

    write_tests_footer(f)
