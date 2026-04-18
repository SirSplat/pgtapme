import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_foreign_server_info, get_server_privs
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_server_privs_are,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_foreign_server_info(cursor):
        file_path = create_file_path(output_dir, "cluster", module_type, data.server_name)

        privs = get_server_privs(cursor, data.server_name)

        try:
            with open(file_path, "w") as f:
                write_tests(f, server_name=data.server_name, privs_are=privs)
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(f: TextIOWrapper, server_name: str, privs_are=None) -> None:
    write_tests_header(f)

    for priv in (privs_are or []):
        write_server_privs_are(f, server_name, priv.role_name, priv.privileges)

    write_tests_footer(f)
