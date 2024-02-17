import logging
from typing import TextIO, List
from io import TextIOWrapper

from src.getters.get_catalog_data import get_index_info
from src.helpers import (
    create_file_path,
    format_directory_element,
    log_function_call,
    set_plan_count,
)
from src.writers.write_pgtap_tests import (
    write_has_column,
    write_has_index,
    write_has_role,
    write_has_schema,
    write_has_table,
    write_index_is_clustered,
    write_index_is_primary,
    write_index_is_unique,
    write_index_owner_is,
    write_index_type_is,
    write_tests_footer,
    write_tests_header,
)


@log_function_call(
    log_level=logging.INFO, info_message="TODO: Figure out the has_index quote thing!"
)
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_index_info(cursor):
        if not data:
            logging.error("There was a problem with the get_index_data: %s", data)
            return

        """
        Have to remove double quotes and spaces, they cause issues when used in
            creating directories and files.
        """
        dir_database_name = format_directory_element(data.database_name)
        dir_schema_name = format_directory_element(data.schema_name)
        dir_table_name = format_directory_element(data.table_name)
        dir_index_name = format_directory_element(data.index_name)

        file_path = create_file_path(
            output_dir,
            "databases",
            dir_database_name,
            "schemas",
            dir_schema_name,
            "tables",
            dir_table_name,
            "indexes",
            dir_index_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    schema_name=data.schema_name,
                    table_name=data.table_name,
                    index_name=data.index_name,
                    owner_is=data.owner_is,
                    index_columns=data.index_columns,
                    is_unique=data.is_unique,
                    is_primary_key=data.is_primary,
                    is_clustered=data.is_clustered,
                    index_type=data.index_type,
                    column_names=data.column_names,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    index_name: str,
    owner_is: str,
    index_columns: List[str],
    column_names: List[str],
    is_unique: str,
    is_primary_key: str,
    is_clustered: str,
    index_type: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_table(f, schema_name, table_name)

    """
    Have been forced to remove double quotes for this test "write_has_column"
        expects there to be none.
    """
    for column in column_names:
        write_has_column(f, schema_name, table_name, column)

    write_has_role(f, owner_is)
    # write_has_index(f, schema_name, table_name, index_name, index_columns)
    write_index_owner_is(f, schema_name, table_name, index_name, owner_is)

    if is_primary_key:
        write_index_is_primary(f, schema_name, table_name, index_name)

    if is_unique:
        write_index_is_unique(f, schema_name, table_name, index_name)

    if is_clustered:
        write_index_is_clustered(f, schema_name, table_name, index_name)

    write_index_type_is(f, schema_name, table_name, index_name, index_type)

    write_tests_footer(f)
