import logging
from io import TextIOWrapper
from typing import List, TextIO

from src.getters.get_catalog_data import get_view_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_role,
    write_has_schema,
    write_has_view,
    write_tests_footer,
    write_tests_header,
    write_view_owner_is,
)


@log_function_call(
    log_level=logging.INFO, info_message="TODO: Sort out the dependant table query!"
)
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_view_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.view_schema,
            "views",
            data.view_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    view_schema=data.view_schema,
                    view_name=data.view_name,
                    owner_is=data.view_owner,
                    table_info=data.table_info,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    view_schema: str,
    view_name: str,
    owner_is: str,
    table_info: List[str],
) -> None:
    write_tests_header(f)

    write_has_schema(f, view_schema)
    write_has_view(f, view_schema, view_name)
    write_has_role(f, owner_is)
    write_view_owner_is(f, view_schema, view_name, owner_is)

    write_tests_footer(f)
