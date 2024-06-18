import logging
from io import TextIOWrapper
from typing import List, TextIO

from src.getters.get_catalog_data import get_role_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_has_role,
    write_is_member_of,
    write_is_superuser,
    write_isnt_member_of,
    write_isnt_superuser,
    write_tests_footer,
    write_tests_header,
)


@log_function_call(
    log_level=logging.INFO,
    info_message="TODO: Need to work out how to get roles that do not have members, populate a members containg all roles",
)
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_role_info(cursor):
        file_path = create_file_path(output_dir, "cluster", module_type, data.role_name)

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    role_name=data.role_name,
                    is_superuser=data.is_superuser,
                    members=data.members,
                    not_members=data.not_members,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(
    f: TextIOWrapper,
    role_name: str,
    is_superuser: str,
    members: List[str],
    not_members: List[str],
) -> None:
    write_tests_header(f)

    write_has_role(f, role_name)

    if is_superuser:
        write_is_superuser(f, role_name)
    else:
        write_isnt_superuser(f, role_name)

    # if members:
    #     write_is_member_of(f, role_name, members)
    # else:
    #     write_isnt_member_of(f, role_name, not_members)

    write_tests_footer(f)
