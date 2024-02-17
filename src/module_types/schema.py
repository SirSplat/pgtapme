import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import (
    get_domains_are,
    get_enums_are,
    get_extensions_are,
    get_foreign_tables_are,
    get_functions_are,
    get_materialized_views_are,
    get_opclasses_are,
    get_operators_are,
    get_schema_info,
    get_sequences_are,
    get_tables_are,
    get_types_are,
    get_views_are,
)
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_domains_are,
    write_enums_are,
    write_extensions_are,
    write_foreign_tables_are,
    write_functions_are,
    write_has_role,
    write_has_schema,
    write_materialized_views_are,
    write_opclasses_are,
    write_operators_are,
    write_schema_owner_is,
    write_sequences_are,
    write_tables_are,
    write_tests_footer,
    write_tests_header,
    write_types_are,
    write_views_are,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_schema_info(cursor):
        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.schema_name,
            data.schema_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f, cursor, schema_name=data.schema_name, owner_is=data.owner_is
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


def write_tests(
    f: TextIOWrapper, cursor: TextIO, schema_name: str, owner_is: str
) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_role(f, owner_is)
    write_schema_owner_is(f, schema_name, owner_is)

    data = get_tables_are(cursor, schema_name)
    write_tables_are(f, schema_name, data)

    data = get_foreign_tables_are(cursor, schema_name)
    write_foreign_tables_are(f, schema_name, data)

    data = get_views_are(cursor, schema_name)
    write_views_are(f, schema_name, data)

    data = get_materialized_views_are(cursor, schema_name)
    write_materialized_views_are(f, schema_name, data)

    data = get_sequences_are(cursor, schema_name)
    write_sequences_are(f, schema_name, data)

    data = get_functions_are(cursor, schema_name)
    write_functions_are(f, schema_name, data)

    data = get_opclasses_are(cursor, schema_name)
    write_opclasses_are(f, schema_name, data)

    data = get_types_are(cursor, schema_name)
    write_types_are(f, schema_name, data)

    data = get_domains_are(cursor, schema_name)
    write_domains_are(f, schema_name, data)

    data = get_enums_are(cursor, schema_name)
    write_enums_are(f, schema_name, data)

    data = get_operators_are(cursor, schema_name)
    write_operators_are(f, schema_name, data)

    data = get_extensions_are(cursor, schema_name)
    write_extensions_are(f, data, schema_name)

    write_tests_footer(f)
