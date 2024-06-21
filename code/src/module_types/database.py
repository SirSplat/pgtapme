import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_database_info, get_schemas_are
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_db_owner_is,
    write_has_role,
    write_schemas_are,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_database_info(cursor):
        file_path = create_file_path(
            output_dir, "databases", data.database_name, data.database_name
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f, cursor, database_name=data.database_name, owner_is=data.owner_is
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(
    f: TextIOWrapper, cursor: TextIO, database_name: str, owner_is: str
) -> None:
    write_tests_header(f)

    write_has_role(f, owner_is)
    write_db_owner_is(f, database_name, owner_is)

    data = get_schemas_are(cursor)
    write_schemas_are(f, database_name, data)

    write_tests_footer(f)
