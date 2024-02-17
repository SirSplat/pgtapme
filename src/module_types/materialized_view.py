import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_materialized_view_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_materialized_view,
    write_has_role,
    write_has_schema,
    write_materialized_view_owner_is,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_materialized_view_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.mtv_schema,
            "materialized_views",
            data.mtv_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    mtv_schema=data.mtv_schema,
                    mtv_name=data.mtv_name,
                    mtv_owner=data.mtv_owner,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(f: TextIOWrapper, mtv_schema: str, mtv_name: str, mtv_owner: str) -> None:
    write_tests_header(f)

    write_has_schema(f, mtv_schema)
    write_has_materialized_view(f, mtv_schema, mtv_name)
    write_has_role(f, mtv_owner)
    write_materialized_view_owner_is(f, mtv_schema, mtv_name, mtv_owner)

    write_tests_footer(f)
