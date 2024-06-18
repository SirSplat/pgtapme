import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import (
    get_casts_are,
    get_groups_are,
    get_languages_are,
    get_roles_are,
    get_tablespaces_are,
    get_users_are,
)
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_casts_are,
    write_groups_are,
    write_languages_are,
    write_roles_are,
    write_tablespaces_are,
    write_tests_footer,
    write_tests_header,
    write_users_are,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    test_file_path = create_file_path(output_dir, module_type, "cluster")

    try:
        with open(test_file_path, "w") as f:
            write_tests(f, cursor)
    except Exception as e:
        logging.error(f"Failed to generate tests for {module_type}: {e}.")

    set_plan_count(test_file_path)


def write_tests(f: TextIOWrapper, cursor: TextIO) -> None:
    write_tests_header(f)

    data = get_tablespaces_are(cursor)
    write_tablespaces_are(f, data)

    data = get_roles_are(cursor)
    write_roles_are(f, data)

    data = get_groups_are(cursor)
    write_groups_are(f, data)

    data = get_users_are(cursor)
    write_users_are(f, data)

    data = get_languages_are(cursor)
    write_languages_are(f, data)

    data = get_casts_are(cursor)
    write_casts_are(f, data)

    write_tests_footer(f)
