import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import get_sequence_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_role,
    write_has_schema,
    write_has_sequence,
    write_sequence_owner_is,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_sequence_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.seq_schema,
            "sequences",
            data.seq_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    seq_schema=data.seq_schema,
                    seq_name=data.seq_name,
                    seq_owner=data.seq_owner,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper, seq_schema: str, seq_name: str, seq_owner: str
) -> None:
    write_tests_header(f)

    write_has_schema(f, seq_schema)
    write_has_sequence(f, seq_schema, seq_name)
    write_has_role(f, seq_owner)
    write_sequence_owner_is(f, seq_schema, seq_name, seq_owner)

    write_tests_footer(f)
