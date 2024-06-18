import logging
from io import TextIOWrapper
from typing import List, TextIO

from src.getters.get_catalog_data import get_enum_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_enum_has_labels,
    write_has_enum,
    write_has_role,
    write_has_schema,
    write_tests_footer,
    write_tests_header,
    write_type_owner_is,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_enum_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.typ_schema,
            "data_type",
            module_type,
            data.typ_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    typ_schema=data.typ_schema,
                    typ_name=data.typ_name,
                    typ_owner=data.typ_owner,
                    typ_label=data.typ_enum_label,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    typ_schema: str,
    typ_name: str,
    typ_owner: str,
    typ_label: List[str],
) -> None:
    write_tests_header(f)

    write_has_schema(f, typ_schema)
    write_has_role(f, typ_owner)
    write_type_owner_is(f, typ_schema, typ_name, typ_owner)
    write_has_enum(f, typ_schema, typ_name)
    write_enum_has_labels(f, typ_schema, typ_name, typ_label)

    write_tests_footer(f)
