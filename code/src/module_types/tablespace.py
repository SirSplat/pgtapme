import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_tablespace_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_role,
    write_has_tablespace,
    write_tablespace_owner_is,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_tablespace_info(cursor):
        file_path = create_file_path(
            output_dir, "cluster", module_type, data.tablespace_name
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f, tablespace_name=data.tablespace_name, owner_is=data.owner_is
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(f: TextIOWrapper, tablespace_name: str, owner_is: str) -> None:
    write_tests_header(f)

    write_has_tablespace(f, tablespace_name)
    write_has_role(f, owner_is)
    write_tablespace_owner_is(f, tablespace_name, owner_is)

    write_tests_footer(f)
