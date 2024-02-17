import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_acl_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import write_tests_footer, write_tests_header


@log_function_call(log_level=logging.INFO, info_message="TODO: Implementation pending!")
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    return
    for data in get_acl_info(cursor):
        if not data:
            logging.error(f"There was a problem with the {test_type}, {data}")
            return

        test_file_path = create_file_path(output_dir, "???")

        try:
            with open(test_file_path, "w") as f:
                write_tests(f)
        except Exception as e:
            logging.error(f"Failed to generate tests for {test_type}: {e}.")

        set_plan_count(test_file_path)


@log_function_call
def write_tests(f: TextIOWrapper) -> None:
    write_tests_header(f)

    pass

    write_tests_footer(f)
