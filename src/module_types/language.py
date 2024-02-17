import logging
from typing import TextIO
from io import TextIOWrapper

from src.getters.get_catalog_data import get_languages_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_language,
    write_has_role,
    write_language_is_trusted,
    write_language_owner_is,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_languages_info(cursor):
        file_path = create_file_path(
            output_dir, "cluster", module_type, data.language_name
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    language_name=data.language_name,
                    owner_is=data.owner_is,
                    is_trusted=data.is_trusted,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(f: TextIOWrapper, language_name: str, owner_is: str, is_trusted: str) -> None:
    write_tests_header(f)

    write_has_language(f, language_name)
    write_has_role(f, owner_is)
    write_language_owner_is(f, language_name, owner_is)

    if is_trusted:
        write_language_is_trusted(f, language_name)

    write_tests_footer(f)
